package com.icia.isTestTaker;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.icia.lectureQuiz.LectureQuiz;

@RestController
@RequestMapping(value = "prof/rest")
public class isTestTakerRestController {
	@Autowired
	isTestTakerMM im;
	
	ModelAndView mav;
	
	@PostMapping(value = "selectIsTestTaker", produces = "application/json;charset=utf-8")
	public String selectIsTestTaker() {
		System.out.println("시험 응시 미응시 관리");		
		SecurityContext context = SecurityContextHolder.getContext();
		User user = (User) context.getAuthentication().getPrincipal();
		System.out.println(user.getUsername());
		String id= user.getUsername();
			List<isTestTaker> qlsit=im.selectIsTestTaker(id);
			String Json = new Gson().toJson(qlsit);

			return Json;
	}
	
	@RequestMapping(value = "selectboxIsTestTaker", produces = "application/json;charset=utf-8")
	public String selectboxIsTestTaker(@RequestParam("cont") String cont,@RequestParam("box") String box,
										HttpSession session) {
		System.out.println("시험 응시 미응시 검색");
		SecurityContext context = SecurityContextHolder.getContext();
		User user = (User) context.getAuthentication().getPrincipal();
		System.out.println(user.getUsername());
		String id= user.getUsername();
		
		List<isTestTaker> qlsit=im.selectboxIsTestTaker(id,cont,box);
		String Json = new Gson().toJson(qlsit);
			
			
		return Json;
	}
	
	@RequestMapping(value = "isTestTakerSelect", produces = "application/json;charset=utf-8")
	public String selectIsTestTaker(@RequestParam("cl_idnum")String cl_idnum,
									@RequestParam("gr_num") Integer gr_num) {
		System.out.println("응시 미응시 전체검색");
		
		System.out.println(cl_idnum);
		System.out.println(gr_num);
		
		List<isTestTaker> list= im.isTestTakerSelect(cl_idnum,gr_num);
		String Json = new Gson().toJson(list);
		
		
		return Json;
	}
}
