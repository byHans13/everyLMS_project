package com.icia.lectureResult;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.icia.isTestTaker.isTestTaker;
import com.icia.lectureTestAnswer.LectureTestAnswer;

@Service
public class LectureResultMM {
	@Autowired
	ILectureResult lrDao;
	
	ModelAndView mav;

	public List<LectureResult> selectLectureResult(LectureResult lr, String kind) {
		
		if(kind.equals("T")) {
			
			List<LectureResult> qlist= lrDao.selectLectureResult(lr);
			if(qlist!=null){
				System.out.println("들어오냐");
				return qlist;
			}
			System.out.println("qlist: null");
			
			return qlist;			
		
		}else if(kind.equals("Q")) {
			
			List<LectureResult> qlist= lrDao.selectQuizLectureResult(lr);
			if(qlist!=null){
				System.out.println("들어오냐");
				return qlist;
			}
			System.out.println("qlist: null");
			
			return qlist;

		}
		return null;

		
	}

	public List<LectureResult> selectboxLectureResult(String id, String cont, String box1, String box2) {
		System.out.println(id);
		System.out.println(cont);
		System.out.println(box1);
		System.out.println(box2);
		
		List<LectureResult> list=null;
		
		switch (box2) {
		case "0":
				System.out.println("전체검색");
				list= lrDao.allSelectLectureResult(id,cont,box1);
			break;
		case "1":
				System.out.println("강의명 검색");
				list= lrDao.classSelectLectureResult(id,cont,box1);
			break;
		case "2":
				System.out.println("강좌명 검색");
				list= lrDao.courseSelectLectureResult(id,cont,box1);
			break;

		default:
				System.out.println("기본값을 들어온다고?");
			break;
		}
		
		return list;
		
	}

	public ModelAndView goLectureResultShowPage(LectureResult lr) {
		System.out.println(lr.getCl_idnum());
		System.out.println(lr.getCl_clname());
		System.out.println(lr.getCo_name());
		System.out.println(lr.getCl_lcnum());
		System.out.println(lr.getGr_kind());
		lr.setCo_name(lr.getCo_name().replaceAll(",", " "));
		lr.setCl_clname(lr.getCl_clname().replaceAll(",", " "));
		String view=null;
		mav=new ModelAndView();
		
		List<LectureResult> list= lrDao.goLectureResultShowPage(lr);
		
		view ="teacher/gradeMM/goLectureResultShowPage";
		mav.addObject("list",new Gson().toJson(list));
		mav.addObject("clname",lr.getCl_clname());
		mav.setViewName(view);
		
		
		return mav;
	}

	public ModelAndView goLectureResultUpdatePage(LectureResult lr) {
		mav=new ModelAndView();
		String view=null;
		
		SecurityContext context = SecurityContextHolder.getContext();
		User user = (User) context.getAuthentication().getPrincipal();
		System.out.println(user.getUsername());
		String id= user.getUsername();
		lr.setCl_clname(lr.getCl_clname().replaceAll(",", " "));
		lr.setCo_name(lr.getCo_name().replaceAll(",", " "));
		lr.setCl_id(id);
		
		List<LectureResult> qlist= lrDao.selectLectureResultUpdate(lr);
		List<LectureResult> dtlist= lrDao.selectDetailProblem(lr);
		
		view="teacher/gradeMM/goLectureResultUpdatePage";
		mav.setViewName(view);
		mav.addObject("qlist", new Gson().toJson(qlist));
		mav.addObject("dtlist", new Gson().toJson(dtlist));
		mav.addObject("cl_clname", lr.getCl_clname());
		mav.addObject("co_name", lr.getCo_name());
		
		return mav;
	}

