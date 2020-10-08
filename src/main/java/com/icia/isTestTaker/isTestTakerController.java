package com.icia.isTestTaker;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class isTestTakerController {
	@Autowired
	isTestTakerMM im;
	
	ModelAndView mav;
	
	@RequestMapping(value = "/prof/goIsTestTakerPage", method = RequestMethod.GET)
	public String gosearchidspage() {
		System.out.println("시험 응시 확인 페이지");
		
		return "teacher/afterService/isTestTaker";
	}
	
	@RequestMapping(value = "/prof/goisTestTakerShowPage", method = RequestMethod.POST)
	public ModelAndView goisTestTakerShowPage(isTestTaker it) {
		System.out.println("시험 응시 확인 상세페이지");
		String a=it.getCo_name().replaceAll(",", " ");
		String b=it.getCl_clname().replaceAll(",", " ");
		System.out.println(a);
		System.out.println(b);
		System.out.println(it.getCl_lcnum());
		it.setCl_clname(b);
		it.setCo_name(a);
		
		mav = im.goisTestTakerShowPage(it);
		
		return mav;
	}
}
