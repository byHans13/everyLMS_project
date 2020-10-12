package com.icia.course;

import java.io.UnsupportedEncodingException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class MoveCourseController {
	
	
	
	@RequestMapping(value = "/prof/coursePage/{co_lv}/{co_idnum}/{co_lcnum}")
	public String insertCoursePage(HttpSession session, @PathVariable String co_lv, @PathVariable String co_idnum , @PathVariable String co_lcnum){
		session.setAttribute("co_lv", co_lv);
		session.setAttribute("co_idnum", co_idnum);
		session.setAttribute("co_lcnum", co_lcnum);
		return "redirect:/prof/gocoursepage";
	}
	@RequestMapping(value = "/prof/coursePage/{co_lv}/{co_idnum}/{co_lcnum}/{msg}", produces = {"text/plain;charset=utf-8", "application/json;charset=utf-8"})
	public String insertCoursePage(HttpServletRequest request, HttpSession session, @PathVariable String co_lv, @PathVariable String co_idnum , @PathVariable String co_lcnum, @PathVariable String msg){
		try {
			request.setCharacterEncoding("UTF-8");
			System.out.println("co_lv: "+ co_lv);
			System.out.println("co_idnum: "+ co_idnum);
			System.out.println("co_lcnum: "+co_lcnum);
			session.setAttribute("co_lv", co_lv);
			session.setAttribute("co_idnum", co_idnum);
			session.setAttribute("co_lcnum", co_lcnum);
			session.setAttribute("msg", msg);
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return "redirect:/prof/gocoursepage";
	}
	
	
	@RequestMapping("/prof/gocoursepage")
	public String goclassmain() {
	return "teacher/gahee/coursePage";
	}
	
	
	
	@RequestMapping("prof/goselectcoursepage")
	public String goselectcoursepage() {
	return "teacher/gahee/selectcoursepage";
	}
	
	
	
	
	@RequestMapping(value = "/prof/insertcoursePage/{co_idnum}/{co_num}" )
	public String insertcoursePage(HttpSession session, @PathVariable String co_idnum, @PathVariable String co_num){
		session.setAttribute("co_idnum", co_idnum);
		session.setAttribute("co_num", co_num);
		return "redirect:/prof/gonsertcoursepage";
	}
	
	@RequestMapping("prof/gonsertcoursepage")
	public String gonsertcoursepage() {
	return "teacher/gahee/insertcoursepage";
	}
	
	
	
	
	
	
	
	
	
	
	

}
