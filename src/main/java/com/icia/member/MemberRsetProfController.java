package com.icia.member;

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
@RequestMapping(value = "/prof/rest")
public class MemberRsetProfController {
	@Autowired
	MemberMM mm;
	
	ModelAndView mav;
	
	@RequestMapping(value = "selectConcern", produces = "application/json;charset=utf-8")
	public String selectConcern(Member mb,HttpSession session) {
		SecurityContext context = SecurityContextHolder.getContext();
		User user = (User) context.getAuthentication().getPrincipal();
		mb.setMb_id(user.getUsername());
		System.out.println("marA"+user.getUsername());
		
		List<String> list=mm.selectConcern(mb);
		System.out.println(list);
		String json=new Gson().toJson(list);
		
		return json;
	}
	
	@RequestMapping(value = "idclick", produces = "application/json;charset=utf-8")
	public int idclick(@RequestParam("id") String id ) {
		int cnt=mm.selectIdclick(id);
		
		return cnt;
	}
	
//	@RequestMapping(value = "checkNumSend", produces = "application/json;charset=utf-8")
//	public String checkNumSend(Email em , String email) {
//		System.out.println("인증번호 발송페이지");
//		System.out.println(email);
//		List list=mm.checkNumSend(em,email);
//		String json=new Gson().toJson(list);
//		
//		return json;
//	}
}
