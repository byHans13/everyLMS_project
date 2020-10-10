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
	public boolean upDateSt(HttpSession session, @RequestParam("msg_id")String msg_id) {
		boolean result = mmm.upDateSt(session,msg_id);

		return result;
	}
	
	
	
	
	
	
	
//	
//	@RequestMapping(value = "/rest/idclick", produces = "application/json;charset=utf-8")
//	public int idclick(@RequestParam("id") String id ) {
//		int cnt=mm.selectIdclick(id);
//		
//		return cnt;
//	}
//	
////	@RequestMapping(value = "checkNumSend", produces = "application/json;charset=utf-8")
////	public String checkNumSend(Email em , String email) {
////		System.out.println("인증번호 발송페이지");
////		System.out.println(email);
////		List list=mm.checkNumSend(em,email);
////		String json=new Gson().toJson(list);
////		
////		return json;
////	}
//	
//	@RequestMapping(value = "/stud/rest/updateMyinfo")
//	public String updateMyinfo(HttpSession session,String name,String loe) {
//		String result = mm.updateMyinfo(session, name,loe);
//		return result;
//		
//	}
//	@RequestMapping(value = "/stud/rest/goupphone")
//	public boolean goupphone(HttpSession session,String phone) {
//		boolean result = mm.goupphone(session, phone);
//		return result;
//		
//	}
//	
//	@RequestMapping(value = "/stud/rest/goupemailbtn")
//	public boolean goupemailbtn(HttpSession session,String email) {
//		boolean result = mm.goupemailbtn(session, email);
//		return result;
//		
//	}
	
	
}
