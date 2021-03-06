package com.icia.planClass;


import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.icia.classup.ClassUpBean;

@Component
public class PlanClassMM {
	@Autowired 
	private IPlanClassDao pcd;

	
	public ModelAndView insertplanclass(HttpSession session, ClassUpBean cb, HttpServletRequest request, RedirectAttributes attr) {
		ModelAndView mav =new ModelAndView();
		System.out.println("idnum: "+cb.getPc_idnum());
		System.out.println("lv: "+cb.getPc_lv());
		System.out.println("title: "+cb.getPc_title());
		System.out.println("content: "+ cb.getPc_cont());
		
		boolean result = pcd.insertplanclass(cb);
		if(result) {
			System.out.println("planclassOOOOOOOOOOOOOO");
			 request.setAttribute("insertplanclass", "강의계획서 등록 성공");
			 mav.addObject("cl_ct", 0);
			 mav.setViewName("teacher/gahee/classmain");
		}else {
			System.out.println("planclassXXXXXXXXXXXXx");
			request.setAttribute("insertplanclass", "강의계획서 등록 실패");
			mav.setViewName("teacher/gahee/insertplanclasspage");
		}
		session.removeAttribute("idNum");
		session.removeAttribute("cl_name");
		session.removeAttribute("cl_lcnum");
		session.removeAttribute("cl_lv");

		return mav;
	}


	public ModelAndView updatePlanClassPage(String obj) {
		ModelAndView mav = new ModelAndView();
		mav.addObject("updatePlanClass",obj);
		mav.setViewName("teacher/gahee/updatePlanClassPage");
		return mav;
	}


	public ModelAndView updateplanclass(HttpSession session, ClassUpBean cub, RedirectAttributes attr) {
		ModelAndView mav = new ModelAndView();
		boolean result = pcd.updateplanclass(cub);
		
		if(result) {
			System.out.println("attr.getFlashAttributes():  "+attr.getFlashAttributes());
			mav.setViewName("redirect:/prof/classmain/0/1");
		}else{
			attr.addFlashAttribute("msg","강의 계획서 수정이 실패하였습니다. 다시시도 해 주세요");
			mav.setViewName("./");
		}
		session.removeAttribute("upPlanClass");
		return mav;
	}



	




}
