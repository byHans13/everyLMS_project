package com.icia.allmain;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class AllMainController {
	
	@Autowired
	AllMainService amMM;
	
	
	/*
	 * @RequestMapping(value = "/", method = RequestMethod.GET) public String home()
	 * { logger.info("메인창으로 이동"); return "h2k5every"; }
	 */
}
