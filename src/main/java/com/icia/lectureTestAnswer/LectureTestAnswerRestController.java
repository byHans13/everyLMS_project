package com.icia.lectureTestAnswer;

import java.util.ArrayList;
import java.util.Arrays;
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
import com.icia.isTestTaker.isTestTaker;

@RestController
@RequestMapping(value = "prof/rest")
public class LectureTestAnswerRestController {
	@Autowired
	LectureTestAnswerMM ltam;
	
	ModelAndView mav;

	@PostMapping(value = "selectLectureTestAnswer", produces = "application/json;charset=utf-8")
	public String selectLectureTestAnswer() {
		System.out.println("채점 및 정답률 관리");		
		SecurityContext context = SecurityContextHolder.getContext();
		User user = (User) context.getAuthentication().getPrincipal();
		System.out.println(user.getUsername());
		String id= user.getUsername();
			List<LectureTestAnswer> qlist=ltam.selectLectureTestAnswer(id);
			String Json = new Gson().toJson(qlist);

			return Json;
	}
	//selectLectureQuizAnswer
	@PostMapping(value = "selectLectureQuizAnswer", produces = "application/json;charset=utf-8")
	public String selectLectureQuizAnswer() {
		System.out.println("채점 및 정답률 관리");		
		SecurityContext context = SecurityContextHolder.getContext();
		User user = (User) context.getAuthentication().getPrincipal();
		System.out.println(user.getUsername());
		String id= user.getUsername();
			List<LectureTestAnswer> qlist=ltam.selectLectureQuizAnswer(id);
			String Json = new Gson().toJson(qlist);

			return Json;
	}
	@RequestMapping(value = "selectboxLectureTestAnswer", produces = "application/json;charset=utf-8")
	public String selectboxLectureTestAnswer(@RequestParam("cont") String cont,@RequestParam("box") String box,
											 @RequestParam("box1") String box1,HttpSession session) {
		System.out.println("채점 및 정답률 검색");
		SecurityContext context = SecurityContextHolder.getContext();
		User user = (User) context.getAuthentication().getPrincipal();
		System.out.println(user.getUsername());
		String id= user.getUsername();
		
		List<isTestTaker> qlist=ltam.selectboxLectureTestAnswer(id,cont,box,box1);
		String Json = new Gson().toJson(qlist);
			
		return Json;
	}
	
	@RequestMapping(value = "selectPercentage", produces = "application/json;charset=utf-8")
	public String selectPercentage(@RequestParam("pbidnum") String pbidnum,@RequestParam("pbnum") Integer pbnum,
										HttpSession session) {
		System.out.println("정답률 검색");
		SecurityContext context = SecurityContextHolder.getContext();
		User user = (User) context.getAuthentication().getPrincipal();
		System.out.println(user.getUsername());
		String id= user.getUsername();
		
		System.out.println(pbidnum);
		System.out.println(pbnum);
		System.out.println(id);
		
		List<LectureTestAnswer> plist=ltam.selectPercentage(id,pbidnum,pbnum);
		String Json = new Gson().toJson(plist);
			
		return Json;
	}
	
	@RequestMapping(value = "ansserPercentage")
	public ModelAndView percentage(@RequestParam("choice") String choice,@RequestParam("answer") String answer) {
		System.out.println("percentage 페이지");
		System.out.println(choice);
		System.out.println(answer);
		
		mav=new ModelAndView();
		String view=null;
		
		view="teacher/afterService/goPercentagePage";
		mav.addObject("choice", choice);
		mav.addObject("answer", answer);
		mav.setViewName(view);
		return mav;
	}
}
