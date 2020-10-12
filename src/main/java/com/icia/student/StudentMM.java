package com.icia.student;
//회원관리 서비스 클래스

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;

@Service // @Component //IoC컨테이너 등록
public class StudentMM {
	@Autowired
	private StudentDao sDao;

	ModelAndView mav;

	public ModelAndView selectMyClassProgressPage(String id, HttpSession session) { // 강의진도 확인
		mav = new ModelAndView();
		String view = null;
		id = session.getAttribute("id").toString(); // 아이디가져오고
		List<Clasc> sList = null;
		sList = sDao.selectMyClassProgressPage(id); // 셀렉트박스에 강의명 넣어주기
		if (id != null) {
			mav.addObject("id", id);
			mav.addObject("sList", sList);
			view = "Classprogress/selectMyClassProgressPage";
		} else {
			view = "h2k5every";
		}
		mav.setViewName(view);

		return mav;

	}

	public ModelAndView selectClassReviewAjax(String id, HttpSession session) { // 리뷰 셀렉트박스 넣기
		mav = new ModelAndView();
		String view = null;
		id = session.getAttribute("id").toString(); // 아이디넣어주고
		List<Clasc> sList = null;
		sList = sDao.selectMyClassProgressPage(id); // 셀렉박스에 강의명 넣어주기
		System.out.println(id);
		if (id != null) {
			mav.addObject("id", id);
			mav.addObject("sList", sList);
			view = "ClassReview/selectClassReviewAjax";
		} else {
			view = "h2k5every";
		}
		mav.setViewName(view);

		return mav;
	}

	public ModelAndView reviewselectbtn(String id, String search, HttpSession session, Integer pageNum) { //리뷰 게시판
		mav = new ModelAndView();
		id = session.getAttribute("id").toString();
		List<Clasc> sList = null;
		sList = sDao.selectMyClassProgressPage(id); // 셀렉박스에 강의명 넣어주기
		pageNum = (pageNum == null) ? 1 : pageNum;
		List<Clasc> cList = sDao.reviewlist(pageNum, search); // 게시판 뽑아주기
		if (search != null) {
			mav.addObject("cList", cList);
			mav.addObject("sList", sList);
			mav.addObject("Paging", reviewsearchgetPaging(pageNum, search)); // 페이징
		}
		mav.setViewName("ClassReview/selectClassReviewAjax");
		return mav;
	}

	private String reviewsearchgetPaging(Integer pageNum, String search) {
		int maxNum = sDao.getreviewCount(search); // 전체글갯수
		int listCount = 10; // 페이지당 글의 개수
		int pageCount = 9; // 그룹당 페이지 개수
		String boardName = "reviewselectbtn";
		NomPaging paging = new NomPaging(maxNum, pageNum, listCount, pageCount, boardName, search);
		return paging.makeHtmlPaging();
	}

	public ModelAndView searchClassreviewDetail(String id, String selvalue, String search, Integer pageNum,
			HttpSession session) { //리뷰 게시판 검색기능
		mav = new ModelAndView();
		id = session.getAttribute("id").toString();
		List<Clasc> sList = sDao.selectMyClassProgressPage(id);
		List<Clasc> cList = null;
		pageNum = (pageNum == null) ? 1 : pageNum;
		cList = sDao.searchClassReviewDetail(pageNum, search ,selvalue);
		mav.addObject("cList", cList);
		mav.addObject("sList", sList);
		mav.addObject("Paging", reivewpaging(pageNum, search , selvalue));

		mav.setViewName("ClassReview/selectClassReviewAjax");
		return mav;
	}

	private String reivewpaging(Integer pageNum, String search , String selvalue) {
		int maxNum = sDao.getreviewDetailCount(search,selvalue);
		int listCount = 10; // 페이지당 글의 개수
		int pageCount = 9; // 그룹당 페이지 개수
		String boardName = "searchClassreviewDetail";
		Paging paging = new Paging(maxNum, pageNum, listCount, pageCount, boardName, search , selvalue);
		return paging.makeHtmlPaging();
	}

