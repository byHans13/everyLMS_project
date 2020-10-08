package com.icia.studyAvg;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.icia.lectureQuiz.LectureQuiz;

@Service
public class StudyAvgMM {
	@Autowired
	IStudyAvgDao sDao;
	
	ModelAndView mav;

	public List<StudyAvg> selectStudyAvg(String id) {
		System.out.println("강의별 반평균 리스트 MM");
		System.out.println(id);
		List<StudyAvg> list= sDao.selectStudyAvg(id);
		if(list!=null){
			System.out.println("들어오냐");
			return list;
		}
		System.out.println("qlist: null");
		
		return list;
		
	}

	public List<StudyAvg> selectboxStudyAvg(String id, String cont, String box) {
		System.out.println(id);
		System.out.println(cont);
		System.out.println(box);
		List<StudyAvg> list=null;
		
		switch (box) {
		case "0":
				System.out.println("전체검색");
				list= sDao.allSelectStudyAvg(id,cont);
			break;
		case "1":
				System.out.println("강의명 검색");
				list= sDao.classSelectStudyAvg(id,cont);
			break;
		case "2":
				System.out.println("강좌명 검색");
				list= sDao.courseSelectStudyAvg(id,cont);
			break;

		default:
				System.out.println("기본값을 들어온다고?");
			break;
		}
		
		return list;
	}

	public ModelAndView goStudyAvgShowPage(StudyAvg sa) {
		mav= new ModelAndView();
		String view=null;
		
		String co_name = sa.getCo_name();
		System.out.println("확인 :  "+co_name.replaceAll(",", " "));
		sa.setCo_name(co_name.replaceAll(",", " "));
		
		List<StudyAvg> list= sDao.selectStudyAvgShow(sa);
		if(list!=null) {
			view="teacher/gradeMM/goStudyAvgShowPage";
			mav.setViewName(view);
			mav.addObject("list",new Gson().toJson(list));
			mav.addObject("clname", sa.getCl_clname());
			mav.addObject("num", 1);
			return mav;
		}
		view="teacher/gradeMM/goStudyAvgShowPage";
		mav.setViewName(view);
		mav.addObject("list",new Gson().toJson(list));
		mav.addObject("clname", sa.getCl_clname());
		mav.addObject("num", 2);
		
		return mav;
	}
}
