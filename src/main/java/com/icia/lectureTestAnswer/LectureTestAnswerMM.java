package com.icia.lectureTestAnswer;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.icia.isTestTaker.isTestTaker;

@Service
public class LectureTestAnswerMM {
	@Autowired
	ILectureTestAnswer ltaDao;
	
	ModelAndView mav;

	public List<LectureTestAnswer> selectLectureTestAnswer(String id) {
		System.out.println(id);
		List<LectureTestAnswer> qlist= ltaDao.selectLectureTestAnswer(id);
		if(qlist!=null){
			System.out.println("들어오냐");
			return qlist;
		}
		System.out.println("qlist: null");
		
		return qlist;
	}

	public List<isTestTaker> selectboxLectureTestAnswer(String id, String cont, String box,String box1) {
		System.out.println(id);
		System.out.println(cont);
		System.out.println(box);
		System.out.println(box1);
		List<isTestTaker> qlist=null;
		String from=null;
		
		if(box1.equals("T")) {
			from="lectureQuiz1";
		}
		else if(box1.equals("Q")) {
			from="lectureQuiz";	
		}
		System.out.println(from);
		
		switch (box) {
		case "0":
				System.out.println("전체검색");
				qlist= ltaDao.allSelectLectureTestAnswer(id,cont,from);
			break;
		case "1":
				System.out.println("강의명 검색");
				qlist= ltaDao.classSelectLectureTestAnswer(id,cont,from);
			break;
		case "2":
				System.out.println("강좌명 검색");
				qlist= ltaDao.courseSelectLectureTestAnswer(id,cont,from);
			break;

		default:
				System.out.println("기본값을 들어온다고?");
			break;
		}
		
		return qlist;
	}

	public ModelAndView golectureTestAnswerShowPage(LectureTestAnswer lta) {
		mav=new ModelAndView();
		String view=null;
		
		List<LectureTestAnswer> qlist= ltaDao.selectlectureTestAnswerShow(lta);
		List<LectureTestAnswer> dtlist= ltaDao.selectDetailProblem(lta);
		
		view="teacher/afterService/golectureTestAnswerShowPage";
		mav.setViewName(view);
		mav.addObject("qlist", new Gson().toJson(qlist));
		mav.addObject("dtlist", new Gson().toJson(dtlist));
		mav.addObject("co_name", lta.getCo_name());
		
		return mav;
	}

	public List<LectureTestAnswer> selectPercentage(String id, String pbidnum, Integer pbnum) {
		LectureTestAnswer lta= new LectureTestAnswer();
		
		lta.setCl_id(id);
		lta.setPb_idnum(pbidnum);
		lta.setPb_pbnum(pbnum);
		List<LectureTestAnswer> plist= ltaDao.selectPercentage(lta);
		
		
		return plist;
	}

	public List<LectureTestAnswer> selectLectureQuizAnswer(String id) {
		System.out.println(id);
		List<LectureTestAnswer> qlist= ltaDao.selectLectureQuizAnswer(id);
		if(qlist!=null){
			System.out.println("들어오냐");
			return qlist;
		}
		System.out.println("qlist: null");
		
		return qlist;
	}
}
