package com.icia.msg;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.taglibs.standard.lang.jstl.test.beans.PublicBean1;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.icia.classup.ClassUpBean;

@Controller
public class MsgController {

	
	@Autowired
	MsgMM msgm;
	

//	@RequestMapping(value = "/prof/insertplanclass", method = RequestMethod.POST)
//	public ModelAndView insertplanclass(HttpSession session, HttpServletRequest request, ClassUpBean cb,RedirectAttributes attr) {
//		ModelAndView mav=pcm.insertplanclass(session,cb,request,attr);
//		return mav;
//		
//	}
//	
//
//	@RequestMapping(value = "/prof/updateplanclass")
//	public ModelAndView updateplanclass(HttpSession session, ClassUpBean cub , RedirectAttributes attr) {	
//		ModelAndView mav = pcm.updateplanclass(session,cub,attr);
//		return mav;	
//	} 
//	
	
	
	
	
	
	
}
