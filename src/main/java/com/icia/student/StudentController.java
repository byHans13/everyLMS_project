package com.icia.student;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;

import java.util.Date;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.icia.email.Email;

//mav에 mb속성으로 저장된 객체는 세션 영역에 저장
//@SessionAttributes("mb")  
@Controller
public class StudentController {

	@Autowired
	private StudentMM mm;// new MemberMM();

	ModelAndView mav;

	@RequestMapping(value = "stud/selectMyClassProgressPage", method = RequestMethod.GET) //강의진도확인
	public ModelAndView selectMyClassProgressPage(String id , HttpSession session) {
		mav = mm.selectMyClassProgressPage(id, session);
		return mav;
	}
	@RequestMapping(value = "stud/selectClassReviewAjax", method = RequestMethod.GET) // 강의후기
	public ModelAndView selectClassReviewAjax(String id, HttpSession session) {
		mav = mm.selectClassReviewAjax(id, session);
		return mav;
	}
	@RequestMapping(value = "stud/reviewselectbtn") //후기 셀렉트박스 -> 검색기능 (작성자 , 내용 등 검색기능 x)
	public ModelAndView reviewselectbtn(String id, String search,HttpSession session, Integer pageNum) {
		mav = mm.reviewselectbtn(id,search,session,pageNum);
		return mav;
	}
	
	@RequestMapping(value = "stud/searchClassreviewDetail")
	public ModelAndView searchClassreviewDetail(String id ,String selvalue, String search, Integer pageNum ,HttpSession session) {
		mav = mm.searchClassreviewDetail(id,selvalue,search,pageNum,session);
		return mav;
	}
	@RequestMapping(value = "stud/selectClassQnaAjax", method = RequestMethod.GET) //qna 게시판
	public ModelAndView selectClassQnaAjax(String id, HttpSession session) {
		mav = mm.selectClassQnaAjax(id, session);
		return mav;
	}
	@RequestMapping(value = "stud/searchbtn") //QNA 셀렉트박스 고르고 검색누를때
	public ModelAndView qnasearchbtn(String id, String search,HttpSession session, Integer pageNum) {
		mav = mm.searchbtn(id,session,search,pageNum);
		return mav;
	}
	@RequestMapping(value = "stud/searchClassQnaDetail")
	public ModelAndView getqnasearchlist(String id ,String selvalue, String search, Integer pageNum ,HttpSession session) {
		mav = mm.searchClassQnaDetail(id,selvalue,search,pageNum,session);
		return mav;
	}

	@RequestMapping(value = "stud/selectMyMemoPage", method = RequestMethod.GET) //메모장
	public ModelAndView selectMyMemoPage(String id,HttpSession session) {
		mav = mm.selectMyMemoPage(id, session);
		return mav;
	}
	@RequestMapping(value = "stud/Addpoint")
	public ModelAndView Addpoint(String id, HttpSession session) {
		mav = mm.Addpoint(id, session);
		return mav;
	}

	@RequestMapping(value = "stud/Payment")
	public ModelAndView Payment(String id, String onechk, HttpServletResponse response, HttpServletRequest req,
			String resultpt) throws IOException {
		PrintWriter out = response.getWriter();
		response.setContentType("text/html; charset=UTF-8");
		if (onechk == null || resultpt == null) {
			out.println("<script>alert('포인트를 설정해주세요!')</script>");
			out.flush();
		} else {
			mav = mm.Payment(id, onechk, response, req, resultpt);
		}
		return mav;
	}

	@RequestMapping(value = "stud/PointCharge")
	public ModelAndView PointCharge(String id,String resultpt,String phonearea,HttpServletRequest req,HttpServletResponse response) throws IOException {
	PrintWriter out = response.getWriter();
		response.setContentType("text/html; charset=UTF-8");
		if(phonearea == "") {
			out.println("<script>alert('번호를 설정해주세요!!')</script>");
			out.flush();
		}else {
		mav = mm.PointCharge(id,resultpt,phonearea,req,response);
		System.out.println(phonearea);
		}
		return mav;
	}

	@RequestMapping(value = "stud/complete")
	public ModelAndView complete(String id, String resultpt, HttpServletRequest req, HttpSession session) {
		mav = mm.complete(id, resultpt, req, session);
		return mav;
	}
	@GetMapping(value="classHome")
	   public ModelAndView selectClassHome(Clasc cb, HttpSession session) {
	      mav= mm.selectClassHomePage(cb, session);   
	      return mav;
	   }//강의 일련번호로 classInfo view 출력해서 classHome으로 이동
	
	
}

