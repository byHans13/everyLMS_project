package com.icia.goGradePercentagePage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
@Controller

public class GradePercentageController {
	@Autowired
	GradePercentageMM gm;
	
	ModelAndView mav;
	
	@RequestMapping(value = "/prof/goGradePercentagePage", method = RequestMethod.GET)
	public ModelAndView goGradePercentagePage() {
		System.out.println("강의별 반평균 페이지");
		
		mav= gm.goGradePercentagePage();
		
		return mav;
	}
	//goGradePercentageShowPage
	@RequestMapping(value = "/prof/goGradePercentageShowPage", method = RequestMethod.POST)
	public ModelAndView goGradePercentageShowPage(GradePercentage gp) {
		System.out.println("백분율 페이지");
		
		mav= gm.goGradePercentageShowPage(gp);
		
		return mav;
	}	
}