	public ModelAndView LectureResultUpdate(LectureResult lr) {
		String view=null;
		mav=new ModelAndView();
		//pb_id pb_idnum pb_lv pb_num pb_pbnum pb_pbexplain pb_pbstudent
		System.out.println(lr.getGr_id1());
		System.out.println(lr.getCl_idnum());
		System.out.println(lr.getPb_lv());
		System.out.println(lr.getPb_pbnum());
		System.out.println(lr.getCl_lcnum());
		System.out.println(lr.getPb_pbexplain());
		System.out.println(lr.getPb_pbstudent());
		System.out.println(lr.getPb_pbchkqz());
		//gr_id1 cl_idnum cl_lcnum pb_pbchkqz
		
		SecurityContext context = SecurityContextHolder.getContext();
		User user = (User) context.getAuthentication().getPrincipal();
		System.out.println(user.getUsername());
		String id= user.getUsername();
		lr.setCl_id(id);
		lr.setCl_clname(lr.getCl_clname().replaceAll(",", " "));
		lr.setCo_name(lr.getCo_name().replaceAll(",", " "));
		
		if(lr.getPb_pbexplain().equals(lr.getPb_pbstudent())) {
			System.out.println("일치");
			lr.setPb_answerchk(1);
			System.out.println(lr.getPb_answerchk());
		}else {
			System.out.println("불일치");
			lr.setPb_answerchk(0);
			System.out.println(lr.getPb_answerchk());
		}
		
		if(lrDao.LectureResultUpdate(lr)) {
			System.out.println("업데이트 완료");
			List<LectureResult> qlist=lrDao.selectLectureResultUpdate(lr);
			List<LectureResult> dtlist= lrDao.selectDetailProblem(lr);
			
			int pbmax =qlist.size();
			double answernum=0;
			System.out.println(pbmax);
			System.out.println(qlist.toString());
			for(int i=0;i<qlist.size();i++) {
			System.out.println(qlist.get(0).getPb_answerchk());
			System.out.println("왜지?:     "+qlist.get(0).getPb_answerchk());
			
			  if(qlist.get(i).getPb_answerchk()==1) {
				  answernum++;
			  }
			}
			System.out.println(answernum);
			System.out.println(String.format("%.0f",(answernum/pbmax)*100));
			String strnum = String.format("%.0f",(answernum/pbmax)*100);
			int num= Integer.parseInt(strnum);
			System.out.println(num);
			lr.setGr_score(num);

			if(qlist.get(0).getPb_pbchkqz()==0) {
				String Pb_pbchkqz="T";
				lr.setGr_kind(Pb_pbchkqz);
			}else {
				String Pb_pbchkqz="Q";
				lr.setGr_kind(Pb_pbchkqz);
			}
			
			
			if(lrDao.gradeUpdate(lr)) {
				System.out.println("OK");
			}else {
				System.out.println("no");
			}
			mav.addObject("qlist", new Gson().toJson(qlist));
			mav.addObject("dtlist", new Gson().toJson(dtlist));
			mav.addObject("cl_clname", lr.getCl_clname());
			mav.addObject("co_name", lr.getCo_name());
			
			view="teacher/gradeMM/goLectureResultUpdatePage";
			
			mav.setViewName(view);
			
			return mav;
			
		}else {
			
			System.out.println("업데이트 실패");
			List<LectureResult> qlist=lrDao.selectLectureResultUpdate(lr);
			List<LectureResult> dtlist= lrDao.selectDetailProblem(lr);
			mav.addObject("qlist", new Gson().toJson(qlist));
			mav.addObject("dtlist", new Gson().toJson(dtlist));
			mav.addObject("cl_clname", lr.getCl_clname());
			mav.addObject("co_name", lr.getCo_name());
			
			view="teacher/gradeMM/goLectureResultUpdatePage";
			
			mav.setViewName(view);
		}
			
		return mav;
	}

	public ModelAndView goQuizLectureResultShowPage(LectureResult lr) {
		System.out.println(lr.getCl_idnum());
		System.out.println(lr.getCl_clname());
		System.out.println(lr.getCo_name());
		System.out.println(lr.getCl_lcnum());
		System.out.println(lr.getGr_kind());
		lr.setCo_name(lr.getCo_name().replaceAll(",", " "));
		lr.setCl_clname(lr.getCl_clname().replaceAll(",", " "));
		String view=null;
		mav=new ModelAndView();
		
		List<LectureResult> list= lrDao.goQuizLectureResultShowPage(lr);
		
		view ="teacher/gradeMM/goLectureResultShowPage";
		mav.addObject("list",new Gson().toJson(list));
		mav.addObject("clname",lr.getCl_clname());
		mav.setViewName(view);
		
		
		return mav;
	}
	
}
