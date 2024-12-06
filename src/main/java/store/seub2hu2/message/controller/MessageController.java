package store.seub2hu2.message.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import store.seub2hu2.community.view.FileDownloadView;
import store.seub2hu2.message.dto.MessageForm;
import store.seub2hu2.message.dto.MessageReceived;
import store.seub2hu2.message.service.MessageService;
import store.seub2hu2.message.vo.Message;
import store.seub2hu2.security.user.LoginUser;
import store.seub2hu2.util.ListDto;

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
            @RequestParam(name = "opt", required = false) String opt,
            @RequestParam(name = "keyword", required = false) String keyword,
            @AuthenticationPrincipal LoginUser loginUser,
            Model model
    ) {
        int userNo = loginUser.getNo();  // 로그인된 사용자 번호

        // 받은 메시지 목록 조회
        ListDto<MessageReceived> dto = messageService.getReceivedMessages(page, rows, opt, keyword, userNo);

        // 모델에 데이터 추가
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

        // 보낸 메시지 목록 조회
        ListDto<MessageReceived> dto = messageService.getSentMessages(page, rows, opt, keyword, userNo);

        // 모델에 데이터 추가
        model.addAttribute("messages", dto.getData());
        model.addAttribute("paging", dto.getPaging());

        return "message/message-sent-list";
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


    // 메시지 삭제
    @PostMapping("/delete")
    public String deleteMessage(
            @RequestParam("messageNo") int messageNo,
            @AuthenticationPrincipal LoginUser loginUser,
            RedirectAttributes redirectAttributes) {
        try {
            messageService.deleteMessages(messageNo);
            redirectAttributes.addFlashAttribute("message", "메시지가 삭제되었습니다.");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "메시지 삭제에 실패했습니다.");
        }
        return "redirect:/message/list";  // 메시지 목록 페이지로 리다이렉트
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
