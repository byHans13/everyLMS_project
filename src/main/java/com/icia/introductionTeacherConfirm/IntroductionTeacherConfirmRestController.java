package com.icia.introductionTeacherConfirm;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.google.gson.Gson;
import com.icia.adminMainPage.AdminMainPageMM;

@RestController
@RequestMapping(value = "/admi/rest")
public class IntroductionTeacherConfirmRestController {
	
	@Autowired
	IntroductionTeacherConfirmService itcfMm;
	
	@PostMapping	(value="insertyesconfirm")
	public String insertYesConfirm(String mb_id, String ct_prof){
		System.out.println(mb_id);
		String json = itcfMm.insertYesConfirm(mb_id,ct_prof);
		return new Gson().toJson(json);
	}
	@PostMapping	(value="selectlectureconfirm")
	public List<IntroductionTeacherConfirmBean> selectLectureConfirm(){
		List<IntroductionTeacherConfirmBean> itcfList = itcfMm.selectLectureConfirm();
		return itcfList;
	}
	@PostMapping	(value="selectlecturedata")
	public List<IntroductionTeacherConfirmBean> selectLectureData(String cl_idnum, String co_lv){
		List<IntroductionTeacherConfirmBean> itcfList = itcfMm.selectLectureData(cl_idnum, co_lv);
		return itcfList;
	}
	@PostMapping	(value="selectlectureconfirmyes")
	public List<IntroductionTeacherConfirmBean> insertLectureConfirm(String cl_idnum, String co_lv){
		List<IntroductionTeacherConfirmBean> itcfList = itcfMm.selectLectureConfirmYes(cl_idnum, co_lv);
		return itcfList;
	}
	


}