	public ModelAndView selectClassQnaAjax(String id, HttpSession session) { //QNA 게시판
		mav = new ModelAndView();
		String view = null;
		id = session.getAttribute("id").toString();
		List<Clasc> sList = null;
		sList = sDao.selectMyClassProgressPage(id);// 셀렉박스에 강의명 넣어주기
		if (id != null) {
			mav.addObject("id", id);
			mav.addObject("sList", sList);
			view = "myQ&A/selectClassQnaAjax";
		} else {
			view = "h2k5every";
		}
		mav.setViewName(view);

		return mav;
	}

	public ModelAndView searchbtn(String id, HttpSession session, String search, Integer pageNum) { //본인 강의 셀렉트박스
		mav = new ModelAndView();
		List<Clasc> cList = null;
		id = session.getAttribute("id").toString();
		List<Clasc> sList = null;
		sList = sDao.selectMyClassProgressPage(id);// 셀렉박스에 강의명 넣어주기
		pageNum = (pageNum == null) ? 1 : pageNum;
		cList = sDao.getsearchqnaList(pageNum, search);
		mav.addObject("cList", cList);
		mav.addObject("sList", sList);
		mav.addObject("Paging", searchgetPaging(pageNum, search)); // 페이징

		mav.setViewName("myQ&A/selectClassQnaAjax");
		return mav;

	}

	private String searchgetPaging(Integer pageNum, String search) {
		int maxNum = sDao.getqnaCount(search);
		int listCount = 10; // 페이지당 글의 개수
		int pageCount = 9; // 그룹당 페이지 개수
		String boardName = "searchbtn";
		NomPaging paging = new NomPaging(maxNum, pageNum, listCount, pageCount, boardName, search);
		return paging.makeHtmlPaging();
	}

	public ModelAndView searchClassQnaDetail(String id, String selvalue, String search, Integer pageNum,
			HttpSession session) { //QNA 게시판 검색기능
		mav = new ModelAndView();
		id = session.getAttribute("id").toString();
		List<Clasc> sList = sDao.selectMyClassProgressPage(id);
		List<Clasc> cList = null;
		pageNum = (pageNum == null) ? 1 : pageNum;
		cList = sDao.searchClassQnaDetail(pageNum, search , selvalue);
		mav.addObject("cList", cList);
		mav.addObject("sList", sList);
		mav.addObject("Paging", qnasearchgetPaging(pageNum, search,selvalue));

		mav.setViewName("myQ&A/selectClassQnaAjax");
		return mav;
	}

	private String qnasearchgetPaging(Integer pageNum, String search , String selvalue) {
		int maxNum = sDao.getqnaDetailCount(search,selvalue);
		int listCount = 10; // 페이지당 글의 개수
		int pageCount = 9; // 그룹당 페이지 개수
		String boardName = "searchClassQnaDetail";
		Paging paging = new Paging(maxNum, pageNum, listCount, pageCount, boardName, search,selvalue);
		return paging.makeHtmlPaging();
	}

	public ModelAndView QNAselectbtn(String id, String selvalue, String search, Integer pageNum, HttpSession session) {
		mav = new ModelAndView();
		id = session.getAttribute("id").toString();// 아이디 갖고오기
		List<Clasc> sList = null;
		sList = sDao.selectMyClassProgressPage(id);// 셀렉박스에 강의명 넣어주기
		pageNum = (pageNum == null) ? 1 : pageNum;
		List<Clasc> cList = sDao.getsearchqnaList(pageNum, search);
		if (search != null) {
			mav.addObject("cList", cList); // 셀렉박스
			mav.addObject("CList", sList); // 게시판
			mav.addObject("Paging", searchgetPaging(pageNum, search)); // 페이징
		}
		mav.setViewName("myQ&A/selectClassQnaAjax");
		return mav;
	}

	public ModelAndView selectMyMemoPage(String id, HttpSession session) {
		mav = new ModelAndView();
		String view = null;
		id = session.getAttribute("id").toString();
		List<Clasc> sList = null;
		sList = sDao.selectMyClassProgressPage(id);
		if (id != null) {
			mav.addObject("id", id);
			mav.addObject("sList", sList);
			view = "Memo/selectMyMemoPage";
		} else {
			view = "h2k5every";
		}

		mav.setViewName(view);

		return mav;
	}

