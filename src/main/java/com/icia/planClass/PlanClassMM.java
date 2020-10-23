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

	
	public ModelAndView insertplanclass(HttpSession session, ClassUpBean cb) {
		ModelAndView mav =new ModelAndView();
		boolean result = pcd.insertplanclass(cb);
		if(result) {
			 mav.addObject("cl_ct", 0);
			 mav.setViewName("teacher/gahee/classmain");
		}else {
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


	public ModelAndView updateplanclass(HttpSession session, ClassUpBean cub, RedirectAttributes attr, String lv) {
		ModelAndView mav = new ModelAndView();
		cub.setPc_lv(Integer.parseInt(lv));
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
