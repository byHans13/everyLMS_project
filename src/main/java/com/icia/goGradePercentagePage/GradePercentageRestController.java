package com.icia.goGradePercentagePage;

import java.util.HashMap;
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

@RestController
@RequestMapping(value = "prof/rest")
public class GradePercentageRestController {
	@Autowired
	GradePercentageMM gm;
	
	ModelAndView mav;
	
	//selectGradePercentage
	@RequestMapping(value = "selectGradePercentage", produces = "application/json;charset=utf-8")
	public String selectGradePercentage(GradePercentage gp, HttpSession session) {
		System.out.println("백분율  rest컨트롤");

		
		HashMap<String, Object> map=gm.selectGradePercentage(gp);
		String Json = new Gson().toJson(map);
			
		return Json;
	}
	//gradePercentage
	@RequestMapping(value = "gradePercentage")
	public ModelAndView gradePercentage(@RequestParam("grade1") String grade1,
										@RequestParam("grade2") String grade2) {
		System.out.println("gradePercentage 페이지");
		System.out.println(grade1);
		System.out.println(grade2);
		
		mav=new ModelAndView();
		String view=null;
		
		view="teacher/gradeMM/gradePercentage";
		mav.addObject("grade1", grade1);
		mav.addObject("grade2", grade2);
		mav.setViewName(view);
		return mav;
	}
	
}