	public List<Clasc> selectClassListAjax(String cl_clname, HttpSession session) {
		String id=session.getAttribute("id").toString();
		System.out.println("mins id 추가확인 : " + id);
		List<Clasc> cList = sDao.selectClassListAjax(cl_clname,id);
		return cList;
	}

	public List<Clasc> clickmymemo(String Cl_idnum, HttpSession session) {
		List<Clasc> cList = sDao.clickmymemo(Cl_idnum);
		return cList;
	}

	public void updatemymemo(HashMap<String, Object> test, HttpSession session) {// 프로젝트

		sDao.updatemymemo(test);
	}

	public List<Clasc> Memo(HashMap<String, Object> memoview) {
		System.out.println(memoview);
		List<Clasc> cList = sDao.Memo(memoview);
		return cList;

	}

	public void cobdelete(HashMap<String, Object> cobdelete, HttpSession session) {
		sDao.cobdelete(cobdelete);

	}

	public ModelAndView Addpoint(String id, HttpSession session) {
		mav = new ModelAndView();
		String view = null;
		id = session.getAttribute("id").toString();
		String Point = null;
		Point = sDao.selectMypoint(id);
		if (id != null) {
			mav.addObject("id", id);
			mav.addObject("Point",Point);
			view = "Addpoint/Addpoint";
		} else {
			view = "h2k5every";
		}

		mav.setViewName(view);

		return mav;
	}

	public String selectMyPointAjax(String pt_id, HttpSession session) {
		String pt_pt = sDao.selectMyPointAjax(pt_id);
		return pt_pt;
	}

	public ModelAndView Payment(String id, String onechk, HttpSession session, HttpServletRequest req , String resultpt) {
		mav = new ModelAndView();
		String view = null;
		id = session.getAttribute("id").toString();
		String Point = null;
		Point = sDao.selectMypoint(id);
		onechk = req.getParameter("onechk").toString();
		resultpt = req.getParameter("resultpt").toString();
		if(onechk != null) {
			
		mav.addObject("id", id);
		mav.addObject("Point",Point);		
		mav.addObject("resultpt",resultpt);		
		mav.addObject("onechk", onechk);
		view = "Addpoint/PointCharge";
		}else {
			mav.addObject("id", id);
			mav.addObject("Point",Point);		
			mav.addObject("resultpt",resultpt);	
			view = "Addpoint/PointCharge";
		}
		mav.setViewName(view);
		return mav;
	}

	public ModelAndView PointCharge(String id, String resultpt, HttpServletRequest req,HttpSession session) {
		mav = new ModelAndView();
		String view = null;
		id = session.getAttribute("id").toString();
		resultpt = req.getParameter("resultpt").toString();
	    sDao.UpdateMyPoint(resultpt,id);
		mav.addObject("id", id);
		mav.addObject("resultpt", resultpt);
		view = "Addpoint/complete";
		mav.setViewName(view);
		return mav;
	}
	
	 public ModelAndView selectClassHomePage(Clasc cb, HttpSession session) {
	      List<Clasc> cList;
	      List<CourseBoard> rList;
	      mav = new ModelAndView();
	      String view;
	      String avgNum = null;
	      cList = sDao.selectClassHome(cb);
	      session.setAttribute("classId", cList.get(0).getCl_id());
	      if (cList != null) {
	         avgNum = sDao.selectClassAvgNum(cb);
	         if (avgNum == null) {
	            avgNum = "0";
	         }
	         rList = sDao.selectInfoReview(cb);
	         System.out.println(rList);
	         view = "Student/ClassHome/ClassHome";
	      } else {
	         view = "./";
	         rList = null;
	      }
	      mav.addObject("classInfo", new Gson().toJson(cList));
	      mav.addObject("avgNum", avgNum);
	      mav.addObject("infoReview", new Gson().toJson(rList));
	      mav.setViewName(view);
	      return mav;
	   }

	
	
	
	
	
}
