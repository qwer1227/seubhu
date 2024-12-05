package store.seub2hu2.message.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import store.seub2hu2.community.view.FileDownloadView;
import store.seub2hu2.message.dto.MessageForm;
import store.seub2hu2.message.dto.MessageReceived;
import store.seub2hu2.message.service.MessageService;
import store.seub2hu2.message.vo.Message;
import store.seub2hu2.security.user.LoginUser;
import store.seub2hu2.util.ListDto;

import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/message")
public class MessageController {

    @Value("C:/Users/jhta/Desktop/MessageFiles")
    private String saveDirectory;

    private final MessageService messageService;
    private final FileDownloadView fileDownloadView;

    @Autowired
    public MessageController(MessageService messageService, FileDownloadView fileDownloadView) {
        this.messageService = messageService;
        this.fileDownloadView = fileDownloadView;
    }

    // 받은 메시지 목록 조회
    @GetMapping("/list")
    public String receivedList(
            @RequestParam(name = "page", required = false, defaultValue = "1") int page,
            @RequestParam(name = "rows", required = false, defaultValue = "10") int rows,
            @RequestParam(name = "opt", required = false) String opt,
            @RequestParam(name = "keyword", required = false) String keyword,
            @AuthenticationPrincipal LoginUser loginUser,
            Model model
    ) {
        int userNo = loginUser.getNo();  // 로그인된 사용자 번호

        // 검색 조건 및 페이지 설정
        Map<String, Object> condition = buildCondition(page, rows, opt, keyword, userNo);

        // 받은 메시지 목록 조회
        ListDto<MessageReceived> dto = messageService.getReceivedMessages(condition, opt, keyword);

        // unread message count 가져오기
        int unreadCount = messageService.getUnreadMessageCount(userNo);

        // 모델에 데이터 추가
        model.addAttribute("unreadCount", unreadCount);
        model.addAttribute("messages", dto.getData());
        model.addAttribute("paging", dto.getPaging());

        return "message/message-received-list";
    }

    // 보낸 메시지 목록 조회
    @GetMapping("/sent")
    public String sentList(
            @RequestParam(name = "page", required = false, defaultValue = "1") int page,
            @RequestParam(name = "rows", required = false, defaultValue = "10") int rows,
            @RequestParam(name = "opt", required = false) String opt,
            @RequestParam(name = "keyword", required = false) String keyword,
            @AuthenticationPrincipal LoginUser loginUser,
            Model model
    ) {
        int userNo = loginUser.getNo();  // 로그인된 사용자 번호

        // 검색 조건 및 페이지 설정
        Map<String, Object> condition = buildCondition(page, rows, opt, keyword, userNo);

        // 보낸 메시지 목록 조회
        ListDto<MessageReceived> dto = messageService.getSentMessages(condition, opt, keyword);

        // 모델에 데이터 추가
        model.addAttribute("messages", dto.getData());
        model.addAttribute("paging", dto.getPaging());

        return "message/message-sent-list";
    }

    // 공통 조건 설정 메소드
    private Map<String, Object> buildCondition(int page, int rows, String opt, String keyword, int userNo) {
        Map<String, Object> condition = new HashMap<>();
        condition.put("page", page);
        condition.put("rows", rows);
        condition.put("userNo", userNo);
        if (StringUtils.hasText(keyword)) {
            condition.put("opt", opt);
            condition.put("keyword", keyword);
        }
        return condition;
    }


    // 메시지 상세 조회
    @GetMapping("/detail")
    public String detail(
            @RequestParam("messageNo") int messageNo,
            @AuthenticationPrincipal LoginUser loginUser,
            Model model) {
        int userNo = loginUser.getNo();  // 로그인된 사용자 번호
        Message message = messageService.getMessageDetail(messageNo);

        model.addAttribute("message", message);
        model.addAttribute("userNo", userNo); // userNo를 model에 추가

        return "message/message-detail";  // JSP 경로
    }

    // 메시지 삭제
    @GetMapping("/delete")
    public String delete(@RequestParam("messageNo") int messageNo) {
        messageService.deleteMessage(messageNo);
        return "redirect:/message/list";  // 삭제 후 목록 페이지로 이동
    }

    //메세지 보내기
    @PostMapping("/add")
    public String addMessage(MessageForm form, @AuthenticationPrincipal LoginUser loginUser) {
        messageService.sendMessage(form, loginUser.getNo());

        return "redirect:sent";
    }

    // 파일 다운로드 요청
    @GetMapping("/filedown")
    public ModelAndView downloadFile(@RequestParam("messageNo") int messageNo) {
        ModelAndView mav = new ModelAndView(fileDownloadView);
        // 파일 경로 설정 및 ModelAndView에 데이터 전달
        mav.addObject("messageNo", messageNo);
        return mav;
    }
}
