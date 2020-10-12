package com.icia.introductionTeacherConfirm;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;

@Service
public class IntroductionTeacherConfirmService {

	@Autowired
	IIntroductionTeacherConfirmDao itcDao;
	
	@Autowired
	AdminFileManager afm;
	
	ModelAndView mav;

	public ModelAndView registerToProf(MultipartHttpServletRequest multi) {
		
		mav=new ModelAndView();
		String view = null;
		String ct_id=multi.getSession().getAttribute("id").toString();
		String ct_prof = multi.getParameter("ct_prof");
		String ct_cont = multi.getParameter("ct_cont");
		System.out.println(multi.getParameter("fileCheck1"));
		System.out.println(multi.getParameter("fileCheck2"));
		int check1 = Integer.parseInt(multi.getParameter("fileCheck1"));
		int check2 = Integer.parseInt(multi.getParameter("fileCheck2"));
		//ctf_checkArr = new Gson().fromJson(multi.getParameter("ctf_check"), classOfT)
		System.out.println("ctf_check 형태 : "+multi.getParameter("ctf_check"));
		System.out.println("ctf_check1 형태 : "+multi.getParameter("ctf_check1"));
		System.out.println("ctf_check2 형태 : "+multi.getParameter("ctf_check2"));
		int check = 1;
		IntroductionTeacherConfirmBean itc = new IntroductionTeacherConfirmBean();
		itc.setCt_check(check).setCt_cont(ct_cont).setCt_id(ct_id).setCt_prof(ct_prof);
		int certiInsert = itcDao.insertRegister(itc);
		List<MultipartFile> fList = multi.getFiles("files");
		System.out.println("fList="+fList);
		System.out.println("fList size()=" + fList.size());
		for (int i = 0; i < fList.size(); i++) {
			System.out.println(fList.get(i).getOriginalFilename());
		}
		String ctf_check;
		boolean f = false;
		if(certiInsert !=0) {
			if (check1 == 1 && check2==1) {
				ctf_check = multi.getParameter("ctf_check1");
				System.out.println("");
				f = afm.fileUp(multi, ct_prof,ctf_check);
				if (f) {
					System.out.println("file1 ctf_check="+multi.getParameter("ctf_check1"));
					System.out.println("file up check ok");
					mav.addObject("profCheck", itcDao.selectProfCheck(ct_id));
					view = "redirect:goLoginFrm";
				} else {
					System.out.println("file up fail");
					view = "/Admin/hans/registerToProf";
				}
			}
//			if (check2 == 1) {
//				System.out.println("");
//				ctf_check = multi.getParameter("ctf_check2");
//				f = afm.fileUp(multi, ct_prof,ctf_check);
//				if (f) {
//					System.out.println("file2 ctf_check="+multi.getParameter("ctf_check2"));
//					System.out.println("file up check 2 ok");
//					view = "/stud/go";
//				} else {
//					System.out.println("file up fail");
//					view = "/Admin/hans/registerToProf";
//				}
//			}
		}
		mav.setViewName(view);
		return mav;
	}
	
	public String insertYesConfirm(String mb_id, String ct_prof) {
		String json = null;
		int cnt=0;
		if(ct_prof != "") {
			System.out.println("준비된 자이옵니다.");
			cnt = itcDao.insertYesConfirm(mb_id);
			 itcDao.updateYesConfirm(mb_id);
			 json = "성공ㅋㅋ";
		}
		return json;
	}

	public List<IntroductionTeacherConfirmBean> selectLectureConfirm() {
		List<IntroductionTeacherConfirmBean> itcfList = itcDao.selectLectureConfirm();
		return itcfList;
	}

	public List<IntroductionTeacherConfirmBean> selectLectureData(String cl_idnum, String co_lv) {
		List<IntroductionTeacherConfirmBean> itcfList = itcDao.selectLectureData(cl_idnum, co_lv);
		return itcfList;
	}

@Transactional
	public List<IntroductionTeacherConfirmBean> selectLectureConfirmYes(String cl_idnum, String co_lv) {
		List<IntroductionTeacherConfirmBean> itcfList = itcDao.selectLectureConfirmYes(cl_idnum, co_lv);
		if(itcfList != null) {
			System.out.println("준비된 강의 옵니다.");
			itcDao.updateLectureConfirm(cl_idnum,co_lv);
			itcDao.insertCourseZero(cl_idnum,co_lv);
			List<IntroductionTeacherConfirmBean> efList = itcDao.selectEvalFrmConfirmYes(cl_idnum, co_lv);
			for(int i=0; i<efList.size();i++) {
				System.out.println("평가지 작성"+efList.get(i));
				for(int j=1;j<5;j++) {
					int co_num = efList.get(i).getCo_num();
					System.out.println("왜이래"+co_num);
					System.out.println("하이고야"+cl_idnum+", "+co_lv+", "+co_num);
			itcDao.insertEvaluationForm(cl_idnum, co_lv, co_num, j);
			}
		}
	}else {
		System.out.println("준비된 강의가 없습니당.");
	}
		return itcfList;
}
}
