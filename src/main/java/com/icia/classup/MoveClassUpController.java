package com.icia.classup;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class MoveClassUpController {
	
	

	
	@RequestMapping(value = "/prof/classmain/{cl_ct}")
	public String classmain(HttpSession session, @PathVariable String cl_ct) {
		session.removeAttribute("myCoList");
		Integer ct = Integer.parseInt(cl_ct);
		session.setAttribute("cl_ct", ct);
		return "redirect:/prof/goclassmain";
	}
	
	@RequestMapping(value = "/prof/classmain/{cl_ct}/{msg}")
	public String classmain(HttpSession session, @PathVariable String cl_ct, @PathVariable String msg ,RedirectAttributes attr) {
		session.removeAttribute("myCoList");
		Integer ct = Integer.parseInt(cl_ct);
		session.setAttribute("cl_ct", ct);
		if(msg.equals("1")) {
			attr.addFlashAttribute("msg","성공하셨습니다.");
		}else {
			attr.addFlashAttribute("msg","다시시도해주세요");
		}
		return "redirect:/prof/goclassmain";
	}
	
	
	@RequestMapping("/prof/goclassmain")
	public String goclassmain() {
	return "teacher/gahee/classmain";
	}

}
