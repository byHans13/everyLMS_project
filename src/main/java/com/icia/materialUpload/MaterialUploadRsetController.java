package com.icia.materialUpload;

import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.request;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.Gson;
import com.icia.email.Email;


@RestController
//@RequestMapping(value = "/stud/rest")
public class MaterialUploadRsetController {
	@Autowired
	private MaterialUploadMM mumm; //시험자료 업로드 서비스클래스
	
	//insertTestMaterialUploadPage 페이지 이동 후 문제 업로드Frm에 Class Course 출력
	@PostMapping(value = "prof/rest/inserttestmaterialuploadfrmajax")
	public String insertTestMaterialUploadFrmAjax(HttpSession session, MaterialUpload mu) {
		System.out.println("시험자료업로드 select Ajax");
		System.out.println("컨트롤러 일련번호 = " + mu.getCl_idnum());
		System.out.println("컨트롤러 레벨값 = " + mu.getCl_lv());
		List<MaterialUpload> muList = new ArrayList<MaterialUpload>();
		muList = mumm.insertTestMaterialUploadFrmAjax(session, mu);
		String json = new Gson().toJson(muList);
		return json;
	}
	
	//"문제 추가" 버튼 클릭시 insertTestMaterialUploadPage의 Form의 데이터 insert 후 다음 문제 Form 출력
	@PostMapping(value = "prof/rest/insertselecttestmaterialuploadfrmajax")
	public String insertSelectTestMaterialUploadFrmAjax(HttpSession session, MaterialUpload mu) {
		System.out.println("시험자료업로드 insert후 select Ajax");
		System.out.println("문제추가 컨트롤러 일련번호 = " + mu.getCl_idnum());
		System.out.println("문제추가 컨트롤러 레벨값 = " + mu.getCl_lv());
		List<MaterialUpload> muList = new ArrayList<MaterialUpload>();
		muList = mumm.insertSelectTestMaterialUploadFrmAjax(session, mu);
		String json = new Gson().toJson(muList);
		return json;
	}
	
	//"문제 확인" 버튼 클릭시 insertTestMaterialUploadPage 이동 후 ready 펑션 시행하여 Ajax로 문제 Select
	@RequestMapping(value = "prof/rest/selectviewtestmaterialuploadpageajax", method = RequestMethod.POST)
//	public String selectViewTestMaterialUploadPageAjax(@RequestParam("cl_idnum")String cl_idnum, HttpSession session, MaterialUpload mu, MaterialUpload_Problem muP, MaterialUpload_DetailProblem muDP) {
	public String selectViewTestMaterialUploadPageAjax(HttpSession session, MaterialUpload mu) {
		System.out.println("시험자료업로드 select View Ajax");
		System.out.println("일련번호 Ajax = " + mu.getCl_idnum());
		System.out.println("레벨값 Ajax = " + mu.getCl_lv());
		List<MaterialUpload> pbList = new ArrayList<MaterialUpload>();
		pbList = mumm.selectViewTestMaterialUploadPageAjax(session, mu);
		System.out.println("pbList = " + pbList);
		String json = new Gson().toJson(pbList);
		return json;
	}
	
	//insertQuizMaterialUploadPage 페이지 이동 후 문제 업로드Frm에 Class Course 출력
	@PostMapping(value = "prof/rest/insertquizmaterialuploadfrmajax")
	public String insertQuizMaterialUploadFrmAjax(HttpSession session, MaterialUpload mu) {
		System.out.println("퀴즈자료업로드 select Ajax");
		System.out.println("컨트롤러 일련번호 = " + mu.getCl_idnum());
		System.out.println("컨트롤러 레벨 = " + mu.getCl_lv());
		System.out.println("컨트롤러 회차 = " + mu.getCo_num());
		List<MaterialUpload> muList = new ArrayList<MaterialUpload>();
		muList = mumm.insertQuizMaterialUploadFrmAjax(session, mu);
		String json = new Gson().toJson(muList);
		return json;
	}
	
	//"퀴즈 추가" 버튼 클릭시 insertTestMaterialUploadPage의 Form의 데이터 insert 후 다음 문제 Form 출력
	@PostMapping(value = "prof/rest/insertselectquizmaterialuploadfrmajax")
	public String insertSelectQuizMaterialUploadFrmAjax(HttpSession session, MaterialUpload mu) {
		System.out.println("시험자료업로드 insert후 select Ajax");
		System.out.println("문제추가 컨트롤러 일련번호 = " + mu.getCl_idnum());
		System.out.println("문제추가 컨트롤러 레벨값 = " + mu.getCl_lv());
		List<MaterialUpload> muList = new ArrayList<MaterialUpload>();
		muList = mumm.insertSelectQuizMaterialUploadFrmAjax(session, mu);
		String json = new Gson().toJson(muList);
		return json;
	}
	
}






















