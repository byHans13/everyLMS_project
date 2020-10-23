package com.icia.ws;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class WsRestController {
	
	@Autowired
	MessageWebSocketHandler handler;
	
	
	@RequestMapping(value = "/prof/rest/sendMsgWeb")
	public void webTest(@RequestParam("receiver")String receiver, @RequestParam("msg")String msg, HttpSession session) {
		String username = session.getAttribute("id").toString();
		handler.sendMessage(username, receiver, msg);
	}
	
	

}
