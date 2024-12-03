package store.seub2hu2.message.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import store.seub2hu2.community.view.FileDownloadView;
import store.seub2hu2.message.dto.MessageForm;
import store.seub2hu2.message.dto.MessageRecieved;
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
        ListDto<MessageRecieved> dto = messageService.getReceivedMessages(condition, opt, keyword);

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
        ListDto<MessageRecieved> dto = messageService.getSentMessages(condition, opt, keyword);

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




    // 메시지 보내기 폼
    @GetMapping("/send")
    public String showSendForm(@AuthenticationPrincipal LoginUser loginUser, Model model) {
        String sender = loginUser.getNickname() + " <" + loginUser.getId() + ">";
        String receiver = "";  // 기본값 설정

        model.addAttribute("sender", sender);
        model.addAttribute("receiver", receiver); // receiver 값 전달

        return "message/message-send-form";  // JSP 경로
    }

    // 메시지 보내기 처리
    @PostMapping("/send")
    public String submitMessage(@AuthenticationPrincipal LoginUser loginUser,
                                @ModelAttribute MessageForm form,
                                @RequestParam(value = "file", required = false) MultipartFile file,
                                RedirectAttributes redirectAttributes) {
        try {
            form.setSenderUserNo(loginUser.getNo());  // 작성자 사용자 번호 설정
            messageService.insertMessage(form, file);  // 메시지 저장

            redirectAttributes.addFlashAttribute("success", "쪽지가 성공적으로 등록되었습니다.");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "쪽지 등록에 실패했습니다.");
            e.printStackTrace();  // 디버깅용 로그
        }
        return "redirect:/message/list";  // 목록 페이지로 이동
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
