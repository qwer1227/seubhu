package store.seub2hu2.user.service;

import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import java.util.UUID;

@Service
public class UserEmailService {

    private final JavaMailSender mailSender;

    public UserEmailService(JavaMailSender mailSender) {
        this.mailSender = mailSender;
    }

    // 인증번호 생성
    public String generateAuthCode() {
        return UUID.randomUUID().toString().substring(0, 6).toUpperCase();
    }

    // 이메일 발송
    public void sendEmail(String to, String subject, String text) {
        try {
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, "utf-8");
            helper.setTo(to);
            helper.setSubject(subject);
            helper.setText(text, false); // HTML 사용 시 true로 변경 가능
            mailSender.send(message);
        } catch (MessagingException e) {
            throw new IllegalStateException("이메일 발송 실패", e);
        }
    }
}

