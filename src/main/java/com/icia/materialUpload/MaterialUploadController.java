package com.icia.materialUpload;

import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;

@Controller
public class MaterialUploadController {
	@Autowired
	private MaterialUploadMM mumm; // 시험자료 업로드 서비스클래스

	ModelAndView mav;

	// "시험자료업로드" 클릭시 Class List 페이지 이동 및 Class List Select
	@RequestMapping(value = "prof/selecttestmaterialclasslist", method = RequestMethod.GET)
	public ModelAndView selectTestMaterialClassList(HttpSession session, MaterialUpload mu) {
		System.out.println("시험자료업로드 ClassList select 페이지 이동");
		mav = new ModelAndView();
		mav = mumm.selectTestMaterialClassList(session, mu);
		return mav;
	}

	// "문제 작성" 클릭시 시험자료업로드 Frm 페이지 이동 및 Class Course Select
	@RequestMapping(value = "prof/inserttestmaterialuploadpage", method = RequestMethod.GET)
	public ModelAndView insertTestMaterialUploadPage(HttpSession session, MaterialUpload mu) {
		System.out.println("insert 시험자료업로드 문제 입력 페이지 이동");
		System.out.println("컨트롤러 일련번호 = " + mu.getCl_idnum());
		System.out.println("컨트롤러 레벨값 = " + mu.getCl_lv());
		mav = new ModelAndView();
		mav = mumm.insertTestMaterialUploadPage(session, mu);
		return mav;
	}
	
	// "업로드 완료" 클릭시 insertTestMaterialUploadPage의 Form의 데이터 insert 후 페이지 이동.
	@RequestMapping(value = "prof/inserttestmaterialupload", method = RequestMethod.POST)
	public ModelAndView insertTestMaterialUpload(HttpSession session, MaterialUpload mu) {
		System.out.println("insert 시험자료업로드");
		mav = new ModelAndView();
		System.out.println("컨트롤러 mu = " + mu);
		mav = mumm.insertTestMaterialUpload(session, mu);
		return mav;
	}

	// "문제 확인" 클릭시 selectTestMaterialUploadListPage 페이지 이동.
	@RequestMapping(value = "prof/selecttestmaterialuploadlistpage", method = RequestMethod.GET)
	public ModelAndView selectTestMaterialUploadListPage(HttpSession session, MaterialUpload mu) {
		mav = new ModelAndView();
		System.out.println("select 시험자료업로드 ProblemList 페이지 이동");
		System.out.println("컨트롤러 일련번호 = " + mu.getCl_idnum());
		System.out.println("컨트롤러 레벨값 = " + mu.getCl_lv());
		mav.addObject("Cl_idnum", mu.getCl_idnum());
		mav.addObject("Cl_lv", mu.getCl_lv());
		mav.setViewName("teacher/kyj/selectTestMaterialUploadListPage");
		return mav;
	}

	// "퀴즈자료업로드" 클릭시 Class List 페이지 이동 및 Class List Select
	@RequestMapping(value = "prof/selectquizmaterialclasslist", method = RequestMethod.GET)
	public ModelAndView selectQuizMaterialClassList(HttpSession session, MaterialUpload mu) {
		System.out.println("퀴즈자료업로드 ClassList select 페이지 이동");
		mav = new ModelAndView();
		mav = mumm.selectQuizMaterialClassList(session, mu);
		return mav;
	}
	
	// "강좌 리스트 확인" 클릭시 Course List 페이지 이동 및 Class List Select
	@RequestMapping(value = "prof/selectquizmaterialclcolist", method = RequestMethod.GET)
	public ModelAndView selectQuizMaterialClCoList(HttpSession session, MaterialUpload mu) {
		System.out.println("퀴즈자료업로드 ClCoList select 페이지 이동");
		mav = new ModelAndView();
		System.out.println(mu.getCl_idnum());
		System.out.println(mu.getCl_lv());
		mav = mumm.selectQuizMaterialClCoList(session, mu);
		return mav;
	}
	
	// "퀴즈 작성" 클릭시 시험자료업로드 Frm 페이지 이동 및 Class Course Select
	@RequestMapping(value = "prof/insertquizmaterialuploadpage", method = RequestMethod.GET)
	public ModelAndView insertQuizMaterialUploadPage(HttpSession session, MaterialUpload mu) {
		System.out.println("insert 퀴즈자료업로드 퀴즈 입력 페이지 이동");
		System.out.println("컨트롤러 일련번호 = " + mu.getCl_idnum());
		System.out.println("컨트롤러 레벨값 = " + mu.getCl_lv());
		mav = new ModelAndView();
		mav = mumm.insertQuizMaterialUploadPage(session, mu);
		return mav;
	}
	
	// "퀴즈 확인" 클릭시 시험자료업로드 Frm 페이지 이동 및 Class Course Select
	@RequestMapping(value = "prof/selectquizmaterialuploadlistpage", method = RequestMethod.GET)
	public ModelAndView selectQuizMaterialUploadListPage(HttpSession session, MaterialUpload mu) {
		mav = new ModelAndView();
		System.out.println("select 퀴즈자료업로드 퀴즈리스트 확인 페이지 이동");
		System.out.println("컨트롤러 일련번호 = " + mu.getCl_idnum());
		System.out.println("컨트롤러 레벨 = " + mu.getCl_lv());
		System.out.println("컨트롤러 회차 = " + mu.getCo_num());
		mav.addObject("Cl_idnum", mu.getCl_idnum());
		mav.addObject("Cl_lv", mu.getCl_lv());
		mav.addObject("Co_num", mu.getCo_num());
		mav.setViewName("teacher/kyj/selectQuizMaterialUploadListPage");
		return mav;
	}
	
	// "업로드 완료" 클릭시 insertTestMaterialUploadPage의 Form의 데이터 insert 후 페이지 이동.
	@RequestMapping(value = "prof/insertquizmaterialupload", method = RequestMethod.POST)
	public ModelAndView insertQuizMaterialUpload(HttpSession session, MaterialUpload mu) {
		System.out.println("insert 퀴즈자료업로드");
		mav = new ModelAndView();
		System.out.println("컨트롤러 mu = " + mu);
		mav = mumm.insertQuizMaterialUpload(session, mu);
		return mav;
	}
	
}

