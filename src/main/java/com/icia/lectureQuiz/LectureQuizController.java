package com.icia.lectureQuiz;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;


@Controller
public class LectureQuizController {
	@Autowired
	LectureQuizMM lm;
	
	
	ModelAndView mav;
	
	@RequestMapping(value = "/prof/goLectureQuizPage", method = RequestMethod.GET)
	public String gosearchidspage() {
		System.out.println("강의별 퀴즈관리 페이지");
		
		return "teacher/testMM/LectureQuiz";
	}
	
	@RequestMapping(value = "prof/goLectureTestPage", method = RequestMethod.GET)
	public String goLectureTestPage() {
		System.out.println("강의별 과정 시험관리 페이지");
		
		return "teacher/testMM/LectureTest";
	}
	
	@RequestMapping(value = "prof/goLectureQuizShowPage", method = RequestMethod.GET)
	public ModelAndView goLectureQuizShowPage(HttpSession session, String clname, String name, String lcnum) {
		System.out.println("강의별퀴즈 상세페이지");
		System.out.println(clname);
		System.out.println(name);
		System.out.println(lcnum);
		
		SecurityContext context = SecurityContextHolder.getContext();
		User user = (User) context.getAuthentication().getPrincipal();
		System.out.println(user.getUsername());
		String id= user.getUsername();
		mav = lm.goLectureQuizShowPage(clname,name,lcnum,id);
		
		return mav;
	}
	
	@RequestMapping(value = "prof/goLectureTestShowPage", method = RequestMethod.POST)
	public ModelAndView goLectureTestShowPage(HttpSession session, LectureQuiz lq) {
		System.out.println("강의별시험 상세페이지");
		SecurityContext context = SecurityContextHolder.getContext();
		User user = (User) context.getAuthentication().getPrincipal();
		System.out.println(user.getUsername());
		String id= user.getUsername();
		System.out.println(lq.getCl_idnum());
		System.out.println(lq.getCo_name());
		System.out.println(lq.getCl_lcnum());
		System.out.println(lq.getCl_clname());
		String a= lq.getCl_clname().replaceAll(",", " ");
		String b= lq.getCo_name().replaceAll(",", " ");
		System.out.println(a);
		System.out.println(b);
		lq.setCl_clname(a);
		lq.setCo_name(b);
		
		lq.setCl_id(id);
		mav = lm.goLectureTestShowPage(lq);
		
		return mav;
	}
	
	@RequestMapping(value = "prof/goStudentCommentInputPage", method = RequestMethod.POST)
	public ModelAndView goStudentCommentPage(LectureQuiz lq) {
		System.out.println("강의별 시험 코멘트작성 페이지");
		System.out.println(lq.getCo_name());
		System.out.println(lq.getCo_lv());
		System.out.println(lq.getGr_id1());
		System.out.println(lq.getGr_score());
		System.out.println(lq.getCl_lcnum());
		System.out.println(lq.getCl_idnum());
		String a= lq.getCo_name().replaceAll(",", " ");
		lq.setCo_name(a);
		System.out.println(lq.getCo_name());
		
		mav = lm.goStudentCommentPage(lq);
		
		return mav;
	}
	
	@RequestMapping(value = "prof/studentCommentInsert", method = RequestMethod.POST)
	public ModelAndView studentCommentInsert(LectureQuiz lq, RedirectAttributes attr) {
		System.out.println("강의별 시험 코멘트 인설트");
		System.out.println(lq.getCo_lv());
		System.out.println(lq.getGr_id1());
		System.out.println(lq.getCl_lcnum());
		System.out.println(lq.getCl_idnum());
		System.out.println(lq.getTfb_feedback());
		
		String a= lq.getTfb_feedback().replaceAll("\r\n","<br/>");
		System.out.println(a);
		String b= a.replaceAll(" ","&nbsp;");
		String c= a.replaceAll("&lt;br/&gt;","<br/>");
		
		System.out.println(c);
		System.out.println(b);
		lq.setTfb_feedback(c);
		
		mav = lm.studentCommentInsert(lq, attr);
		
		return mav;
	}
	
	@RequestMapping(value = "prof/goStudentCommentSeePage", method = RequestMethod.POST)
	public ModelAndView goStudentCommentSeePage(LectureQuiz lq) {
		System.out.println("강의별 시험 코멘트 보는 페이지");
		System.out.println(lq.getCo_name());
		System.out.println(lq.getCo_lv());
		System.out.println(lq.getGr_id1());
		System.out.println(lq.getGr_score());
		System.out.println(lq.getCl_lcnum());
		System.out.println(lq.getCl_idnum());
		System.out.println(lq.getTfb_feedback());
		String a= lq.getCo_name().replaceAll(",", " ");
		String b= lq.getTfb_feedback().replaceAll("&lt;br/&gt;","<br/>");
		lq.setTfb_feedback(b);
		lq.setCo_name(a);
		System.out.println(lq.getCo_name());
		System.out.println(lq.getTfb_feedback());
		
		mav = lm.goStudentCommentSeePage(lq);
		
		return mav;
	}
	
	@RequestMapping(value = "prof/goStudentCommentUpdatePage", method = RequestMethod.POST)
	public ModelAndView goStudentCommentUpdatePage(LectureQuiz lq) {
		System.out.println("강의별 시험 코멘트 수정 페이지");
		System.out.println(lq.getCo_name());
		System.out.println(lq.getCo_lv());
		System.out.println(lq.getGr_id1());
		System.out.println(lq.getGr_score());
		System.out.println(lq.getCl_lcnum());
		System.out.println(lq.getCl_idnum());
		System.out.println(lq.getTfb_feedback());
		String a= lq.getCo_name().replaceAll(",", " ");
		lq.setCo_name(a);
		System.out.println(lq.getCo_name());
		
		mav = lm.goStudentCommentUpdatePage(lq);
		
		return mav;
	}
	
	@RequestMapping(value = "prof/studentCommentUpdate", method = RequestMethod.POST)
	public ModelAndView studentCommentUpdate(LectureQuiz lq, RedirectAttributes attr) {
		System.out.println("강의별 시험 코멘트 업데이트");
		System.out.println(lq.getCo_lv());
		System.out.println(lq.getGr_id1());
		System.out.println(lq.getCl_lcnum());
		System.out.println(lq.getCl_idnum());
		System.out.println(lq.getTfb_feedback());
		
		String a= lq.getTfb_feedback().replaceAll("\r\n","<br/>");
		System.out.println(a);
		String b= a.replaceAll(" ","&nbsp;");
		System.out.println(b);
		lq.setTfb_feedback(b);
		
		mav = lm.studentCommentUpdate(lq, attr);
		
		return mav;
	}
	
}
