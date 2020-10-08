package com.icia.classManager;

import java.text.DateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.Gson;
import com.icia.course.CourseBean;


@Controller
public class ClassManagerController {
	
	@Autowired
	private ClassManagerMM cmm;

	
	@RequestMapping(value = "/prof/classuploadmanagerpage")
	public ModelAndView classuploadManagerPage(HttpSession session) {
		ModelAndView mav=new ModelAndView();
			mav.addObject("manager_classList" ,new Gson().toJson(cmm.selectClass(session)));
			mav.setViewName("teacher/gahee/classUploadManagerPage");
		return mav;
	}
	
	@RequestMapping(value = "/prof/selectmanagercoursehomeworkpage/{co_idnum}")
	public String selectManagerCourseHomeworkPage(@PathVariable String co_idnum, HttpSession session ) {
		System.out.println("방금 받아온 co_idnum: "+co_idnum);
		List<CourseBean> manager_courseList =cmm.selectCourse(co_idnum);
		session.setAttribute("courseList", new Gson().toJson(manager_courseList));
		//mav.addObject("courseList", new Gson().toJson(manager_courseList));
		//mav.setViewName("teacher/gahee/selectManagerCourseHomeworkPage");
		return "redirect:/prof/goselectmanagercoursehomeworkpage";
	}
	
	@RequestMapping(value = "/prof/selectmanagercoursehomeworkpage/{co_idnum}/{msg}", produces = {"text/plain;charset=utf-8", "application/json;charset=utf-8"})
	public String selectManagerCourseHomeworkPage(@PathVariable String co_idnum, @PathVariable String msg, HttpSession session, RedirectAttributes attr ) {
		List<CourseBean> manager_courseList =cmm.selectCourse(co_idnum);
		session.setAttribute("courseList", new Gson().toJson(manager_courseList));
		if(msg.equals("1")) {
			attr.addFlashAttribute("msg","성공하셨습니다.");
		}else if(msg.equals("2")){
			attr.addFlashAttribute("msg","다시 시도 해주세요");
		}
		
		return "redirect:/prof/goselectmanagercoursehomeworkpage";
	}
	
	

	


	

	
	
	
	
}
