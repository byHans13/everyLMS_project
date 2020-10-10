package com.icia.ws;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;


@Controller
public class WsController {
	
	@Autowired
	MessageWebSocketHandler handler;
	
	
	
	//h2k5every/stud/webTest
	@RequestMapping(value = "/stud/web")
	public String web() {
		return "webTest";
	}
	
	
	@RequestMapping(value = "/stud/webTest")
	public String webTest(@RequestParam("receiver")String receiver, @RequestParam("msg")String msg, HttpSession session) {
		String username = session.getAttribute("id").toString();
		System.out.println("---------------controller------------");
		System.out.println("+username"+username);
		System.out.println("receiver: "+receiver);
		System.out.println("msg: "+msg);
		handler.sendMessage(username, receiver, msg);
		return "webTest";
	}
	
	
	
	
	///h2k5every/prof/rest/sendMsgWeb
	

	
	
	
	
	
	

}
