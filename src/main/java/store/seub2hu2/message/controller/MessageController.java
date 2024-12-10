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
import org.springframework.web.servlet.ModelAndView;
import store.seub2hu2.community.view.FileDownloadView;
import store.seub2hu2.message.dto.MessageForm;
import store.seub2hu2.message.dto.MessageReceived;
import store.seub2hu2.message.service.MessageService;
import store.seub2hu2.message.vo.Message;
import store.seub2hu2.security.user.LoginUser;
import store.seub2hu2.util.ListDto;

import java.io.File;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/message")
public class MessageController {

    @Value("C:/Users/jhta/Desktop/MessageFiles")
    private String saveDirectory;

    @Autowired
    private MessageService messageService;

    @Autowired
    private FileDownloadView fileDownloadView;

    // 받은 메시지 목록 조회
    @GetMapping("/list")
    public String receivedList(
            @RequestParam(name = "page", required = false, defaultValue = "1") int page,
            @RequestParam(name = "rows", required = false, defaultValue = "10") int rows,
            @RequestParam(name = "sort", required = false, defaultValue = "desc") String sort,
            @RequestParam(name = "opt", required = false) String opt,
            @RequestParam(name = "keyword", required = false) String keyword,
            @AuthenticationPrincipal LoginUser loginUser,
            Model model) {

        Map<String, Object> condition = new HashMap<>();
        condition.put("page", page);
        condition.put("rows", rows);
        condition.put("sort", sort);
        condition.put("userNo", loginUser.getNo());  // 로그인된 사용자 번호


        if (StringUtils.hasText(keyword)) {
            condition.put("opt", opt);
            condition.put("keyword", keyword);
        }

        // 받은 메시지 목록 조회
        ListDto<MessageReceived> dto = messageService.getReceivedMessages(condition);

        // 모델에 데이터 추가
        model.addAttribute("messages", dto.getData());
        model.addAttribute("paging", dto.getPaging());
        model.addAttribute("condition", condition); // 검색 조건도 모델에 포함 (필요 시 사용)


        return "message/message-received-list";
    }

    // 보낸 메시지 목록 조회
    @GetMapping("/sent")
    public String sentList(
            @RequestParam(name = "page", required = false, defaultValue = "1") int page,
            @RequestParam(name = "rows", required = false, defaultValue = "10") int rows,
            @RequestParam(name = "sort", required = false, defaultValue = "date") String sort, // 기본값 변경
            @RequestParam(name = "opt", required = false) String opt,
            @RequestParam(name = "keyword", required = false) String keyword,
            @AuthenticationPrincipal LoginUser loginUser,
            Model model) {

        // 검색 조건 수집
        Map<String, Object> condition = new HashMap<>();
        condition.put("page", page);
        condition.put("rows", rows);
        condition.put("sort", sort);
        condition.put("userNo", loginUser.getNo()); // 로그인된 사용자 번호

        // 검색 조건 추가 (유효성 검증 포함)
        if (StringUtils.hasText(keyword)) {
            condition.put("opt", opt);
            condition.put("keyword", keyword);
        }

        // 메시지 목록 조회
        ListDto<MessageReceived> dto = messageService.getSentMessages(condition);

        // 모델에 데이터 추가
        model.addAttribute("messages", dto.getData());
        model.addAttribute("paging", dto.getPaging());
        model.addAttribute("condition", condition); // 검색 조건도 모델에 포함 (필요 시 사용)

        return "message/message-sent-list";
    }

    @GetMapping("/detail")
    public String detail(
            @RequestParam("messageNo") int messageNo,
            @AuthenticationPrincipal LoginUser loginUser,
            Model model) {
        int userNo = loginUser.getNo();  // 로그인된 사용자 번호

        // 메시지 읽음 처리
        //messageService.markAsRead(messageNo, userNo);

        // 메시지 상세 조회
        Message message = messageService.getMessageDetail(messageNo);

        model.addAttribute("message", message);
        model.addAttribute("userNo", userNo);  // userNo를 model에 추가

        return "message/message-detail";  // JSP 경로
    }




    // 쪽지 작성 폼 화면 반환
    @GetMapping("/add")
    public String showAddMessageForm(Model model, @AuthenticationPrincipal LoginUser loginUser) {
        // 작성자 닉네임 설정
        String senderNickname = loginUser.getNickname(); // LoginUser 객체에서 닉네임 가져오기

        // Model에 데이터 추가
        model.addAttribute("sender", senderNickname); // JSP에서 ${sender}로 사용 가능

        // 초기 MessageForm 객체 추가 (필요 시)
        model.addAttribute("messageForm", new MessageForm());

        return "message/message-send-form"; // JSP 파일 경로
    }

    //메세지 보내기
    @PostMapping("/add")
    public String addMessage(MessageForm form, @AuthenticationPrincipal LoginUser loginUser) {
        messageService.sendMessage(form, loginUser.getNo());
        return "redirect:/message/list"; // 메시지 보내기 후 받은 메시지 목록으로 리다이렉트
    }


    // 개별 삭제
    @PostMapping("/delete")
    public String deleteMessage(@RequestParam("messageNo") int messageNo) {
        messageService.deleteMessage(messageNo);
        return "redirect:/message/sent";
    }

    // 일괄 삭제
    @PostMapping("/deleteMultiple")
    public String deleteMessages(@RequestParam("messageNos") List<Integer> messageNos) {
        messageService.deleteMessages(messageNos);
        return "redirect:/message/sent";
    }

    @GetMapping("/markAsRead")
    public String markAsRead(@RequestParam("messageNo") int messageNo, @AuthenticationPrincipal LoginUser loginUser) {
        int userNo = loginUser.getNo();  // 로그인된 사용자 번호

        // 읽음 처리
        messageService.markAsRead(messageNo, userNo);

        // 메시지 목록으로 리디렉션
        return "redirect:/message/detail?messageNo=" + messageNo;
    }


    @PostMapping("/markMultipleAsRead")
    public String markMultipleAsRead(@RequestParam("messageNos") List<Integer> messageNos) {
        messageService.markMultipleAsRead(messageNos);
        return "redirect:/message/list";
    }

    // 파일 다운로드 요청
    // 요청 URL : comm/filedown?no=xxx
    @GetMapping("/filedown")
    public ModelAndView download(@RequestParam("no") int messageNo) {

        // isSent 값을 false로 설정 (받은 메시지라고 가정)
        Message message = messageService.getMessageDetail(messageNo);

        ModelAndView mav = new ModelAndView();

        mav.setView(fileDownloadView);
        mav.addObject("directory", saveDirectory);
        mav.addObject("filename", message.getMessageFile().getSavedName());
        mav.addObject("originalFilename", message.getMessageFile().getOriginalName());

        return mav;
    }

    @GetMapping("/download")
    public ResponseEntity<Resource> downloadFile(int messageNo) throws Exception{

        // isSent 값을 false로 설정 (받은 메시지라고 가정)
        Message message = messageService.getMessageDetail(messageNo);

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
