package com.icia.classHome;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.icia.classHome.AdmiApplicationBean;

@RequestMapping(value="/stud")
@Controller
public class ClassHomeController {
	@Autowired
	ClassHomeService cs;
	ModelAndView mav;
	
	@RequestMapping(value = "selectMyCalendarPage")
	public ModelAndView testRest(AdmiApplicationBean ab, HttpSession session) {
		mav = cs.selectMyCalendar(ab, session);
		return mav;
	}//scheduel페이지로 이동
	
	@GetMapping(value="classHome")
	public ModelAndView selectClassHome(ClassBean cb, HttpSession session) {
		mav= cs.selectClassHomePage(cb, session);	
		return mav;
	}//강의 일련번호로 classInfo view 출력해서 classHome으로 이동 
	
	@GetMapping(value="selectClassLectureVideoPage")
	public ModelAndView selectClassLectureVideoPage(CourseBean cob, HttpSession session) {
		mav= cs.selectClassLectureVideoPage(cob, session);
		return mav;
	}// 강의목록에서 video페이지로 이동
	
	@GetMapping(value="selectPreviewQuiz")
	public ModelAndView selectPreviewQuiz(ClassBean cl, HttpSession session) {
		mav= cs.selectPreviewQuiz(cl, session);
		return mav;
	}//강의실 홈에서 맛보기퀴즈 창으로 이동
	
	@GetMapping(value="selectCourseQuiz")
	public ModelAndView selectCouresQuiz(EvaluationBean ef, HttpSession session) {
		mav= cs.selectCourseQuiz(ef, session);
		return mav;
	}//lectureVideo에서 강의평가, 퀴즈창
	
	@GetMapping(value="selectMyClassManagementPage")
	public ModelAndView selectClassManagementPage(HttpSession session) {
		mav=cs.selectClassManagementPage(session);
		return mav;
	}//main에서 수강관리 페이지로 
	@GetMapping(value="selectLevelCheckPage")
	public ModelAndView selectLevelCheckPage(HttpSession session) {
		mav = cs.selectLevelCheckPage(session);
		return mav;
	}//main에서 levelcheck page로 이동
	
	@GetMapping(value="selectClassFinalTest")
	public ModelAndView selectClassFinalTest(ProblemBean pb, HttpSession session) {	
		mav = cs.selectClassFinalTest(pb, session);
		return mav;
	}
	@GetMapping(value="selectClassFinalTestPage")
	public ModelAndView selectClassFinalTestPage(HttpSession session) {
		mav = cs.selectClassFinalTestPage(session);
		return mav;
	}
}
