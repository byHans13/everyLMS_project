package com.icia.isTestTaker;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;


@Service
public class isTestTakerMM {
	@Autowired
	private IisTestTaker iDao;
	
	ModelAndView mav;
	
	public List<isTestTaker> selectIsTestTaker(String id) {
		System.out.println("퀴즈 서비스");
		System.out.println(id);
		List<isTestTaker> qlist= iDao.selectIsTestTaker(id);
		if(qlist!=null){
			System.out.println("들어오냐");
			return qlist;
		}
		System.out.println("qlist: null");
		
		return qlist;
	}

	public List<isTestTaker> selectboxIsTestTaker(String id, String cont, String box) {
		System.out.println(id);
		System.out.println(cont);
		System.out.println(box);
		List<isTestTaker> qlist=null;
		
		switch (box) {
		case "0":
				System.out.println("전체검색");
				qlist= iDao.allSelectIsTestTaker(id,cont);
			break;
		case "1":
				System.out.println("강의명 검색");
				qlist= iDao.classSelectLectureTestAnswer(id,cont);
			break;
		case "2":
				System.out.println("강좌명 검색");
				qlist= iDao.courseSelectIsTestTaker(id,cont);
			break;

		default:
				System.out.println("기본값을 들어온다고?");
			break;
		}
		
		return qlist;
	}

	public ModelAndView goisTestTakerShowPage(isTestTaker it) {
		mav= new ModelAndView();
		String view=null;
		
		List<isTestTaker> numlist= iDao.selectnumlist(it);
		
		if(numlist!=null) {
			int maxnum=0;
			
			for(int i=0;i<numlist.size(); i++) {
				if(maxnum<numlist.get(i).gr_num) {
					maxnum++;
				}
			}
			System.out.println(maxnum);
			it.setGr_num(maxnum);
			
			view= "teacher/afterService/goisTestTakerShowPage";
			mav.setViewName(view);
			mav.addObject("it", new Gson().toJson(it));
			
		return mav;
		
		}
		return mav;
	}

	public List<isTestTaker> isTestTakerSelect(String co_name, Integer gr_num) {
		isTestTaker it = new isTestTaker();
		
		it.setCo_name(co_name);
		it.setGr_num(gr_num);
		System.out.println(it.getGr_num());
		
		List<isTestTaker> list=iDao.isTestTakerSelect(it);
		
		return list;
	}

}
