package com.icia.board;

import java.text.DateFormat;

import java.util.Date;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.icia.email.Email;

//mav에 mb속성으로 저장된 객체는 세션 영역에 저장
//@SessionAttributes("mb")  
@Controller
public class BoardController {
	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);

	ModelAndView mav;

	@Autowired
	private BoardMM mm;// new MemberMM();
	@RequestMapping(value = "stud/insertcounselboard") //강의진도확인
	public ModelAndView insertcounselboard(String id , HttpSession session,Integer pageNum) {
		mav = mm.insertcounselboard(id, session,pageNum);
		return mav;
	}
	@RequestMapping(value = "stud/boardwritehome") //강의진도확인
	public ModelAndView boardwritehome(String id , HttpSession session,Integer pageNum) {
	mav.setViewName("insertboard/boardwritehome");
		return mav;
	}
	@RequestMapping(value = "stud/boardwrite") //강의진도확인
	public ModelAndView boardwrite(MultipartHttpServletRequest mul) {
		mav = mm.boardwrite(mul);
		return mav;
	}
}
