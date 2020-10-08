package com.icia.studyAvg;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class StudyAvgController {
	@Autowired
	StudyAvgMM sm;
	
	ModelAndView mav;
	
	@RequestMapping(value = "/prof/goStudyAvgPage", method = RequestMethod.GET)
	public String gosearchidspage() {
		System.out.println("강의별 반평균 페이지");
		
		return "teacher/gradeMM/goStudyAvgPage";
	}
	//goStudyAvgShowPage
	@RequestMapping(value = "/prof/goStudyAvgShowPage", method = RequestMethod.POST)
	public ModelAndView goStudyAvgShowPage(StudyAvg sa) {
		System.out.println("강의별 반평균 상세페이지");
		System.out.println(sa.getCl_clname());
		System.out.println(sa.getCo_name());
		System.out.println(sa.getCl_idnum());
		System.out.println(sa.getCl_lcnum());
		
		mav=sm.goStudyAvgShowPage(sa);
		
		return mav;
	}
}
