package com.icia.goGradePercentagePage;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;

@Service
public class GradePercentageMM {
	@Autowired
	IgradePercentage gDao;
	
	ModelAndView mav;

	public ModelAndView goGradePercentagePage() {
		mav=new ModelAndView();
		String view=null;
		
		SecurityContext context = SecurityContextHolder.getContext();
		User user = (User) context.getAuthentication().getPrincipal();
		System.out.println(user.getUsername());
		String id= user.getUsername();
		
		List<GradePercentage> glist= gDao.goGradePercentagePage(id);
		
		view="teacher/gradeMM/goGradePercentagePage";
		
		mav.addObject("glist", new Gson().toJson(glist));
		mav.setViewName(view);
		
		return mav;
	}

	public ModelAndView goGradePercentageShowPage(GradePercentage gp) {
		mav=new ModelAndView();
		String view=null;
		
		gp.setCl_clname(gp.getCl_clname().replaceAll(",", " "));
		gp.setCo_name(gp.getCo_name().replaceAll(",", " "));
		System.out.println(gp.getCl_clname());
		System.out.println(gp.getCo_name());
		System.out.println(gp.getCo_num());
		System.out.println(gp.getCl_idnum());
		
		List<GradePercentage> glist= gDao.goGradePercentageShowPage(gp);
		
		view="teacher/gradeMM/goGradePercentageShowPage";
		mav.setViewName(view);
		mav.addObject("glist", new Gson().toJson(glist));
		mav.addObject("clname", gp.getCl_clname());
		
		
		return mav;
	}

	public HashMap<String, Object> selectGradePercentage(GradePercentage gp) {
		SecurityContext context = SecurityContextHolder.getContext();
		User user = (User) context.getAuthentication().getPrincipal();
		System.out.println(user.getUsername());
		String id= user.getUsername();
		gp.setCl_id(id);
		
		System.out.println(gp.getCl_id());//
		System.out.println(gp.getCl_clname());//cl_clname
		System.out.println(gp.getCo_num());//co_num
		System.out.println(gp.getCo_name());//co_name
		System.out.println(gp.getGr_id1());//
		System.out.println(gp.getCl_idnum());//cl_idnum
		
	 	Integer testPbMaxNum=gDao.testPbMaxNum(gp);//시험 교수 총문제 
	 	Integer teststudPbNum=gDao.teststudPbNum(gp);//시험 학생 맞춘 총문제 
	 	Integer quizPbMaxNum=gDao.quizPbMaxNum(gp);//퀴즈 교수 총문제
	 	Integer quizStudPbNum=gDao.quizStudPbNum(gp);//퀴즈 학생 맞춘 총문제
	 	Integer homeworkMaxNum=gDao.homeworkMaxNum(gp);//과제 교수 
	 	Integer homeworkStudNum=gDao.homeworkStudNum(gp);//과제 학생
	 	Integer classMaxRoundNum=gDao.classMaxRoundNum(gp);//강의 총회차
		Integer studAttendanceNum=gDao.studAttendanceNum(gp);//학생 출결
		List<GradePercentage> glist= gDao.selectRateclass(gp);
		
		
		System.out.println("시험 교수 총문제                :"+testPbMaxNum);
		System.out.println("시험 학생 맞춘 총문제          :"+teststudPbNum);
		System.out.println("퀴즈 교수 총문제                :"+quizPbMaxNum);
		System.out.println("퀴즈 학생 맞춘 총문제          :"+quizStudPbNum);
		System.out.println("과제 교수                         :"+homeworkMaxNum);
		System.out.println("과제 학생                         :"+homeworkStudNum);
		System.out.println("강의 총회차                       :"+classMaxRoundNum);
		System.out.println("학생 출결                         :"+studAttendanceNum);
		System.out.println(glist.get(0).rc_at); 
		System.out.println(glist.get(0).rc_hw); 
		System.out.println(glist.get(0).rc_qz); 
		System.out.println(glist.get(0).rc_test); 
		
		HashMap<String, Object> map= new HashMap<>();
		
		map.put("studId", gp.getGr_id1());
		map.put("testPbMaxNum", testPbMaxNum);
		map.put("teststudPbNum", teststudPbNum);
		map.put("quizPbMaxNum", quizPbMaxNum);
		map.put("quizStudPbNum", quizStudPbNum);
		map.put("homeworkMaxNum", homeworkMaxNum);
		map.put("homeworkStudNum", homeworkStudNum);
		map.put("classMaxRoundNum", classMaxRoundNum);
		map.put("studAttendanceNum", studAttendanceNum);
		map.put("rc_at", glist.get(0).rc_at);
		map.put("rc_hw", glist.get(0).rc_hw);
		map.put("rc_qz", glist.get(0).rc_qz);
		map.put("rc_test", glist.get(0).rc_test);
		
		System.out.println(map);
		return map;
	}
}
