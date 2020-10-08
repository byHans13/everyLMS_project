package com.icia.introductionTeacherConfirm;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class IntroductionTeacherConfirmController {

	@Autowired
	IntroductionTeacherConfirmService itccmm;
	
	@RequestMapping(value = "/stud/register", method = RequestMethod.POST)
	public ModelAndView registerToProf(MultipartHttpServletRequest multi) {
		System.out.println("강사등록 하러 갈때");
		ModelAndView mav=new ModelAndView();
		mav = itccmm.registerToProf(multi);
		return mav;
	}
	
}
