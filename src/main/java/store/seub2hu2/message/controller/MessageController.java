package store.seub2hu2.message.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import store.seub2hu2.community.view.FileDownloadView;
import store.seub2hu2.message.dto.MessageForm;
import store.seub2hu2.message.service.MessageService;
import store.seub2hu2.message.vo.Message;
import store.seub2hu2.security.user.LoginUser;
import store.seub2hu2.util.ListDto;

import java.io.File;
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
    @GetMapping("/received")
    public String receivedList(
            @RequestParam(name = "page", required = false, defaultValue = "1") int page,
            @RequestParam(name = "rows", required = false, defaultValue = "10") int rows,
            @RequestParam(name = "opt", required = false) String opt,
            @RequestParam(name = "keyword", required = false) String keyword,
            @ModelAttribute("loginUser") LoginUser loginUser,  // 세션에서 loginUser를 모델에 바인딩
            Model model
    ) {
        // 로그인된 사용자의 정보가 세션에서 전달됩니다.
        int userNo = loginUser.getNo();  // 세션에서 userNo를 얻음

        Map<String, Object> condition = new HashMap<>();
        condition.put("page", page);
        condition.put("rows", rows);
        condition.put("userNo", userNo);

        if (StringUtils.hasText(keyword)) {
            condition.put("opt", opt);
            condition.put("keyword", keyword);
        }

        // 받은 메시지 목록 조회
        ListDto<Message> dto = messageService.getReceivedMessages(condition);

        // 모델에 메시지 목록과 페이징 정보 추가
        model.addAttribute("messages", dto.getData());
        model.addAttribute("paging", dto.getPaging());

        return "message/message-received-list";  // 받은 메시지 목록 JSP로 리턴
    }


    // 보낸 메시지 목록 조회
    @GetMapping("/sent")
    public String sentList(
            @RequestParam(name = "page", required = false, defaultValue = "1") int page,
            @RequestParam(name = "rows", required = false, defaultValue = "10") int rows,
            @RequestParam(name = "opt", required = false) String opt,
            @RequestParam(name = "keyword", required = false) String keyword,
            @RequestParam(name = "userNo") int userNo,
            Model model
    ) {
        Map<String, Object> condition = new HashMap<>();
        condition.put("page", page);
        condition.put("rows", rows);
        condition.put("userNo", userNo);

        if (StringUtils.hasText(keyword)) {
            condition.put("opt", opt);
            condition.put("keyword", keyword);
        }

        ListDto<Message> dto = messageService.getSentMessages(condition);

        model.addAttribute("messages", dto.getData());
        model.addAttribute("paging", dto.getPaging());

        return "message/message-sent-list";
    }

    // 메시지 상세 조회
    @GetMapping("/detail")
    public String detail(
            @RequestParam("messageNo") int messageNo,
            @RequestParam("userNo") int userNo,
            Model model
    ) {
        Message message = messageService.getMessageDetail(messageNo, userNo);
        model.addAttribute("message", message);
        return "message/message-detail";
    }

    // 메시지 작성 폼을 반환하는 GET 요청 처리
    @GetMapping("/send")
    public String send() {
        // 메시지 작성 폼을 보여주는 뷰 반환
        return "message/message-send-form";
    }

    // 메시지 전송을 처리하는 POST 요청
    @PostMapping("/send")
    public String sendMessage(@ModelAttribute MessageForm form, @RequestParam("receiverNo") int receiverNo) {
        // form 객체에서 메시지 정보 (제목, 내용, 첨부파일 등)를 가져옴
        // receiverNo는 수신자의 사용자 번호

        // messageService를 호출하여 메시지를 저장하고, 수신자에게 전송
        messageService.insertMessage(form, receiverNo);

        // 메시지 전송 후 메시지 목록 페이지로 리다이렉트
        return "redirect:/message/message-list";  // 메시지 목록 페이지로 리다이렉트
    }


    @GetMapping("/delete")
    public String delete(@RequestParam("messageNo") int messageNo) {
        MessageForm form = new MessageForm();
        form.setMessageNo(messageNo);
        messageService.deleteMessage(messageNo);
        return "redirect:message/message-list";
    }

    // 요청 URL : comm/filedown?no=xxx
    @GetMapping("/filedown")
    public ModelAndView download(@RequestParam("messageNo") int messageNo, @RequestParam("userNo") int userNo) {
        // 두 번째 인자 userNo를 추가해서 메서드를 호출
        Message message = messageService.getMessageDetail(messageNo, userNo);

        ModelAndView mav = new ModelAndView();
        mav.setView(fileDownloadView);
        mav.addObject("directory", saveDirectory);
        mav.addObject("filename", message.getMessageFile().getSavedName());
        mav.addObject("originalFilename", message.getMessageFile().getOriginalName());

        return mav;
    }

    @GetMapping("/download")
    public ResponseEntity<Resource> downloadFile(int messageNo, int userNo) throws Exception {
        Message message = messageService.getMessageDetail(messageNo, userNo);

        String fileName = message.getMessageFile().getSavedName();
        String originalFileName = message.getMessageFile().getOriginalName();
        originalFileName = URLEncoder.encode(originalFileName, "UTF-8");

        File file = new File(new File(saveDirectory), fileName);
        FileSystemResource resource = new FileSystemResource(file);

        return ResponseEntity.ok()
                .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=" + originalFileName)
                .body(resource);
    }


}

