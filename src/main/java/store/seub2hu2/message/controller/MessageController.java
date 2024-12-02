package store.seub2hu2.message.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
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

import java.io.File;
import java.io.FileNotFoundException;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/message")
public class MessageController {

    @Value("C:/Users/jhta/Desktop/MessageFiles")
    private String saveDirectory;

    @Autowired
    public MessageService messageService;

    @Autowired
    public FileDownloadView fileDownloadView;

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

        //MessageForm message = messageService.getMessageDetail(messageNo);  // userNo는 필요 없으면 삭제
        //model.addAttribute("message", message);
        //model.addAttribute("userNo", userNo);  // userNo를 model에 추가
        return "message/message-detail";
    }

    @GetMapping("/send")
    public String showSendForm(@AuthenticationPrincipal LoginUser loginUser, Model model) {
        // 로그인된 사용자 정보에서 보낸 사람을 구성
        String sender = loginUser.getNickname() + " <" + loginUser.getId() + ">";

        // 기본적으로 받는 사람은 빈 값으로 설정
        String receiver = ""; // 기본값 설정

        model.addAttribute("sender", sender);
        model.addAttribute("receiver", receiver); // receiver 값 전달

        return "message/message-send-form";  // JSP 경로
    }


    @PostMapping("/send")
    public String submitMessage(@AuthenticationPrincipal LoginUser loginUser,
                                @ModelAttribute MessageForm form,
                                @RequestParam(value = "file", required = false) MultipartFile file,
                                RedirectAttributes redirectAttributes) {
        try {
            // 작성자의 사용자 번호를 MessageForm에 설정
            form.setSenderUserNo(loginUser.getNo());

            // 서비스 호출
            messageService.insertMessage(form, file);

            redirectAttributes.addFlashAttribute("success", "쪽지가 성공적으로 등록되었습니다.");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "쪽지 등록에 실패했습니다.");
            e.printStackTrace(); // 디버깅용 로그
        }
        return "redirect:/message/list"; // 작성 후 목록 페이지로 이동
    }



    @GetMapping("/delete")
    public String delete(@RequestParam("messageNo") int messageNo) {
        MessageForm form = new MessageForm();
        form.setMessageNo(messageNo);
        messageService.deleteMessage(messageNo);
        return "redirect:message/message-list";
    }

    // 파일 다운로드 요청 (ModelAndView 사용)
    @GetMapping("/filedown")
    public ModelAndView downloadFile(@RequestParam("messageNo") int messageNo,
                                     @AuthenticationPrincipal LoginUser loginUser) {

        // 메시지 상세 조회 (messageNo만 전달)
        //MessageForm message = messageService.getMessageDetail(messageNo);

        // 파일이 존재하지 않으면 오류 처리
        //if (message.getMessageFile() == null || message.getMessageFile().getSavedName() == null) {
        //    throw new IllegalArgumentException("첨부파일이 존재하지 않습니다.");
        //}

        // 파일 다운로드 설정
        ModelAndView mav = new ModelAndView(fileDownloadView);
        //String filePath = saveDirectory + File.separator + message.getMessageFile().getSavedName();  // 파일 경로 설정
        //mav.addObject("filePath", filePath);  // 실제 경로 전달
        //mav.addObject("filename", message.getMessageFile().getOriginalName());  // 파일 이름

        return mav;
    }
}

