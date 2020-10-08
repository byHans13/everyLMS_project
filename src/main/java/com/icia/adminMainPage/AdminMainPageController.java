package com.icia.adminMainPage;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;


@Controller
public class AdminMainPageController {
	private static final Logger logger = LoggerFactory.getLogger(AdminMainPageController.class);
	
	
	@Autowired
	AdminMainPageMM ampMm;
	
	@RequestMapping(value = "/admi/selectintroductionteacherconfirm", method = RequestMethod.GET)
	public String profUpLoadPage() {
		return "/Admin/hans/selectintroductionteacherconfirm";
	}
	@RequestMapping(value = "/admi/selectlectureconfirm", method = RequestMethod.GET)
	public String classUpLoadPage() {
		return "/Admin/hans/selectLectureConfirm";
	}
	
	
	
	
}
