package store.seub2hu2.chatbot.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;
import store.seub2hu2.chatbot.dto.ChatReq;
import store.seub2hu2.chatbot.dto.ChatRes;
import store.seub2hu2.chatbot.dto.TrainReq;
import store.seub2hu2.chatbot.dto.TrainRes;
import store.seub2hu2.chatbot.service.ChatService;

@RestController
@RequiredArgsConstructor
public class ChatApiController {

    private final ChatService chatService;

    /**
     * NLP 기반 응답 생성
     */
    @PostMapping("/chat")
    public ChatRes chat(@RequestBody ChatReq req) throws Exception {
        return chatService.generateResponse(req);
    }

    /**
     * 데이터 학습
     */
    @PostMapping("/train")
    public TrainRes train(@RequestBody TrainReq req) throws Exception {
        return chatService.trainModel(req);
    }

}