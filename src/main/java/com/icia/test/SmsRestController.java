package com.icia.test;

import java.util.HashMap;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import net.nurigo.java_sdk.api.Message;
import net.nurigo.java_sdk.exceptions.CoolsmsException;

@RestController
public class SmsRestController {
	SmsMM sm;
	
	 @RequestMapping(value = "/stud/sendSms")
	 public String sendSMS( String to, String num) {
		String sms = sm.sendSMS(to,num);
		return sms;
		 
		
	  }

}
