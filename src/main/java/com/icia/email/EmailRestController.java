package com.icia.email;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;

@RestController
@RequestMapping(value = "/rest")
public class EmailRestController {
	@Autowired
	EmailMM emm;
	
	ModelAndView mav;
	
	@RequestMapping(value = "checkNumSend", produces = "application/json;charset=utf-8")
	public String checkNumSend(Email em , String email) {
		System.out.println("인증번호 발송페이지");
		System.out.println(email);
		List list=emm.checkNumSend(em,email);
		String json=new Gson().toJson(list);
		
		return json;
	}
}
