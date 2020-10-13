package com.icia.allmain;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.icia.member.IMemberDao;


@RestController
public class AllMainRestController {
	
	@Autowired
	AllMainService amMM;
	
	
	
	@RequestMapping(value = "/stud/rest/selectmainstudentview")
	public List<AllmainBean> selectmainstudentview(AllmainBean alb, HttpSession session) {
		List<AllmainBean> amList = new ArrayList<AllmainBean>();
		amList = amMM.selectmainstudentview(alb,session);
		return amList;
		
	}

}
