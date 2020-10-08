package com.icia.materialUpload;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class MaterialUploadMM {

	@Autowired
	IMaterialUploadDao muDao;

	ModelAndView mav;

	// "시험자료업로드" 클릭시 Class List 페이지 이동 및 Class List Select
//	public ModelAndView selectTestMaterial(HttpSession session, MaterialUpload mu) {
	public ModelAndView selectTestMaterialClassList(HttpSession session, MaterialUpload mu) {
		mav = new ModelAndView();
		String view = null;
		SecurityContext context = SecurityContextHolder.getContext();
		User user = (User) context.getAuthentication().getPrincipal();
		System.out.println("session id = " + user.getUsername());
		mu.setCl_id(user.getUsername());
		System.out.println("Class id = " + mu.getCl_id());
		List<MaterialUpload> muList = new ArrayList<MaterialUpload>();
		System.out.println("selectTestMaterialClassList mu = " + mu);
		muList = muDao.selectTestMaterialClassList(mu);
		System.out.println("selectTestMaterialClassList muList = " + muList);
		StringBuilder sb = new StringBuilder();
		if (muList != null) {
			System.out.println("muList Cl_idnum = " + muList);
			sb.append("<table class='sbClassTable'>" + "<tr class='sbClassTr'>" + "<th class='sbClassTh'>NO.</th>"
					+ "<th class='sbClassTh'>강의명</th>" + "<th class='sbClassTh'>회차</th>"
					+ "<th class='sbClassTh'>학생수</th>" + "<th class='sbClassTh'>교수명</th>"
					+ "<th class='sbClassTh'>문제작성</th>" + "</tr>");
			for (int i = 0; i < muList.size(); i++) {
				mu.setCl_idnum(muList.get(i).getCl_idnum());
				mu.setCl_lv(muList.get(i).getCl_lv());
				int cnt;
				cnt = muDao.selectTestMaterialCountList(mu);
				System.out.println("selectTestMaterialClassList cntList = " + cnt);
				sb.append("<tr class='sbClassTr'>");
				sb.append("<td class='sbClassTd'>" + muList.get(i).getCl_idnum() + "</td>");
				sb.append("<td class='sbClassTd'>" + muList.get(i).getCl_clname() + "</td>");
				sb.append("<td class='sbClassTd'>" + muList.get(i).getCl_lcnum() + "</td>");
				sb.append("<td class='sbClassTd'>" + cnt + "</td>");
				sb.append("<td class='sbClassTd'>" + muList.get(i).getCl_id() + "</td>");
				sb.append("<td class='sbClassTd'>"
						+ "<input type='button' value='문제 작성' onclick=location.href='inserttestmaterialuploadpage?cl_idnum="
						+ muList.get(i).getCl_idnum() + "&cl_lv=" + muList.get(i).getCl_lv() + "'><br>"
						+ "<input type='button' value='문제 확인' onclick=location.href='selecttestmaterialuploadlistpage?cl_idnum="
						+ muList.get(i).getCl_idnum() + "&cl_lv=" + muList.get(i).getCl_lv() + "'></td></tr>");
			}
			sb.append("</table>");
			System.out.println("selectTestMaterial ClassList SELECT 성공");
			view = "goTeacherLoginFrm";
			mav.addObject("muList", sb.toString() + "");
		} else {
			view = "/";
			System.out.println("selectTestMaterial ClassList SELECT 실패");
		}
		mav.setViewName(view);
		return mav;
	}

	// "문제 작성" 클릭시 시험자료업로드 Frm 페이지 이동 및 Class Course Select
	public ModelAndView insertTestMaterialUploadPage(HttpSession session, MaterialUpload mu) {
		mav = new ModelAndView();
		String view = null;
		SecurityContext context = SecurityContextHolder.getContext();
		User user = (User) context.getAuthentication().getPrincipal();
		System.out.println("session = " + user.getUsername());
		List<MaterialUpload> muList = new ArrayList<MaterialUpload>();
		mu.setCl_id(user.getUsername());
		System.out.println("MM 아이디 = " + mu.getCl_id());
		muList = muDao.insertTestMaterialUploadPage(mu);
		if (muList != null) {
			System.out.println("muList = " + muList);
			mav.addObject("muList", muList);
			view = "teacher/kyj/insertTestMaterialUploadPage";
		} else {
			view = "teacher/kyj/selectTestMaterialClassList";
		}
		mav.setViewName(view);
		return mav;
	}

	// insertTestMaterialUploadPage 페이지 이동 후 문제 업로드Frm에 Class Course 출력
	public List<MaterialUpload> insertTestMaterialUploadFrmAjax(HttpSession session, MaterialUpload mu) {
		SecurityContext context = SecurityContextHolder.getContext();
		User user = (User) context.getAuthentication().getPrincipal();
		System.out.println("session = " + user.getUsername());
		List<MaterialUpload> muList = new ArrayList<MaterialUpload>();
		mu.setCl_id(user.getUsername());
		System.out.println("MM 아이디 = " + mu.getCl_id());
		System.out.println("MM 일련번호 = " + mu.getCl_idnum());
		System.out.println("MM 레벨값 = " + mu.getCl_lv());
		muList = muDao.insertTestMaterialUploadFrmAjax(mu);
		System.out.println("SelectAjax MM muList = " + muList);
		if (muList != null) {
			System.out.println("muList null이 아니다");
			return muList;
		} else {
			System.out.println("muList가 null이래~");
			return muList;
		}
	}

	// "문제 추가" 버튼 클릭시 insertTestMaterialUploadPage의 Form의 데이터 insert 후 다음 문제 Form 출력
	public List<MaterialUpload> insertSelectTestMaterialUploadFrmAjax(HttpSession session, MaterialUpload mu) {
		System.out.println("insertAjax MM 교수명 : " + mu.getPb_id());
		System.out.println("insertAjax MM 총회차 : " + mu.getPb_num());
		System.out.println("insertAjax MM 강의명 : " + mu.getCl_clname());
		System.out.println("insertAjax MM 강좌명 : " + mu.getDp_coname());
		System.out.println("insertAjax MM 문제번호 : " + mu.getPb_pbnumSt()); // 정수 치환
		System.out.println("insertAjax MM 문제명 : " + mu.getPb_pbname());
		System.out.println("insertAjax MM 보기명 : " + mu.getDp_pbexm());
		System.out.println("insertAjax MM 보기번호 : " + mu.getDp_pbexmnumSt()); // 정수 치환
		System.out.println("insertAjax MM 정답 : " + mu.getPb_pbexplain());
		System.out.println("insertAjax MM 해설 : " + mu.getPb_pbanswer());

		mu.setPb_idnum(mu.getCl_idnum());
		mu.setPb_lv(mu.getCl_lv());
		mu.setDp_idnum(mu.getCl_idnum());
		mu.setDp_lv(mu.getCl_lv());
		System.out.println("일련번호 1 = " + mu.getPb_idnum());
		System.out.println("레벨값 1 = " + mu.getPb_lv());
		System.out.println("일련번호 2 = " + mu.getDp_idnum());
		System.out.println("레벨값 2 = " + mu.getDp_lv());

		List<MaterialUpload> muList = new ArrayList<MaterialUpload>();
		muList = muDao.selectTestMaterialCourseAjax(mu);
		for (int i = 0; i < muList.size(); i++) {
			mu.setPb_idnum(muList.get(i).getCo_idnum());
			mu.setPb_lv(muList.get(i).getCo_lv());
			System.out.println("강의 일련번호 : " + mu.getPb_idnum());
			System.out.println("강의 레벨 : " + mu.getPb_lv());
		}
		System.out.println("insertSelect Ajax muList = " + muList);

		String dp_pbexm = mu.getDp_pbexm();
		String dp_pbexmnumSt = mu.getDp_pbexmnumSt();
		mu.setPb_pbnum(Integer.parseInt(mu.getPb_pbnumSt()));
		String[] dp_pbexmArr = dp_pbexm.split(",");
		String[] dp_pbexmnumArr = dp_pbexmnumSt.split(",");

		if (dp_pbexm.contains(",") || dp_pbexmnumSt.contains(",")) {
			System.out.println(", 있데");
			if (muDao.insertTestMaterialUploadProblemAjax(mu)) {
				mu.setDp_lv(mu.getPb_lv());
				mu.setDp_id(mu.getPb_id());
				mu.setDp_idnum(mu.getPb_idnum());
				mu.setDp_pbnum(Integer.parseInt(mu.getPb_pbnumSt()));

				System.out.println("Problem insert 성공");

				for (int i = 0; i < dp_pbexmnumArr.length; i++) {
					mu.setDp_pbexm(dp_pbexmArr[i]);
					mu.setDp_pbexmnum(Integer.parseInt(dp_pbexmnumArr[i]));

					System.out.println("인덱스값 : " + i);
					System.out.println("dp_num : " + mu.getDp_num());
					System.out.println("dp_lv : " + mu.getDp_lv());
					System.out.println("dp_id : " + mu.getDp_id());
					System.out.println("dp_idnum : " + mu.getDp_idnum());
					System.out.println("dp_pbnum : " + mu.getDp_pbnum());
					System.out.println("dp_pbexm : " + mu.getDp_pbexm());
					System.out.println("dp_pbexmnum : " + mu.getDp_pbexmnum());

					if (muDao.insertTestMaterialUploadDetailProblemAjax(mu)) {
						System.out.println("DetailProblem insert 성공");
					} else {
						System.out.println("DetailProblem insert 실패");
					}
				}
			} else {
				System.out.println("Problem insert 실패");
			}
		}
		System.out.println("오나?");
		mu.setCl_id(mu.getDp_id());
		mu.setCl_idnum(mu.getDp_idnum());
		mu.setCl_lv(mu.getDp_lv());
		muList = muDao.insertTestMaterialUploadFrmAjax(mu);
		if (muList != null) {
			System.out.println("시험자료 insert 성공");
		} else {
			System.out.println("시험자료 insert 실패");
		}
		return muList;
	}

	// 완료 버튼 클릭시 시험자료 업로드 후 페이지 이동.
	public ModelAndView insertTestMaterialUpload(HttpSession session, MaterialUpload mu) {
		mav = new ModelAndView();
		String view = null;
		System.out.println("insert 최종 MM 교수명 : " + mu.getPb_id());
		System.out.println("insert 최종 MM 총회차 : " + mu.getPb_num());
		System.out.println("insert 최종 MM 강의명 : " + mu.getCl_clname());
		System.out.println("insert 최종 MM 강좌명 : " + mu.getDp_coname());
		System.out.println("insert 최종 MM 문제번호 : " + mu.getPb_pbnumSt()); // 정수 치환
		System.out.println("insert 최종 MM 문제명 : " + mu.getPb_pbname());
		System.out.println("insert 최종 MM 보기명 : " + mu.getDp_pbexm());
		System.out.println("insert 최종 MM 보기번호 : " + mu.getDp_pbexmnumSt()); // 정수 치환
		System.out.println("insert 최종 MM 정답 : " + mu.getPb_pbexplain());
		System.out.println("insert 최종 MM 해설 : " + mu.getPb_pbanswer());

		mu.setCl_idnum(mu.getPb_idnum());
		mu.setCl_lv(mu.getPb_lv());
		mu.setDp_idnum(mu.getPb_idnum());
		mu.setDp_lv(mu.getPb_lv());
		System.out.println("일련번호 1 = " + mu.getPb_idnum());
		System.out.println("레벨값 1 = " + mu.getPb_lv());
		System.out.println("일련번호 2 = " + mu.getDp_idnum());
		System.out.println("레벨값 2 = " + mu.getDp_lv());

		List<MaterialUpload> muList = new ArrayList<MaterialUpload>();
		List<MaterialUpload> pbList = new ArrayList<MaterialUpload>();
		muList = muDao.selectTestMaterialCourse(mu);
		for (int i = 0; i < muList.size(); i++) {
			mu.setPb_idnum(muList.get(i).getCo_idnum());
			mu.setPb_lv(muList.get(i).getCo_lv());
			System.out.println("강의 일련번호 : " + mu.getPb_idnum());
			System.out.println("강의 레벨 : " + mu.getPb_lv());
		}

		String dp_pbexm = mu.getDp_pbexm();
		String dp_pbexmnumSt = mu.getDp_pbexmnumSt();
		mu.setPb_pbnum(Integer.parseInt(mu.getPb_pbnumSt()));
		String[] dp_pbexmArr = dp_pbexm.split(",");
		String[] dp_pbexmnumArr = dp_pbexmnumSt.split(",");

		if (dp_pbexm.contains(",") || dp_pbexmnumSt.contains(",")) {
			System.out.println(", 있데");
			if (muDao.insertTestMaterialUploadProblemAjax(mu)) {
				mu.setDp_lv(mu.getPb_lv());
				mu.setDp_id(mu.getPb_id());
				mu.setDp_idnum(mu.getPb_idnum());
				mu.setDp_pbnum(Integer.parseInt(mu.getPb_pbnumSt()));

				System.out.println("Problem insert 성공");

				for (int i = 0; i < dp_pbexmnumArr.length; i++) {
					mu.setDp_pbexm(dp_pbexmArr[i]);
					mu.setDp_pbexmnum(Integer.parseInt(dp_pbexmnumArr[i]));

					System.out.println("인덱스값 : " + i);
					System.out.println("dp_num : " + mu.getDp_num());
					System.out.println("dp_lv : " + mu.getDp_lv());
					System.out.println("dp_id : " + mu.getDp_id());
					System.out.println("dp_idnum : " + mu.getDp_idnum());
					System.out.println("dp_pbnum : " + mu.getDp_pbnum());
					System.out.println("dp_pbexm : " + mu.getDp_pbexm());
					System.out.println("dp_pbexmnum : " + mu.getDp_pbexmnum());

					if (muDao.insertTestMaterialUploadDetailProblemAjax(mu)) {
						System.out.println("DetailProblem insert 성공");
						view = "redirect:/prof/selecttestmaterialuploadlistpage?cl_idnum=" + mu.getDp_idnum()
								+ "&cl_lv=" + mu.getDp_lv();
					} else {
						view = "inserttestmaterialuploadpage";
						System.out.println("DetailProblem insert 실패");
					}
				}
			} else {
				System.out.println("Problem insert 실패");
			}
		}
		System.out.println("시험자료 insert 성공");
		mav.setViewName(view);
		return mav;
	}

	//
	public List<MaterialUpload> selectViewTestMaterialUploadPageAjax(HttpSession session, MaterialUpload mu) {
		List<MaterialUpload> pbList = new ArrayList<MaterialUpload>();
		MaterialUpload materialUpload = muDao.selectViewTestMaterialUploadPageAjax(mu);
		if (materialUpload != null) {
			String clname = muDao.selectClname(mu);
			int cllcnum = muDao.selectCllcnum(mu);
			materialUpload.setCl_clname(clname);
			materialUpload.setCl_lcnum(cllcnum);
			System.out.println("강의명1 = " + materialUpload.getCl_clname());
			System.out.println("총회차1 = " + materialUpload.getCl_lcnum());
			pbList.add(materialUpload);
		} else {
			System.out.println("materialUpload는 null이야");
		}
		return pbList;
	}

	// "퀴즈자료업로드" 클릭시 goTeacherLoginFrm 페이지 이동 및 Class List Select
	public ModelAndView selectQuizMaterialClassList(HttpSession session, MaterialUpload mu) {
		mav = new ModelAndView();
		String view = null;
		SecurityContext context = SecurityContextHolder.getContext();
		User user = (User) context.getAuthentication().getPrincipal();
		System.out.println("session id = " + user.getUsername());
		mu.setCl_id(user.getUsername());
		System.out.println("Class id = " + mu.getCl_id());
		List<MaterialUpload> muList = new ArrayList<MaterialUpload>();
		System.out.println("selectQuizMaterialClassList mu = " + mu);
		muList = muDao.selectQuizMaterialClassList(mu);
		System.out.println("selectQuizMaterialClassList muList = " + muList);
		StringBuilder sb = new StringBuilder();
		if (muList != null) {
			System.out.println("muList Cl_idnum = " + muList);
			sb.append("<table class='sbClassTable'>" + "<tr class='sbClassTr'>" + "<th class='sbClassTh'>NO.</th>"
					+ "<th class='sbClassTh'>강의명</th>" + "<th class='sbClassTh'>회차</th>"
					+ "<th class='sbClassTh'>학생수</th>" + "<th class='sbClassTh'>교수명</th>"
					+ "<th class='sbClassTh'>퀴즈작성</th>" + "</tr>");
			for (int i = 0; i < muList.size(); i++) {
				mu.setCl_idnum(muList.get(i).getCl_idnum());
				mu.setCl_lv(muList.get(i).getCl_lv());
				int cnt;
				cnt = muDao.selectQuizMaterialCountList(mu);
				System.out.println("selectQuizMaterialClassList cntList = " + cnt);
				sb.append("<tr class='sbClassTr'>");
				sb.append("<td class='sbClassTd'>" + muList.get(i).getCl_idnum() + "</td>");
				sb.append("<td class='sbClassTd'>" + muList.get(i).getCl_clname() + "</td>");
				sb.append("<td class='sbClassTd'>" + muList.get(i).getCl_lcnum() + "</td>");
				sb.append("<td class='sbClassTd'>" + cnt + "</td>");
				sb.append("<td class='sbClassTd'>" + muList.get(i).getCl_id() + "</td>");
				sb.append("<td class='sbClassTd'>"
						+ "<input type='button' value='강좌 리스트 확인' onclick=location.href='selectquizmaterialclcolist?cl_idnum="
						+ muList.get(i).getCl_idnum() + "&cl_lv=" + muList.get(i).getCl_lv() + "'></td></tr>");
			}
			sb.append("</table>");
			System.out.println("selectQuizMaterial ClassList SELECT 성공");
			view = "goTeacherLoginFrm";
			mav.addObject("muList", sb.toString() + "");
		} else {
			view = "/";
			System.out.println("selectQuizMaterial ClassList SELECT 실패");
		}
		mav.setViewName(view);
		return mav;
	}

	// "강좌 리스트 확인" 클릭시 Course List 페이지 이동 및 Class List Select
	public ModelAndView selectQuizMaterialClCoList(HttpSession session, MaterialUpload mu) {
		mav = new ModelAndView();
		String view = null;
		SecurityContext context = SecurityContextHolder.getContext();
		User user = (User) context.getAuthentication().getPrincipal();
		System.out.println("session id = " + user.getUsername());
		mu.setCl_id(user.getUsername());
		System.out.println("Class id = " + mu.getCl_id());
		List<MaterialUpload> muList = new ArrayList<MaterialUpload>();
		System.out.println("selectQuizMaterialclcoList mu = " + mu);
		muList = muDao.selectQuizMaterialClCoList(mu);
		System.out.println("selectQuizMaterialclcoList muList = " + muList);
		StringBuilder sb = new StringBuilder();
		if (muList != null) {
			System.out.println("muList Cl_idnum = " + muList.get(0).getCl_idnum());
			sb.append("<table class='sbClassTable'>" + "<tr class='sbClassTr'>" + "<th class='sbClassTh'>NO.</th>"
					+ "<th class='sbClassTh'>강의명</th>" + "<th class='sbClassTh'>회차</th>"
					+ "<th class='sbClassTh'>강좌명</th>" + "<th class='sbClassTh'>교수명</th>"
					+ "<th class='sbClassTh'>퀴즈작성</th>" + "</tr>");
			for (int i = 1; i < muList.size(); i++) {
				mu.setCl_idnum(muList.get(i).getCl_idnum());
				mu.setCl_lv(muList.get(i).getCl_lv());
				sb.append("<tr class='sbClassTr'>");
				sb.append("<td class='sbClassTd'>" + i + "</td>");
				sb.append("<td class='sbClassTd'>" + muList.get(i).getCl_clname() + "</td>");
				sb.append("<td class='sbClassTd'>" + muList.get(i).getCo_num() + "</td>");
				sb.append("<td class='sbClassTd'>" + muList.get(i).getCo_name() + "</td>");
				sb.append("<td class='sbClassTd'>" + muList.get(i).getCl_id() + "</td>");
				System.out.println("일련번호 : " + muList.get(i).getCl_idnum());
				System.out.println("레벨값 : " + muList.get(i).getCl_lv());
				System.out.println("회차 : " + muList.get(i).getCo_num());
				sb.append("<td class='sbClassTd'>" + "<input type='button' value='퀴즈 작성'"
						+ "onclick=location.href='insertquizmaterialuploadpage?cl_idnum=" + muList.get(i).getCl_idnum()
						+ "&cl_lv=" + muList.get(i).getCl_lv() + "&co_num=" + muList.get(i).getCo_num() + "'><br>"
						+ "<input type='button' value='퀴즈 확인'"
						+ "onclick=location.href='selectquizmaterialuploadlistpage?cl_idnum="
						+ muList.get(i).getCl_idnum() + "&cl_lv=" + muList.get(i).getCl_lv() + "&co_num="
						+ muList.get(i).getCo_num() + "'></td></tr>");
//				sb.append("<td class='sbClassTd'>"
//						+ "<input type='button' value='강좌 리스트 확인' onclick=location.href='selectquizmaterialcourselist?cl_idnum="
//						+ muList.get(i).getCl_idnum() + "&cl_lv=" + muList.get(i).getCl_lv() + "'></td></tr>");
			}
			sb.append("</table>");
			System.out.println("selectQuizMaterial clcoList SELECT 성공");
			view = "goTeacherLoginFrm";
			mav.addObject("muList", sb.toString() + "");
		} else {
			view = "/";
			System.out.println("selectQuizMaterial clcoList SELECT 실패");
		}
		mav.setViewName(view);
		return mav;
	}

	// "퀴즈 작성" 클릭시 시험자료업로드 Frm 페이지 이동 및 Class Course Select
	public ModelAndView insertQuizMaterialUploadPage(HttpSession session, MaterialUpload mu) {
		mav = new ModelAndView();
		String view = null;
		SecurityContext context = SecurityContextHolder.getContext();
		User user = (User) context.getAuthentication().getPrincipal();
		System.out.println("session = " + user.getUsername());
		List<MaterialUpload> muList = new ArrayList<MaterialUpload>();
		mu.setCl_id(user.getUsername());
		System.out.println("MM 아이디 = " + mu.getCl_id());
		muList = muDao.insertQuizMaterialUploadPage(mu);
		if (muList != null) {
			System.out.println("muList = " + muList);
			mav.addObject("muList", muList);
			view = "teacher/kyj/insertQuizMaterialUploadPage";
		} else {
			view = "redirect:/prof/selectquizmaterialclasslist";
		}
		mav.setViewName(view);
		return mav;
	}

	// insertQuizMaterialUploadPage 페이지 이동 후 문제 업로드Frm에 Class Course 출력
	public List<MaterialUpload> insertQuizMaterialUploadFrmAjax(HttpSession session, MaterialUpload mu) {
		SecurityContext context = SecurityContextHolder.getContext();
		User user = (User) context.getAuthentication().getPrincipal();
		System.out.println("session = " + user.getUsername());
		List<MaterialUpload> muList = new ArrayList<MaterialUpload>();
		mu.setCl_id(user.getUsername());
		System.out.println("MM 아이디 = " + mu.getCl_id());
		System.out.println("MM 일련번호 = " + mu.getCl_idnum());
		System.out.println("MM 레벨 = " + mu.getCl_lv());
		System.out.println("MM 회차 = " + mu.getCo_num());
		muList = muDao.insertQuizMaterialUploadFrmAjax(mu);
		System.out.println("insertAjax MM muList = " + muList);
		if (muList != null) {
			System.out.println("muList null이 아니다");
		} else {
			System.out.println("muList가 null이래~");
		}
		return muList;
	}

	// "퀴즈 추가" 버튼 클릭시 insertQuizMaterialUploadPage의 Form의 데이터 insert 후 다음 문제 Form 출력
	public List<MaterialUpload> insertSelectQuizMaterialUploadFrmAjax(HttpSession session, MaterialUpload mu) {
		System.out.println("Quiz insertAjax MM 교수명 : " + mu.getPb_id());
		System.out.println("Quiz insertAjax MM 회차 : " + mu.getPb_num());
		System.out.println("Quiz insertAjax MM 강의명 : " + mu.getCl_clname());
		System.out.println("Quiz insertAjax MM 강좌명 : " + mu.getCo_name());
		System.out.println("Quiz insertAjax MM 문제번호 : " + mu.getPb_pbnumSt()); // 정수 치환
		System.out.println("Quiz insertAjax MM 문제명 : " + mu.getPb_pbname());
		System.out.println("Quiz insertAjax MM 보기명 : " + mu.getDp_pbexm());
		System.out.println("Quiz insertAjax MM 보기번호 : " + mu.getDp_pbexmnumSt()); // 정수 치환
		System.out.println("Quiz insertAjax MM 정답 : " + mu.getPb_pbexplain());
		System.out.println("Quiz insertAjax MM 해설 : " + mu.getPb_pbanswer());

		mu.setPb_idnum(mu.getCl_idnum());
		mu.setPb_lv(mu.getCl_lv());
		mu.setDp_idnum(mu.getCl_idnum());
		mu.setDp_lv(mu.getCl_lv());
		mu.setCo_num(mu.getPb_num());
		mu.setDp_num(mu.getPb_num());
		System.out.println("일련번호 1 = " + mu.getPb_idnum());
		System.out.println("레벨값 1 = " + mu.getPb_lv());
		System.out.println("일련번호 2 = " + mu.getDp_idnum());
		System.out.println("레벨값 2 = " + mu.getDp_lv());

		List<MaterialUpload> muList = new ArrayList<MaterialUpload>();
		muList = muDao.selectQuizMaterialCourseAjax(mu);
		for (int i = 0; i < muList.size(); i++) {
			mu.setPb_idnum(muList.get(i).getCo_idnum());
			mu.setPb_lv(muList.get(i).getCo_lv());
			System.out.println("강의 일련번호 : " + mu.getPb_idnum());
			System.out.println("강의 레벨 : " + mu.getPb_lv());
		}
		System.out.println("insertSelect Ajax muList = " + muList);

		String dp_pbexm = mu.getDp_pbexm();
		String dp_pbexmnumSt = mu.getDp_pbexmnumSt();
		mu.setPb_pbnum(Integer.parseInt(mu.getPb_pbnumSt()));
		String[] dp_pbexmArr = dp_pbexm.split(",");
		String[] dp_pbexmnumArr = dp_pbexmnumSt.split(",");

		if (dp_pbexm.contains(",") || dp_pbexmnumSt.contains(",")) {
			System.out.println(", 있데");
			if (muDao.insertQuizMaterialUploadProblemAjax(mu)) {
				mu.setDp_lv(mu.getPb_lv());
				mu.setDp_id(mu.getPb_id());
				mu.setDp_idnum(mu.getPb_idnum());
				mu.setDp_pbnum(Integer.parseInt(mu.getPb_pbnumSt()));

				System.out.println("Problem insert 성공");

				for (int i = 0; i < dp_pbexmnumArr.length; i++) {
					mu.setDp_pbexm(dp_pbexmArr[i]);
					mu.setDp_pbexmnum(Integer.parseInt(dp_pbexmnumArr[i]));

					System.out.println("인덱스값 : " + i);
					System.out.println("dp_num : " + mu.getDp_num());
					System.out.println("dp_lv : " + mu.getDp_lv());
					System.out.println("dp_id : " + mu.getDp_id());
					System.out.println("dp_idnum : " + mu.getDp_idnum());
					System.out.println("dp_pbnum : " + mu.getDp_pbnum());
					System.out.println("dp_pbexm : " + mu.getDp_pbexm());
					System.out.println("dp_pbexmnum : " + mu.getDp_pbexmnum());

					if (muDao.insertQuizMaterialUploadDetailProblemAjax(mu)) {
						System.out.println("DetailProblem insert 성공");
					} else {
						System.out.println("DetailProblem insert 실패");
					}
				}
			} else {
				System.out.println("Problem insert 실패");
			}
		}
		System.out.println("오나?");
		mu.setCl_id(mu.getDp_id());
		mu.setCl_idnum(mu.getDp_idnum());
		mu.setCl_lv(mu.getDp_lv());
		muList = muDao.insertQuizMaterialUploadFrmAjax(mu);
		if (muList != null) {
			System.out.println("시험자료 insert 성공");
		} else {
			System.out.println("시험자료 insert 실패");
		}
		return muList;
	}

	public ModelAndView insertQuizMaterialUpload(HttpSession session, MaterialUpload mu) {
		mav = new ModelAndView();
		String view = null;
		System.out.println("Quiz insertAjax MM 교수명 : " + mu.getPb_id());
		System.out.println("Quiz insertAjax MM 회차 : " + mu.getPb_num());
		System.out.println("Quiz insertAjax MM 강의명 : " + mu.getCl_clname());
		System.out.println("Quiz insertAjax MM 강좌명 : " + mu.getDp_coname());
		System.out.println("Quiz insertAjax MM 문제번호 : " + mu.getPb_pbnumSt()); // 정수 치환
		System.out.println("Quiz insertAjax MM 문제명 : " + mu.getPb_pbname());
		System.out.println("Quiz insertAjax MM 보기명 : " + mu.getDp_pbexm());
		System.out.println("Quiz insertAjax MM 보기번호 : " + mu.getDp_pbexmnumSt()); // 정수 치환
		System.out.println("Quiz insertAjax MM 정답 : " + mu.getPb_pbexplain());
		System.out.println("Quiz insertAjax MM 해설 : " + mu.getPb_pbanswer());

		mu.setCl_idnum(mu.getPb_idnum());
		mu.setCl_lv(mu.getPb_lv());
		mu.setDp_idnum(mu.getPb_idnum());
		mu.setDp_lv(mu.getPb_lv());
		mu.setCo_num(mu.getPb_num());
		mu.setDp_num(mu.getPb_num());
		System.out.println("일련번호 1 = " + mu.getPb_idnum());
		System.out.println("레벨값 1 = " + mu.getPb_lv());
		System.out.println("일련번호 2 = " + mu.getDp_idnum());
		System.out.println("레벨값 2 = " + mu.getDp_lv());

		List<MaterialUpload> muList = new ArrayList<MaterialUpload>();
		muList = muDao.selectQuizMaterialCourseAjax(mu);
		for (int i = 0; i < muList.size(); i++) {
			mu.setPb_idnum(muList.get(i).getCo_idnum());
			mu.setPb_lv(muList.get(i).getCo_lv());
			System.out.println("강의 일련번호 : " + mu.getPb_idnum());
			System.out.println("강의 레벨 : " + mu.getPb_lv());
		}

		String dp_pbexm = mu.getDp_pbexm();
		String dp_pbexmnumSt = mu.getDp_pbexmnumSt();
		mu.setPb_pbnum(Integer.parseInt(mu.getPb_pbnumSt()));
		String[] dp_pbexmArr = dp_pbexm.split(",");
		String[] dp_pbexmnumArr = dp_pbexmnumSt.split(",");

		if (dp_pbexm.contains(",") || dp_pbexmnumSt.contains(",")) {
			System.out.println(", 있데");
			if (muDao.insertQuizMaterialUploadProblemAjax(mu)) {
				mu.setDp_lv(mu.getPb_lv());
				mu.setDp_id(mu.getPb_id());
				mu.setDp_idnum(mu.getPb_idnum());
				mu.setDp_pbnum(Integer.parseInt(mu.getPb_pbnumSt()));

				System.out.println("Problem insert 성공");

				for (int i = 0; i < dp_pbexmnumArr.length; i++) {
					mu.setDp_pbexm(dp_pbexmArr[i]);
					mu.setDp_pbexmnum(Integer.parseInt(dp_pbexmnumArr[i]));

					System.out.println("인덱스값 : " + i);
					System.out.println("dp_num : " + mu.getDp_num());
					System.out.println("dp_lv : " + mu.getDp_lv());
					System.out.println("dp_id : " + mu.getDp_id());
					System.out.println("dp_idnum : " + mu.getDp_idnum());
					System.out.println("dp_pbnum : " + mu.getDp_pbnum());
					System.out.println("dp_pbexm : " + mu.getDp_pbexm());
					System.out.println("dp_pbexmnum : " + mu.getDp_pbexmnum());

					if (muDao.insertQuizMaterialUploadDetailProblemAjax(mu)) {
						System.out.println("DetailProblem insert 성공");
						view = "redirect:/prof/selectquizmaterialclcolist?cl_idnum=" + mu.getCl_idnum() + "&cl_lv="
								+ mu.getCl_lv();
					} else {
						System.out.println("DetailProblem insert 실패");
						view = "redirect:/prof/insertquizmaterialuploadpage?cl_idnum=" + mu.getCl_idnum() + "&cl_lv="
								+ mu.getCl_lv() + "&co_num=" + mu.getCo_num();
					}
				}
			} else {
				System.out.println("Problem insert 실패");
			}
		}
		System.out.println("시험자료 insert 성공");
		mav.setViewName(view);
		return mav;

	}

}
