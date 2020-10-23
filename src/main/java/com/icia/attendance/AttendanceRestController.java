package com.icia.attendance;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.google.gson.Gson;

@org.springframework.web.bind.annotation.RestController
public class AttendanceRestController {
	@Autowired
	private AttendanceMM atm;
	
	
	@RequestMapping(value = "/prof/rest/countAt")
	public Integer countAt(@RequestParam("atd_id")String atd_id,
			@RequestParam("atd_idnum")String atd_idnum,@RequestParam("atd_lv")String atd_lv) {
		Integer countAt = atm.countAt(atd_id ,atd_idnum, atd_lv);
		return countAt;
		
	}

	
		
		
		

}
