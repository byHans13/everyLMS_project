package com.icia.msg;


import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.icia.classup.ClassUpBean;

@Component
public class MsgMM {
	@Autowired 
	private IMsgDao msd;

	public boolean sendMsg(HttpSession session, String receiver, String msg) {
		String msg_id = session.getAttribute("id").toString();
		boolean result =msd.insertSendMsg(msg_id,receiver,msg);
		
		
		return result;
	}

	public boolean upDateSt(HttpSession session, String msg_id, String msg_text) {
		String receiver = session.getAttribute("id").toString();
		int up = msd.updateSt(msg_id,receiver,msg_text);
		boolean result = false;
		
		if(up!=0) {
			result = true;
		}
		
		return result;
	}

	



	




}
