package com.icia.classManager;

 
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.icia.course.CourseBean;
import com.icia.classup.ClassUpBean;

@Resource
@Service
@Component
public class ClassManagerMM {
	
	@Autowired 
	private IClassManagerDao cmd;

	public List<ClassUpBean> selectClass(HttpSession session) {
		String id = session.getAttribute("id").toString();
		List<ClassUpBean> manager_classList = cmd.selectClass(id);
		
		return manager_classList;
	}

	public List<CourseBean> selectCourse(String co_idnum) {
		String idnum = co_idnum;
		List<CourseBean> manager_courseList = cmd.selectCourse(idnum);
		System.out.println("LIST:   "+manager_courseList.size());
		//System.out.println("LIST:   "+manager_courseList.toString());
		return manager_courseList;
	}



}
