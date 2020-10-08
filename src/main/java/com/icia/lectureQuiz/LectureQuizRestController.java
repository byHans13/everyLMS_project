package com.icia.lectureQuiz;

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
import com.icia.member.Member;

@RestController
@RequestMapping(value = "prof/rest")
public class LectureQuizRestController {
	@Autowired
	LectureQuizMM lm;
	
	ModelAndView mav;
	
	@PostMapping(value = "selectLectureQuiz", produces = "application/json;charset=utf-8")
	public String selectLectureQuiz() {
		System.out.println("강의별 퀴즈관리");		
		SecurityContext context = SecurityContextHolder.getContext();
		User user = (User) context.getAuthentication().getPrincipal();
		System.out.println(user.getUsername());
		String id= user.getUsername();
			List<LectureQuiz> qlsit=lm.selectLectureQuiz(id);
			String Json = new Gson().toJson(qlsit);
			
			
		return Json;
	}
	
	@RequestMapping(value = "selectboxLectureQuiz", produces = "application/json;charset=utf-8")
	public String selectboxLectureQuiz(@RequestParam("cont") String cont,@RequestParam("box") String box,
										HttpSession session) {
		System.out.println("강의별 퀴즈 검색");
		SecurityContext context = SecurityContextHolder.getContext();
		User user = (User) context.getAuthentication().getPrincipal();
		System.out.println(user.getUsername());
		String id= user.getUsername();
		
		List<LectureQuiz> qlsit=lm.selectboxLectureQuiz(id,cont,box);
		String Json = new Gson().toJson(qlsit);
			
			
		return Json;
	}
	
	@RequestMapping(value = "selectLectureTest", produces = "application/json;charset=utf-8")
	public String selectLectureTest(HttpSession session) {
		System.out.println("강의별 테스트 관리");
		SecurityContext context = SecurityContextHolder.getContext();
		User user = (User) context.getAuthentication().getPrincipal();
		System.out.println(user.getUsername());
		String id= user.getUsername();
			List<LectureQuiz> qlsit=lm.selectLectureTest(id);
			String Json = new Gson().toJson(qlsit);
			
		return Json;
	}
	
	@RequestMapping(value = "selectboxLectureTest", produces = "application/json;charset=utf-8")
	public String selectboxLectureTest(@RequestParam("cont") String cont,@RequestParam("box") String box,
										HttpSession session) {
		System.out.println("강의별 시험 검색");
		SecurityContext context = SecurityContextHolder.getContext();
		User user = (User) context.getAuthentication().getPrincipal();
		System.out.println(user.getUsername());
		String id= user.getUsername();
		
		List<LectureQuiz> qlsit=lm.selectboxLectureTest(id,cont,box);
		String Json = new Gson().toJson(qlsit);
			
			
		return Json;
	}
}
