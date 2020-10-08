package com.icia.Recommendedlecture;
//회원관리 서비스 클래스

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.icia.student.Clasc;
import com.icia.student.Paging;
import com.icia.student.StudentDao;

@Service // @Component //IoC컨테이너 등록
public class RecommendMM {
	@Autowired
	private RecommendDao rDao;
	@Autowired
	private StudentDao sDao;

	ModelAndView mav;

	public ModelAndView selectMyInterestLevelMatchPage(String id, HttpSession session) { //레벨에 맞는 추천강의
		mav = new ModelAndView();
		String view = null;
		id = session.getAttribute("id").toString(); //아이디 따오고
		List<Levels> lList = null;
		lList = rDao.LevelMatchPage(id); //셀렉트박스 넣어주고
		if (lList != null) {
			mav.addObject("id", id);
			mav.addObject("lList", lList);
			view = "MyInterestLevelMatch/selectMyInterestLevelMatchPage";
		} else {
			view = "h2k5every";
		}

		mav.setViewName(view);
		return mav;
	}

	public List<Clasc> selectMyLevelMatch(String MyLevel) { //셀렉트박스 체인지 에이작스
		List<Clasc> cList = rDao.selectMyLevelMatch(MyLevel);
		return cList;
	}

	public ModelAndView levelmatchsearch(String id, String selvalue, String search, HttpSession session,
			Integer pageNum) { //레벨 매칭 검색기능
		mav = new ModelAndView();
		List<Levels> lList = null;
		id = session.getAttribute("id").toString();
		lList = rDao.LevelMatchPage(id);
		List<Clasc> cList = null;
		pageNum = (pageNum == null) ? 1 : pageNum;
		cList = rDao.searchLevelDetail(pageNum,search, selvalue);
	
		System.out.println(search);
		mav.addObject("lList", lList);
		mav.addObject("cList", cList);
		mav.addObject("Paging", LevelMatchpaging(pageNum, search , selvalue));

		mav.setViewName("MyInterestLevelMatch/selectMyInterestLevelMatchPage");
		return mav;
	}

	private String LevelMatchpaging(Integer pageNum, String search , String selvalue) { // 레벨 매칭 페이징
		int maxNum = rDao.getlevelmatchCount(search,selvalue);
		int listCount = 5; // 페이지당 글의 개수
		int pageCount = 4; // 그룹당 페이지 개수
		String boardName = "levelmatchsearch";
		Paging paging = new Paging(maxNum, pageNum, listCount, pageCount, boardName, search,selvalue);
		return paging.makeHtmlPaging();
	}

	public ModelAndView selectInterestClassPage(String id, HttpSession session) { //관심 매칭 추천 강의
		mav = new ModelAndView();
		String view = null;
		id = session.getAttribute("id").toString();
		List<Concern> CList = null;
		CList = rDao.CCMatchPage(id);
		if (CList != null) {
			mav.addObject("id", id);
			mav.addObject("CList", CList);
			view = "selectInterestClassPage/selectInterestClassPage";
		} else {
			view = "h2k5every";
		}

		mav.setViewName(view);
		return mav;
	}

	public List<Clasc> selectMyinterestAjax(String Mycc) { // 관심 셀렉트박스 체인지 펑션
		List<Clasc> cList = rDao.selectMyinterestAjax(Mycc);
		return cList;
	}

	public ModelAndView lnterestSearch(String id, String selvalue, String search, HttpSession session,
			Integer pageNum) { //관심 매칭 검색기능
		mav = new ModelAndView();
		id = session.getAttribute("id").toString();
		List<Concern> CList = null;
		CList = rDao.CCMatchPage(id);
		List<Clasc> cList = null;
		pageNum = (pageNum == null) ? 1 : pageNum;
		cList = rDao.lnterestSearchDetail(pageNum, search ,selvalue);
		mav.addObject("CList", CList);
		mav.addObject("cList", cList);
		mav.addObject("Paging", lnterestSearchpaging(pageNum, search, selvalue));

		mav.setViewName("selectInterestClassPage/selectInterestClassPage");
		return mav;
	}
	private String lnterestSearchpaging(Integer pageNum, String search ,String selvalue) {
		int maxNum = rDao.lnterestCount(search,selvalue);
		int listCount = 5; // 페이지당 글의 개수
		int pageCount = 2; // 그룹당 페이지 개수
		String boardName = "lnterestSearch";
		Paging paging = new Paging(maxNum, pageNum, listCount, pageCount, boardName, search, selvalue);
		return paging.makeHtmlPaging();
	}
	public ModelAndView DeeplearningSearch(String id, String selvalue, String search, HttpSession session,
			Integer pageNum) { //심화학습 검색
		mav = new ModelAndView();
		id = session.getAttribute("id").toString();
		List<Concern> CList = null;
		CList = rDao.CCMatchPage(id);
		List<Clasc> cList = null;
		pageNum = (pageNum == null) ? 1 : pageNum;
	cList = rDao.DeeplearningSearchDetail(pageNum, search ,selvalue);	
	int viewlevel = rDao.selectMyDeepenlnterestAjax(id);
	    mav.addObject("viewlevel",viewlevel);
		mav.addObject("CList", CList);
		mav.addObject("cList", cList);
		mav.addObject("Paging", DeeplearningSearchpaging(pageNum, search ,selvalue));
		
		mav.setViewName("SelectMyDeepenlnterest/selectMyDeepenInterestPage");
		return mav;
	}
	private String DeeplearningSearchpaging(Integer pageNum, String search , String selvalue) {
		int maxNum = rDao.lnterestCount(search, selvalue);
		int listCount = 5; // 페이지당 글의 개수
		int pageCount = 4; // 그룹당 페이지 개수
		String boardName = "DeeplearningSearch";
		Paging paging = new Paging(maxNum, pageNum, listCount, pageCount, boardName, search , selvalue);
		return paging.makeHtmlPaging();
	}

	public ModelAndView selectMyDeepenInterestPage(String id, HttpSession session) {
		mav = new ModelAndView();
		String view = null;
		id = session.getAttribute("id").toString();
		List<Concern> CList = null;
		CList = rDao.CCMatchPage(id);
		if (CList != null) {
			mav.addObject("id", id);
			mav.addObject("CList", CList);
			view = "SelectMyDeepenlnterest/selectMyDeepenInterestPage";
		} else {
			view = "h2k5every";
		}

		mav.setViewName(view);
		return mav;
	}

	public List<Clasc> selectMylnterestLevel(String lnterestLevel) {
		List<Clasc> cList = rDao.selectMylnterestLevel(lnterestLevel);
		return cList;
	}

	public int selectMyDeepenlnterestAjax(String mb_id) {
		int cList  = rDao.selectMyDeepenlnterestAjax(mb_id);
		return cList;
	}


}	
