package com.icia.classup;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.google.gson.Gson;

@org.springframework.web.bind.annotation.RestController
public class RestController {
	@Autowired
	private ClassUpMM cm;
	
		@RequestMapping(value = "/prof/rest/classList")
		public String classList(HttpSession session) {
			List<ClassUpBean> classList = cm.classList(session);
			return new Gson().toJson(classList);	
		
	}
		
		@RequestMapping(value = "/prof/rest/goAdmin")
		public String goAdmin(@RequestParam("co_idnum")String idnum) {
			String selectCt = cm.selectCt(idnum);
			if(selectCt.equals("1")) {
				return new Gson().toJson("이미 승인중인 강의입니다.");	
			}else {
				int update = cm.updateGoAdmin(idnum);
				if(update!=0) {
					return new Gson().toJson("관리자에게 보냈습니다.");	
				}
			}
			 return new Gson().toJson("다시 시도 하십시오.");
		
	}
		@RequestMapping(value = "prof/rest/classListVal")
		public String classListVal(@RequestParam("cl_ct")String cl_ct, HttpSession session) {
			List<ClassUpBean> classListVal = cm.getClassList(cl_ct, session);
			return new Gson().toJson(classListVal);
			
		}
		
		
		
		
		
		
		

}
