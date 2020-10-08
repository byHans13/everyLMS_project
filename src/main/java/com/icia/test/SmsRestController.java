package com.icia.test;

import java.util.HashMap;

import org.json.simple.JSONObject;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import net.nurigo.java_sdk.api.Message;
import net.nurigo.java_sdk.exceptions.CoolsmsException;

@RestController
public class SmsRestController {
	
	 @RequestMapping(value = "/stud/sendSms")
	 public String sendSMS( String to, String num) {
		 String sms  = "0";
	
	  String api_key = "NCSPFQ3VWKHQGBGX";
	    String api_secret = "BLGXD1UUCBMHXY4W1SP3VEKG0EIAC2ZZ";
	    Message coolsms = new Message(api_key, api_secret);

	    HashMap<String, String> params = new HashMap<String, String>();
	    params.put("to", to); // 수신번호
	    params.put("from", "01090796216"); // 발신번호
	    params.put("type", "SMS"); // Message type ( SMS, LMS, MMS, ATA )
	    params.put("text", "안녕하세요 H2K5every입니다. 인증번호는 [" + num + "] 입니다."); // 문자내용    
	    params.put("app_version", "JAVA SDK v1.2"); // application name and version
	    
	    try {
	      JSONObject obj = (JSONObject) coolsms.send(params);
	      sms = "1";
	      System.out.println(obj.toString());
	    } catch (CoolsmsException e) {
	      System.out.println(e.getMessage());
	      System.out.println(e.getCode());
	    }
		return sms;
	  }

}
