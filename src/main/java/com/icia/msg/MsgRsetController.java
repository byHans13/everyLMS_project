package com.icia.msg;

import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.request;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.web.bind.annotation.RequestAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.Gson;
import com.icia.email.Email;


@RestController
public class MsgRsetController {
	@Autowired
	MsgMM mmm;

	
	
	@RequestMapping(value = "/prof/rest/sendMsg")
	public boolean sendMsg(HttpSession session, @RequestParam("receiver")String receiver, @RequestParam("msg")String msg) {
		boolean result = mmm.sendMsg(session,receiver,msg);

		return result;
	}
	
	//stud/rest/upDateSt
	@RequestMapping(value = "/stud/rest/upDateSt")
	public boolean upDateSt(HttpSession session, @RequestParam("msg_id")String msg_id, @RequestParam("msg_text")String msg_text) {
		boolean result = mmm.upDateSt(session,msg_id,msg_text);

		return result;
	}
	
	
	
}
