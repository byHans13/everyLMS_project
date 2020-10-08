package com.icia.lectureTestAnswer;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class LectureTestAnswerController {
	@Autowired
	LectureTestAnswerMM ltam;

	ModelAndView mav;
	
	@RequestMapping(value = "/prof/golectureTestAnswerPage", method = RequestMethod.GET)
	public String golectureTestAnswerPage() {
		System.out.println("채점 및 정답률 관리 페이지");
		
		return "teacher/afterService/golectureTestAnswerPage";
	}
	
	@RequestMapping(value = "/prof/golectureTestAnswerShowPage", method = RequestMethod.POST)
	public ModelAndView golectureTestAnswerShowPage(LectureTestAnswer lta) {
		System.out.println("채점 및 정답률 확인 페이지");
		lta.setCo_name(lta.getCo_name().replaceAll(",", " "));
		System.out.println(lta.getCo_name());
		System.out.println(lta.getCl_idnum());
		System.out.println(lta.getCl_lcnum());
		System.out.println(lta.getCl_id());
		
		mav= ltam.golectureTestAnswerShowPage(lta);
		
		return mav;
	}

}
