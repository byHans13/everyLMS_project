package com.icia.lectureResult;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class LectureResultContRoller {
	@Autowired
	LectureResultMM lrm;
	
	ModelAndView mav;
	
	@RequestMapping(value = "/prof/goLectureResultPage", method = RequestMethod.GET)
	public String goLectureResultPage() {
		System.out.println("강의별 성적관리페이지");
		
		return "teacher/gradeMM/goLectureResultPage";
	}
	//goLectureResultShowPage
	@RequestMapping(value = "/prof/goLectureResultShowPage", method = RequestMethod.POST)
	public ModelAndView goLectureResultShowPage(LectureResult lr) {
		System.out.println("강의별 시험성적 관리 상세보기 페이지");
		
		mav=lrm.goLectureResultShowPage(lr);
		
		return mav;
	}
	//goQuizLectureResultShowPage
	@RequestMapping(value = "/prof/goQuizLectureResultShowPage", method = RequestMethod.POST)
	public ModelAndView goQuizLectureResultShowPage(LectureResult lr) {
		System.out.println("강의별 퀴즈성적 관리 상세보기 페이지");
		
		mav=lrm.goQuizLectureResultShowPage(lr);
		
		return mav;
	}
	//goLectureResultUpdatePage
	@RequestMapping(value = "/prof/goLectureResultUpdatePage", method = RequestMethod.POST)
	public ModelAndView goLectureResultUpdatePage(LectureResult lr) {
		System.out.println("강의별 성적관리 중 문제보기 페이지");
		
		mav= lrm.goLectureResultUpdatePage(lr);
		
		return mav;
	}//LectureResultUpdate
	@RequestMapping(value = "/prof/LectureResultUpdate", method = RequestMethod.POST)
	public ModelAndView LectureResultUpdate(LectureResult lr) {
		System.out.println("강의별 성적관리 중 문제 업데이트");
		
		mav= lrm.LectureResultUpdate(lr);
		
		return mav;
	}
}
