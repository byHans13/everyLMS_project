package com.icia.studyAvg;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.icia.lectureQuiz.LectureQuiz;

@RestController
@RequestMapping(value = "prof/rest")
public class StudyAvgRestController {
	@Autowired
	StudyAvgMM sm;
	
	ModelAndView mav;
	
	//selectStudyAvg
	@RequestMapping(value = "selectStudyAvg", produces = "application/json;charset=utf-8")
	public String selectStudyAvg(HttpSession session) {
		System.out.println("강의별 반평균 rest컨트롤");
		SecurityContext context = SecurityContextHolder.getContext();
		User user = (User) context.getAuthentication().getPrincipal();
		System.out.println(user.getUsername());
		String id= user.getUsername();
			List<StudyAvg> lsit=sm.selectStudyAvg(id);
			String Json = new Gson().toJson(lsit);
			
		return Json;
	}
	//selectboxStudyAvg
	@RequestMapping(value = "selectboxStudyAvg", produces = "application/json;charset=utf-8")
	public String selectboxLectureTest(@RequestParam("cont") String cont,@RequestParam("box") String box,
										HttpSession session) {
		System.out.println("강의별 시험 검색");
		SecurityContext context = SecurityContextHolder.getContext();
		User user = (User) context.getAuthentication().getPrincipal();
		System.out.println(user.getUsername());
		String id= user.getUsername();
		
		List<StudyAvg> lsit=sm.selectboxStudyAvg(id,cont,box);
		String Json = new Gson().toJson(lsit);
			
			
		return Json;
	}
	//avgPercentage
	@RequestMapping(value = "avgPercentage")
	public ModelAndView avgPercentage(@RequestParam("avg") String avg) {
		System.out.println("avgPercentage 페이지");
		System.out.println(avg);
		
		mav=new ModelAndView();
		String view=null;
		
		view="teacher/gradeMM/avgPercentage";
		mav.addObject("avg", avg);
		mav.setViewName(view);
		return mav;
	}
}
