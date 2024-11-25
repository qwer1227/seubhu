package store.seub2hu2.chatbot;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.stereotype.Service;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;
import store.seub2hu2.chatbot.vo.ChatMessage;

import java.util.*;

@Service
public class ChatBotHandler extends TextWebSocketHandler {

    private ObjectMapper objectMapper = new ObjectMapper();
    // 채팅룸(상담중인 직원과 고객을 포함한다.)
    private Map<String, Map<String, WebSocketSession>> chatRooms = Collections.synchronizedMap(new HashMap<>());
    // 상담대기중인 직원
    private Map<String, WebSocketSession> waitingEmployeeSessions = Collections.synchronizedMap(new HashMap<>());
    // 상담페이지에 접속한 고객
    private Map<String, WebSocketSession> customerSessions = Collections.synchronizedMap(new HashMap<>());

    // 웹 소켓 연결요청이 완료되면 실행되는 메소드다.
    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
        String loginId = (String) session.getAttributes().get("LOGIN_ID");
        String loginType = (String) session.getAttributes().get("LOGIN_TYPE");

        if ("고객".equals(loginType)) {
            customerSessions.put(loginId, session);
        } else if ("직원".equals(loginType)) {
            waitingEmployeeSessions.put(loginId, session);
        }
    }

    // 클라이언트로부터 웹소켓으로 메세지를 수신하면 실행되는 메소드다.
    @Override
    protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
        ChatMessage chatMessage = objectMapper.readValue(message.getPayload(), ChatMessage.class);

        String cmd = chatMessage.getCmd();
        if ("chat-open".equals(cmd)) {
            openChatRoom(session, chatMessage);
        } else if ("chat-close".equals(cmd)) {
            closeChatRoom(session, chatMessage);
        } else if ("chat-message".equals(cmd)) {
            chatting(session, chatMessage);
        }
    }

    // 클라이언트와 웹 소켓 연결이 종료되면 실행되는 메소드다.
    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
        removeWebSocketSession(session);
    }

    // 클라이언트와 웹 소켓을 통해서 메세지 교환 중 오류가 발생하면 실행되는 메소드다.
    @Override
    public void handleTransportError(WebSocketSession session, Throwable exception) throws Exception {
        removeWebSocketSession(session);
    }

    private void openChatRoom(WebSocketSession session, ChatMessage chatMessage) throws Exception {
        String customerId = chatMessage.getCustomerId();

        if (waitingEmployeeSessions.isEmpty()) {
            ChatMessage responseMessage = new ChatMessage();
            responseMessage.setCmd("chat-error");
            responseMessage.setText("대기중인 상담직원이 없습니다.");
            session.sendMessage(new TextMessage(objectMapper.writeValueAsBytes(responseMessage)));

        } else {
            String uuid = UUID.randomUUID().toString();
            String employeeId = waitingEmployeeSessions.keySet().stream().findFirst().get();
            WebSocketSession employeeSession = waitingEmployeeSessions.get(employeeId);

            Map<String, WebSocketSession> chatRoom = new HashMap<>();
            chatRoom.put(customerId, session);
            chatRoom.put(employeeId, employeeSession);
            waitingEmployeeSessions.remove(employeeId);
            chatRooms.put(uuid, chatRoom);

            ChatMessage responseMessage = new ChatMessage();
            responseMessage.setCmd("chat-open-success");
            responseMessage.setRoomId(uuid);
            responseMessage.setCustomerId(customerId);
            responseMessage.setEmployeeId(employeeId);
            responseMessage.setText("대기중인 상담직원과 연결되었습니다.");
            session.sendMessage(new TextMessage(objectMapper.writeValueAsBytes(responseMessage)));

            responseMessage.setText("대기중인 고객과 연결되었습니다.");
            employeeSession.sendMessage(new TextMessage(objectMapper.writeValueAsBytes(responseMessage)));
        }
    }

    private void closeChatRoom(WebSocketSession session, ChatMessage chatMessage) throws Exception {
        String roomId = chatMessage.getRoomId();
        String employeeId = chatMessage.getEmployeeId();

        Map<String, WebSocketSession> chatRoom = chatRooms.get(roomId);
        WebSocketSession employeeSession = chatRoom.get(employeeId);
        waitingEmployeeSessions.put(employeeId, employeeSession);
        chatRooms.remove(roomId);

        ChatMessage responseMessage = new ChatMessage();
        responseMessage.setCmd("chat-close-success");
        responseMessage.setText("상담직원과 상담이 종료되었습니다.");
        session.sendMessage(new TextMessage(objectMapper.writeValueAsBytes(responseMessage)));
    }

    private void chatting(WebSocketSession session, ChatMessage chatMessage) throws Exception {
        String roomId = chatMessage.getRoomId();
        String customerId = chatMessage.getCustomerId();
        String employeeId = chatMessage.getEmployeeId();
        String senderType = chatMessage.getSenderType();

        Map<String, WebSocketSession> chatRoom = chatRooms.get(roomId);
        if ("고객".equals(senderType)) {
            chatRoom.get(employeeId).sendMessage(new TextMessage(objectMapper.writeValueAsBytes(chatMessage)));
        } else if ("직원".equals(senderType)) {
            chatRoom.get(customerId).sendMessage(new TextMessage(objectMapper.writeValueAsBytes(chatMessage)));
        }
    }

    private void removeWebSocketSession(WebSocketSession session) throws Exception {
        String loginId = (String) session.getAttributes().get("LOGIN_ID");
        String loginType = (String) session.getAttributes().get("LOGIN_TYPE");

        if ("고객".equals(loginType)) {
            customerSessions.remove(loginId);
        } else if ("직원".equals(loginType)) {
            waitingEmployeeSessions.remove(loginId);
        }
        destoryChatRoom(loginId);
    }

    private void destoryChatRoom(String loginId) {
        Set<String> roomIdSet = chatRooms.keySet();
        Iterator<String> iterator = roomIdSet.iterator();
        while (iterator.hasNext()) {
            String roomId = iterator.next();
            Map<String, WebSocketSession> chatRoom = chatRooms.get(roomId);
            if (chatRoom.containsKey(loginId)) {
                chatRoom.remove(loginId);
                chatRooms.remove(roomId);
            };
        }
    }
}