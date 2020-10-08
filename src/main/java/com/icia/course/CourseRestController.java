package com.icia.course;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;

import com.google.gson.Gson;

@org.springframework.web.bind.annotation.RestController
public class CourseRestController {
	@Autowired
	private CourseMM com;
	
		@RequestMapping(value = "/prof/rest/courseList")
		public String  courseList(HttpSession session, String co_idnum) {
			List<CourseBean> courseList = com.courseList(session, co_idnum);
			return new Gson().toJson(courseList);	
		
	}

}
