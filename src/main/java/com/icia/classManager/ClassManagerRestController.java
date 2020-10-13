package com.icia.classManager;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.icia.classup.ClassUpBean;
import com.icia.classup.ClassUpMM;

@RestController
public class ClassManagerRestController {
//rest/classuploadmanagerpage
	@Autowired
	private ClassManagerMM cmm;
	
		@RequestMapping(value = "/prof/rest/classuploadmanagerpage",produces = {"text/plain;charset=utf-8", "application/json;charset=utf-8"})
		public String classList(HttpSession session) {
			List<ClassUpBean> manager_classList =cmm.selectClass(session);
			//"manager_classList" ,new Gson().toJson(cmm.selectClass(session))
			 return new Gson().toJson(manager_classList);
			
		
		
}
}
