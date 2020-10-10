package com.icia.board;
//회원관리 서비스 클래스

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.Gson;
import com.icia.email.Email;
import com.icia.student.Clasc;
import com.icia.student.CourseBoard;
import com.icia.student.NomPaging;


@Service // @Component //IoC컨테이너 등록
public class BoardMM {
	@Autowired
	private BoardDao bDao;
	
	@Autowired
	JavaMailSender mailSender;
	
	ModelAndView mav;

	public ModelAndView insertcounselboard(String id, HttpSession session , Integer pageNum) {
		mav = new ModelAndView();
		String view = null;
		id = session.getAttribute("id").toString(); // 아이디가져오고
		List<CourseBoard> bList = null;
//		bList = bDao.insertcounselboard(id); // 게시판 뽑아오기
		pageNum = (pageNum == null) ? 1 : pageNum;
		List<CourseBoard> pList = bDao.Boardlist(pageNum); // 페이징 뽑아주기
		if (id != null) {
			mav.addObject("id", id);
			mav.addObject("bList",bList);
			mav.addObject("pList",pList);
			mav.addObject("Paging", boardgetPaging(pageNum));
			view = "insertboard/insertcounselboard";
		} else {
			view = "h2k5every";
		}
		mav.setViewName(view);

		return mav;
	}
	

	private String boardgetPaging(Integer pageNum) {
		int maxNum = bDao.getBoardCount(); // 전체글갯수
		int listCount = 10; // 페이지당 글의 개수
		int pageCount = 9; // 그룹당 페이지 개수
		String boardName = "insertcounselboard";
		NomPaging paging = new NomPaging(maxNum, pageNum, listCount, pageCount, boardName);
		return paging.makeHtmlPaging();
	}


	public ModelAndView boardwrite(MultipartHttpServletRequest mul) {
		mav = new ModelAndView();
		String view = null;
		String title = mul.getParameter("b_title"); // 작성된 제목(뷰페이지 보시면 input name 값에 b_title등으로 설정되어있습니다.) , 내용 , 아이디 파일
													// 등을 dao or mapper로 보내는 코드
		String contents = mul.getParameter("b_contents");
		String id = mul.getSession().getAttribute("id").toString();
		CourseBoard board = new CourseBoard();
		board.setCob_title(title).setCob_contents(contents).setCob_id(id);
		boolean b = bDao.boardWriteSelectKey(board);
		if (b) {
			view = "redirect:/boardlist";
		} else {
			view = "writeFrm";
		}
		return mav;
	}


	
	}
