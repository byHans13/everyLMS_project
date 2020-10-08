package com.icia.lectureResult;

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
public class LectureResultRestController {
	@Autowired
	LectureResultMM lrm;
	
	ModelAndView mav;
//selectLectureResult
	@PostMapping(value = "selectLectureResult", produces = "application/json;charset=utf-8")
	public String selectLectureResult(String kind) {
		System.out.println("성적관리 검색");		
		LectureResult lr=new LectureResult();
		SecurityContext context = SecurityContextHolder.getContext();
		User user = (User) context.getAuthentication().getPrincipal();
		System.out.println(user.getUsername());
		System.out.println(kind);
		String id= user.getUsername();
		lr.setCl_id(id);
			List<LectureResult> list=lrm.selectLectureResult(lr,kind);
			String Json = new Gson().toJson(list);

			return Json;
	}
	//selectboxLectureResult
	@RequestMapping(value = "selectboxLectureResult", produces = "application/json;charset=utf-8")
	public String selectboxLectureResult(@RequestParam("cont") String cont,@RequestParam("box1") String box1,
										 @RequestParam("box2") String box2, HttpSession session) {
		System.out.println("시험 및 퀴즈성적  검색");
		SecurityContext context = SecurityContextHolder.getContext();
		User user = (User) context.getAuthentication().getPrincipal();
		System.out.println(user.getUsername());
		String id= user.getUsername();
		
		List<LectureResult> list=lrm.selectboxLectureResult(id,cont,box1,box2);
		String Json = new Gson().toJson(list);
			
		return Json;
	}
	
}
