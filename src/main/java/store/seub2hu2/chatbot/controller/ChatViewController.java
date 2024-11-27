package store.seub2hu2.chatbot.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
@RequiredArgsConstructor
public class ChatViewController {

    @GetMapping("/bot")
    public String chat(Model model) {
        return "/chat/index";
    }

}