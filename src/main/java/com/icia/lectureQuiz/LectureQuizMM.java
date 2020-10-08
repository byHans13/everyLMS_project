package com.icia.lectureQuiz;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.Gson;

@Service
public class LectureQuizMM {
	@Autowired
	private ILectureQuizDao qDao;
	
	ModelAndView mav;
	
	public List<LectureQuiz> selectLectureQuiz(String id) {
		System.out.println("퀴즈 서비스");
		System.out.println(id);
		List<LectureQuiz> qlist= qDao.selectLectureQuiz(id);
		if(qlist!=null){
			System.out.println("들어오냐");
			return qlist;
		}
		System.out.println("qlist: null");
		
		return qlist;
	}

	public List<LectureQuiz> selectboxLectureQuiz(String id, String cont, String box) {
		//셀렉박스 이용한 검색 기능 구현
		System.out.println(id);
		System.out.println(cont);
		System.out.println(box);
		List<LectureQuiz> qlist=null;
		
		switch (box) {
		case "0":
				System.out.println("전체검색");
				qlist= qDao.allSelectLectureQuiz(id,cont);
			break;
		case "1":
				System.out.println("강의명 검색");
				qlist= qDao.classSelectLectureQuiz(id,cont);
			break;
		case "2":
				System.out.println("강좌명 검색");
				qlist= qDao.courseSelectLectureQuiz(id,cont);
			break;

		default:
				System.out.println("기본값을 들어온다고?");
			break;
		}
		
		return qlist;
	}

	public ModelAndView goLectureQuizShowPage(String clname, String name, String lcnum, String id) {
		
		List<LectureQuiz> qlist=qDao.LectureQuizShow(id, name, lcnum);
		mav= new ModelAndView();
		String view=null;
		
			if(qlist!=null) {
				view= "teacher/testMM/LectureQuizShow";
				mav.setViewName(view);
				mav.addObject("qlist", new Gson().toJson(qlist));
				mav.addObject("clname", clname);
				return mav;
			}
			mav.setViewName("teacher/testMM/LectureQuizShow");
			mav.addObject("qlist", "0");
			mav.addObject("clname", clname);

			return mav;
	}

	public List<LectureQuiz> selectLectureTest(String id) {
		
		System.out.println("시험 서비스");
		System.out.println(id);
		List<LectureQuiz> qlist= qDao.selectLectureTest(id);
		if(qlist!=null){
			System.out.println("들어오냐");
			return qlist;
		}
		System.out.println("qlist: null");
		
		return qlist;
	}

	public List<LectureQuiz> selectboxLectureTest(String id, String cont, String box) {
		System.out.println(id);
		System.out.println(cont);
		System.out.println(box);
		List<LectureQuiz> qlist=null;
		
		switch (box) {
		case "0":
				System.out.println("전체검색");
				qlist= qDao.allSelectLectureTest(id,cont);
			break;
		case "1":
				System.out.println("강의명 검색");
				qlist= qDao.classSelectLectureTest(id,cont);
			break;
		case "2":
				System.out.println("강좌명 검색");
				qlist= qDao.courseSelectLectureTest(id,cont);
			break;

		default:
				System.out.println("기본값을 들어온다고?");
			break;
		}
		
		return qlist;
	}

	public ModelAndView goLectureTestShowPage(LectureQuiz lq) {

		List<LectureQuiz> qlist=qDao.LectureTestShow(lq);
		mav= new ModelAndView();
		String view=null;
		
			if(qlist!=null) {
				view= "teacher/testMM/LectureTestShow";
				mav.setViewName(view);
				mav.addObject("qlist", new Gson().toJson(qlist));
				mav.addObject("clname", lq.getCl_clname());
				return mav;
			}
			mav.setViewName("teacher/testMM/LectureTestShow");
			mav.addObject("qlist", "0");
			mav.addObject("clname", lq.getCl_clname());

			return mav;
	}

	public ModelAndView goStudentCommentPage(LectureQuiz lq) {
		mav= new ModelAndView();
		String view=null;
		
		view= "teacher/testMM/studentCommentInput";
		mav.setViewName(view);
		mav.addObject("lq", new Gson().toJson(lq));
		
		return mav;
	}

	public ModelAndView studentCommentInsert(LectureQuiz lq, RedirectAttributes attr) {
		mav= new ModelAndView();
		String view=null;
		
		if(qDao.studentCommentInsert(lq)) {
			mav.setViewName("redirect:goLectureTestPage");
			attr.addFlashAttribute("msg", "작성 완료 되었습니다.");
			return mav;
		}else {
			mav.setViewName("redirect:goLectureTestPage");
			attr.addFlashAttribute("msg", "실패! 다시 작성해주세요.");		
		}
	return mav;

    }

	public ModelAndView goStudentCommentSeePage(LectureQuiz lq) {
		mav= new ModelAndView();
		String view=null;
		
		view= "teacher/testMM/studentCommentSee";
		mav.setViewName(view);
		if(lq.getTfb_feedback().equals("")) {
			mav.addObject("lq", "0");
			return mav;
		}
		mav.addObject("lq", new Gson().toJson(lq));
		
		return mav;
	}

	public ModelAndView goStudentCommentUpdatePage(LectureQuiz lq) {
		mav= new ModelAndView();
		String view=null;
		
		view= "teacher/testMM/studentCommentUpdate";
		mav.setViewName(view);
		if(lq.getTfb_feedback().equals("")) {
			mav.addObject("lq", "0");
			return mav;
		}
		mav.addObject("lq", new Gson().toJson(lq));
		
		return mav;
	}

	public ModelAndView studentCommentUpdate(LectureQuiz lq, RedirectAttributes attr) {
		
		if(qDao.studentCommentUpdate(lq)) {
			mav.setViewName("redirect:goLectureTestPage");
			attr.addFlashAttribute("msg", "수정이 완료 되었습니다.");
			return mav;
		}else {
			mav.setViewName("redirect:goLectureTestPage");
			attr.addFlashAttribute("msg", "실패! 다시 작성해주세요.");		
		}
		
	return mav;
	}
	
	
	
}