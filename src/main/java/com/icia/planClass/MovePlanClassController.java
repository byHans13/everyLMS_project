package com.icia.planClass;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class MovePlanClassController {
	
	@RequestMapping("/prof/goplanclass")
	public String insertplanclasspage() {
		return "teacher/gahee/insertplanclasspage";
	}
	
	@GetMapping(value  = "/prof/insertplanclasspage/{idNum}/{cl_name}/{cl_lcnum}/{cl_lv}")
	public String insertlecturepage(HttpSession session, @PathVariable String idNum, @PathVariable String cl_name, @PathVariable String cl_lcnum, @PathVariable  String cl_lv) {
		session.setAttribute("idNum", idNum);
		session.setAttribute("cl_name", cl_name);
		session.setAttribute("cl_lcnum", cl_lcnum);
		session.setAttribute("cl_lv", cl_lv);
		return "redirect:/prof/goplanclass";
		
	}
	
	@RequestMapping(value = "/prof/updateplanclasspage/{obj}/")
	public String updateplanclasspage(HttpSession session, @PathVariable String obj) {
		session.setAttribute("upPlanClass", obj);
		return "redirect:/prof/goupdateplanclasspage";	
	} 
	
	@RequestMapping("/prof/goupdateplanclasspage")
	public String goupdateplanclasspage() {
		return "teacher/gahee/updatePlanClassPage";
	}

}
