package store.seub2hu2.chatbot.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.socket.config.annotation.EnableWebSocket;
import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;
import org.springframework.web.socket.server.support.HttpSessionHandshakeInterceptor;
import store.seub2hu2.chatbot.ChatBotHandler;

@Configuration
@EnableWebSocket
public class ChatbotConfig implements WebSocketConfigurer {

    @Autowired
    ChatBotHandler chatBotHandler;

    @Override
    public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) {
        registry.addHandler(chatBotHandler, "/chat").withSockJS().setInterceptors(new HttpSessionHandshakeInterceptor());
    }
}