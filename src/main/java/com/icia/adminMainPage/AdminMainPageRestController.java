package com.icia.adminMainPage;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.google.gson.Gson;
import com.icia.introductionTeacherConfirm.IntroductionTeacherConfirmBean;
import com.icia.member.Member;

@RestController
@RequestMapping(value = "/admi/rest")
public class AdminMainPageRestController {

	
	@Autowired
	AdminMainPageMM ampMm;
	
	

@GetMapping	(value="selectJoinMemberAdmin")
public Map<String, Object> selectJoinMemberAdmin(){
	Map<String, Object> graphMap = ampMm.selectJoinMemberAdmin();
	return graphMap;
}
@GetMapping	(value="selectprofconfirm")
public List<IntroductionTeacherConfirmBean> selectProfConfirm(){
	List<IntroductionTeacherConfirmBean> ctList = ampMm.selectProfConfirm();
	return ctList;
}
@PostMapping	(value="selectintroduction")
public List<AdminMainPageBean> selectIntroduction(String mb_id, String ct_prof){
	System.out.println(mb_id);
	List<AdminMainPageBean> ampList = ampMm.selectIntroduction(mb_id, ct_prof);
	return ampList;
}
@PostMapping	(value="selectcertification")
public List<AdminMainPageBean> selectCertification(String mb_id, String ct_prof){
	System.out.println(mb_id);
	List<AdminMainPageBean> ampList = ampMm.selectCertification(mb_id, ct_prof);
	return ampList;
}

	

	
	
	
}
