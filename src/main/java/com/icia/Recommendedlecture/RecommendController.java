package com.icia.Recommendedlecture;

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
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.icia.email.Email;

//mav에 mb속성으로 저장된 객체는 세션 영역에 저장
//@SessionAttributes("mb")  
@Controller
public class RecommendController {

	@Autowired
	private RecommendMM mm;// new MemberMM();

	ModelAndView mav;

	@RequestMapping(value = "stud/selectMyInterestLevelMatchPage", method = RequestMethod.GET) //레벨에 맞는 추천강의
	public ModelAndView selectMyInterestLevelMatchPage(String id , HttpSession session) {
		mav = mm.selectMyInterestLevelMatchPage(id, session);
		return mav;
	}
	@RequestMapping(value = "stud/levelmatchsearch", method = RequestMethod.GET) //레벨에 맞는 추천강의 검색기능
	public ModelAndView levelmatchsearch(String id ,String selvalue , String search ,HttpSession session ,Integer pageNum) {
		mav = mm.levelmatchsearch(id,selvalue,search , session,pageNum);
		return mav;
	}
	@RequestMapping(value = "stud/selectInterestClassPage", method = RequestMethod.GET) //취향에 맞는 추천강의
	public ModelAndView selectInterestClassPage(String id , HttpSession session) {
		mav = mm.selectInterestClassPage(id, session);
		return mav;
	}
	@RequestMapping(value = "stud/lnterestSearch", method = RequestMethod.GET) //취향에 맞는 추천강의 검색기능
	public ModelAndView lnterestSearch(String id ,String selvalue , String search ,HttpSession session ,Integer pageNum) {
		mav = mm.lnterestSearch(id,selvalue,search , session,pageNum);
		return mav;
	}
	@RequestMapping(value = "stud/selectMyDeepenInterestPage", method = RequestMethod.GET) //심화학습 추천강의
	public ModelAndView selectMyDeepenInterestPage(String id , HttpSession session) {
		mav = mm.selectMyDeepenInterestPage(id, session);
		return mav;
	}
	@RequestMapping(value = "stud/DeeplearningSearch", method = RequestMethod.GET) //심화학습 추천강의 검색기능
	public ModelAndView DeeplearningSearch(String id ,String selvalue , String search ,HttpSession session ,Integer pageNum) {
		mav = mm.DeeplearningSearch(id,selvalue,search , session,pageNum);
		return mav;
	}
}

