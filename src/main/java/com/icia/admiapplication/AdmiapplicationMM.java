package com.icia.admiapplication;

 
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.icia.course.CourseBean;
import com.icia.classup.ClassUpBean;

@Component
public class AdmiapplicationMM {
	
	@Autowired 
	private IAdmiapplicationDao ad;

	public List<AdmiapplicationBean> aaList(String aa_lv, String aa_idnum) {
		List<AdmiapplicationBean> aaList = ad.selectAaList(aa_lv, aa_idnum);
		return aaList;
	}



}
