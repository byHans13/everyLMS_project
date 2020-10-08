package com.icia.classManager;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MoveClassManagerController {
	
	@RequestMapping("/prof/goselectmanagercoursehomeworkpage")
	public String goselectmanagercoursehomeworkpage() {
		
	return "teacher/gahee/selectManagerCourseHomeworkPage";
	}
	

}
