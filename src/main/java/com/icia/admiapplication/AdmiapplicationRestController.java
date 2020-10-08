package com.icia.admiapplication;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.google.gson.Gson;

@org.springframework.web.bind.annotation.RestController
public class AdmiapplicationRestController {
	@Autowired
	private AdmiapplicationMM am;
	
	
	

	
		@RequestMapping(value = "/prof/rest/aaList")
		public String aaList(String cl_lv, String cl_idnum) {
			List<AdmiapplicationBean> aaList = am.aaList(cl_lv,cl_idnum);
			return new Gson().toJson(aaList);	
		
	}


}
