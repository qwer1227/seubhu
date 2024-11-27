package store.seub2hu2.user.controller;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import store.seub2hu2.user.dto.MailDTO;
import store.seub2hu2.user.exception.DataNotFoundException;
import store.seub2hu2.user.service.MailService;
import store.seub2hu2.user.service.UserService;

@Controller
@RequiredArgsConstructor
public class FindController {

    private final MailService mailService;

    // 아이디 찾기 폼
    @GetMapping("/find-id")
    public String findIdForm(Model model) {
        return "user/find-id"; // 아이디 찾기 페이지로 이동
    }

    // 이메일로 아이디 찾기 처리
    @PostMapping("/find-id")
    public String findId(@RequestParam("email") String email, Model model) {
        try {
            // 이메일로 사용자 확인 후 아이디 발급
            String userId = mailService.findIdByEmail(email);

            if (userId != null) {
                model.addAttribute("message", "아이디는: " + userId);
            } else {
                model.addAttribute("message", "이메일과 일치하는 아이디가 없습니다.");
            }
        } catch (Exception e) {
            model.addAttribute("message", "아이디 찾기 실패: " + e.getMessage());
        }

        return "user/find-id";  // 결과 메시지와 함께 다시 폼 렌더링
    }


    // 비밀번호 찾기 폼
    @GetMapping("/find-password")
    public String findPasswordForm(Model model) {
        model.addAttribute("mailDTO", new MailDTO());
        return "user/find-password";
    }

    // 비밀번호 찾기 요청 처리
    /**
     * 임시 비밀번호 발급
     */
    @PostMapping("/find-password")
    public ResponseEntity<String> updatePassword(@RequestBody MailDTO mailDTO) {
        String id = mailDTO.getId();
        String email = mailDTO.getEmail();

        try {
            // 사용자 확인 및 임시 비밀번호 발급
            mailService.updatePassword(id, email);  // 서비스 메서드 호출
            return ResponseEntity.ok("임시 비밀번호가 이메일로 발송되었습니다.");
        } catch (DataNotFoundException e) {
            return ResponseEntity.badRequest().body("아이디와 이메일이 일치하는 사용자가 없습니다.");
        } catch (Exception e) {
            return ResponseEntity.status(500).body("임시 비밀번호 발급 실패: " + e.getMessage());
        }
    }

    /**
     * 이메일 인증 요청
     */
    @PostMapping("/emailCheck")
    public ResponseEntity<String> emailCheck(@RequestBody MailDTO mailDTO, HttpSession session) {
        String email = mailDTO.getEmail();
        try {
            String authCode = mailService.sendAuthCodeToEmail(email); // 서비스 메서드 호출

            // 인증 코드를 세션에 저장
            session.setAttribute("authCode", authCode);

            return ResponseEntity.ok("인증 코드가 이메일로 전송되었습니다.");
        } catch (IllegalArgumentException e) {
            return ResponseEntity.badRequest().body("유효하지 않은 이메일 주소입니다.");
        } catch (Exception e) {
            return ResponseEntity.status(500).body("인증 코드 전송 실패: " + e.getMessage());
        }
    }

    /**
     * 인증 코드 검증
     */
    @PostMapping("/verifyCode")
    public ResponseEntity<String> verifyCode(@RequestParam String authCode, HttpSession session) {
        String storedCode = (String) session.getAttribute("authCode");

        if (storedCode != null && storedCode.equals(authCode)) {
            return ResponseEntity.ok("인증 성공");
        }
        return ResponseEntity.badRequest().body("인증 실패");
    }

}
