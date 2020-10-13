package com.icia.allmain;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


@Service
public class AllMainService {
	
	
	@Autowired
	private IAllMainDao amDao;

	public List<AllmainBean> selectmainstudentview(AllmainBean alb, HttpSession session) {
		alb.setCc_id(session.getAttribute("id").toString());
		ArrayList<String> cl_cc= amDao.selectCc(alb.getCc_id());
		alb.setCc_cc(cl_cc);
		System.out.println("hans cc"+alb.getCc_cc());
		List<AllmainBean> amList= new ArrayList<AllmainBean>();
	
			amList = amDao.selectmainstudentview();
			
		
		return amList;
	}

}
