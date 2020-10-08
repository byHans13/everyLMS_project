package com.icia.member;

import java.text.DateFormat;

import java.util.Date;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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
public class MemberController {
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);

	@Autowired
	private MemberMM mm;// new MemberMM();

	ModelAndView mav;

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home() {
		logger.info("메인창으로 이동");
		return "h2k5every";
	}

	@RequestMapping(value = "/gomemberjoinpage", method = RequestMethod.GET)
	public String goMemberJoinPage() {
		logger.info("회원가입 약관창으로 이동");
		return "goMemberJoinPage";
	}

	@RequestMapping(value = "/gomainjoinpage", method = RequestMethod.POST)
	public String goMainJoinPage() {
		logger.info("회원가입창으로 이동");
		return "goMainJoinPage";
	}

	@RequestMapping(value = "/insertmemberjoin", method = RequestMethod.POST)
	public ModelAndView insertMemberJoin(Member mb) {
		System.out.println("회원가입");
		System.out.println(mb.getCc_cc());
		mav = new ModelAndView();
		mav = mm.insertMemberJoin(mb);
		return mav;
	}
	
	@RequestMapping(value = "/gologinpage", method = RequestMethod.GET)
	public String goLoginPage() {
		logger.info("로그인창 이동");
		return "goLoginPage";
	}


	@RequestMapping(value = "/gologinpage2", method = RequestMethod.GET)
	public ModelAndView goLoginPage2() {
		logger.info("로그인창 이동");
		mav = new ModelAndView();
		mav.addObject("msg", 0);
		mav.setViewName("goLoginPage");
		return mav;
	}



	@RequestMapping(value = "/prof/goTeacherLoginFrm", method = RequestMethod.GET)
	public ModelAndView goTeacherLoginFrm(HttpSession session) {
		logger.info("강사페이지 이동");
		mav=new ModelAndView();
		mav= mm.goTeacherLoginFrm(session);
		return mav;
	}

	@RequestMapping(value = "/stud/goLoginFrm", method = RequestMethod.GET)
	public ModelAndView goLoginFrm(HttpSession session) {
		logger.info("학생페이지 이동");
		mav = new ModelAndView();
		mav = mm.goLoginFrm(session);
		return mav;
	}

	@RequestMapping(value = "/admi/admiLogin", method = RequestMethod.GET)
	public ModelAndView goAdminLoginFrm(HttpSession session) {
		logger.info("관리자 페이지 이동");
		mav = new ModelAndView();
		mav = mm.goAdminLoginFrm(session);
		return mav;
		//return "h2k5every_admi";
	}

	@RequestMapping(value = "/gologout", method = RequestMethod.GET)
	public void gologout() {
		System.out.println("로그아웃");
	}

	@RequestMapping(value = "/goSearchIdPwPage", method = RequestMethod.GET)
	public String gosearchidspage(Member mb) {
		System.out.println("id/pw 찾기 페이지");
		return "goSearchIdPwPage";
	}

	@RequestMapping(value = "/idChecknumConfirm", method = RequestMethod.POST)
	public ModelAndView idChecknumConfirm(Email em, RedirectAttributes attr) {
		System.out.println("인증번호 확인 후 아이디 찾기");
		mav = mm.idChecknumConfirm(em, attr);
		return mav;
	}

	@RequestMapping(value = "/pwChecknumConfirm", method = RequestMethod.POST)
	public ModelAndView pwChecknumConfirm(Email em, RedirectAttributes attr) {
		System.out.println("인증번호 확인 후 비밀번호 찾기");

		mav = mm.pwChecknumConfirm(em, attr);

		return mav;
	}

	@RequestMapping(value = "/PwUpdate", method = RequestMethod.POST)
	public ModelAndView PwUpdate(Member mb, RedirectAttributes attr) {
		System.out.println("비밀번호 변경");
		System.out.println(mb.getMb_id());
		System.out.println(mb.getMb_pw());

		mav = mm.PwUpdate(mb, attr);

		return mav;
	}
	@RequestMapping(value = "/stud/registertoprof", method = RequestMethod.GET)
	public ModelAndView RegisterToProf(HttpSession session) {
		System.out.println("강사등록하러 가기");
		mav = mm.registerToProf(session);
		return mav;
	}
	
	@RequestMapping(value ="stud/myinfopage")
	public ModelAndView myInfoPage(HttpSession session) {
		mav = mm.myInfoPage(session);
		return mav;
	}
	
	
	
	
	
	
	
	
	
	
}
