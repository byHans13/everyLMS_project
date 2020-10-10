package com.icia.ws;

import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;
import org.springframework.web.socket.*;
import org.springframework.web.socket.handler.*;

// 웹 소켓 : 양방향 통신
// 메모를 보낸다 - ajax. 서버의 메시지 수신 - websocket



@Component
public class MessageWebSocketHandler extends TextWebSocketHandler {
	@Autowired
	private WSUserService WebScoketService;
	
	// 웹 소켓 연결을 생성
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		WebScoketService.add(session);
		System.out.println("session: "+session);
	}
	// 웹소켓 세션 종료 : 화면을 닫은 경우
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		WebScoketService.delete(session);
	}
	
	
	// 클라에서 메시지를 보냈을 때 : handleTextMessage() 
	public void sendMessage(String sender, String receiver, String msg) {
		WebScoketService.sendMsg(sender, receiver, msg);
	}
	
	public void sendServerMessage(String sender, String msg) {
		WebScoketService.sendMsgAll(sender, msg);
	}	
}
