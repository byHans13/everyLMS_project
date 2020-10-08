package com.icia.classup;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;


@Controller
public class ClassUpController {
	
	@Autowired
	private ClassUpMM cm;
	
	
	
	
	@RequestMapping(value = "/prof/classUploadPage", method = RequestMethod.GET)
	public String classuploadpage() {
		return "teacher/gahee/classUploadPage";
	}
	
	
	@RequestMapping(value = "/prof/insertclassupload", method = RequestMethod.POST)
	public ModelAndView insertclassupload(MultipartHttpServletRequest multi, HttpSession session, RedirectAttributes attr) {
		ModelAndView mav =new ModelAndView();
		mav = cm.insertclassupload(multi,attr,session);
		
		//fileName
		return mav;
		
	}

	

	
	
	
	
}
