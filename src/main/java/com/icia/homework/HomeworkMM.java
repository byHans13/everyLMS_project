package com.icia.homework;

 


import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.Gson;
import com.icia.basic.userClass.FileManager;
import com.icia.classManager.ClassManagerController;
import com.icia.classup.ClassUpBean;
import com.icia.course.CourseFilesBean;

@Component
public class HomeworkMM {
	@Autowired
	private IHomeworkDao hd;
	@Autowired
	private FileManager fm;

	
	
	@Transactional
	public ModelAndView insertHomework(HttpSession session, MultipartHttpServletRequest multi, RedirectAttributes attr) {
		ModelAndView mav = new ModelAndView();
		HomeworkBean hb = new HomeworkBean(); 
		hb.setHw_id(session.getAttribute("id").toString());
		hb.setHw_date(multi.getParameter("hw_date"));
		hb.setHw_hwname(multi.getParameter("hw_hwname"));
		hb.setHw_idnum(multi.getParameter("hw_idnum"));
		hb.setHw_lv(Integer.parseInt(multi.getParameter("hw_lv")));
		hb.setHw_num(Integer.parseInt(multi.getParameter("hw_num")));
		hb.setHw_psfa("0");
		boolean homeresult = hd.insertHomework(hb);
		System.out.println("homeresult:   "+homeresult);
		if(homeresult) {
			CourseFilesBean cfb =new CourseFilesBean();
			cfb.setFl_num(Integer.parseInt(multi.getParameter("hw_num")));
			cfb.setFl_subvd("homework");
			cfb.setFl_id(session.getAttribute("id").toString());
			cfb.setFl_idnum(multi.getParameter("hw_idnum"));
			cfb.setFl_lv(Integer.parseInt(multi.getParameter("hw_lv")));
			boolean fiResult = fm.fileUp(multi, cfb);
			System.out.println("fiResult:   "+fiResult);
			if(fiResult) {
				try {
					session.removeAttribute("courseList");
					String encodedParam = URLEncoder.encode(hb.getHw_idnum(), "UTF-8");
					mav.setViewName("redirect:/prof/selectmanagercoursehomeworkpage/"+encodedParam);
				} catch (UnsupportedEncodingException e) {
					e.printStackTrace();
				}
			}
		}else {
			System.out.println("inserthomework ERROR");
		}
		
		
		return mav;
	}
	
	
	public List<HomeworkBean> selectHomeworkList(Integer num, Integer lv, String hw_idnum) {
		String hw_num = num.toString();
		String hw_lv = lv.toString();
		List<HomeworkBean>homeworkList = hd.selectHomeworkList(hw_num,hw_lv,hw_idnum);
		return homeworkList;
	}
	
	
	public void homeworkFiledown(String sysFileName, HttpServletResponse response) {
		System.out.println("sysFileName:  "+sysFileName);
		String fullPath="";
		FileManager fm = new FileManager();
		try {
			fm.download(fullPath, sysFileName, response);
			System.out.println("다운로드 완료");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}


	public String selectProId(String cl_idnum) {
		String proId = hd.selectProId(cl_idnum);
		return proId;
	}


	public List<String> selectStHWList(String hw_id, String hw_lv, String hw_idnum, String hw_num) {
		List<String> selectStHWList = hd.selectStHWList(hw_id,hw_lv,hw_idnum,hw_num);
		return selectStHWList;
	}


	public ModelAndView selectHwResult(HomeworkBean hwb) {
		ModelAndView mav = new ModelAndView();
		System.out.println(hwb);
		System.out.println(hwb.getHw_id());
		String hw_id = hwb.getHw_id();
		String hw_num = hwb.getHw_num().toString();
		String hw_lv = hwb.getHw_lv().toString();
		String hw_idnum = hwb.getHw_idnum();
		List<HomeworkBean> hwResultList = hd.selectHwResult(hw_id,hw_num,hw_lv,hw_idnum);
		System.out.println("size:    "+hwResultList.size());
		if(hwResultList.size()!=0) {
			
			System.out.println(hwResultList.toString());
			mav.addObject("hwResultList",new Gson().toJson(hwResultList));
			mav.setViewName("teacher/gahee/selectHwResultPage");
		}else {
			mav.addObject("msg","false");
			mav.setViewName("teacher/gahee/goTeacherLoginFrm");
		}
		
		return mav;
	}


	public boolean updateStHw(String hw_idnum, String hw_num, String hw_id, String hw_psfa, String hw_lv) {
		Integer result1 = hd.updateStHw(hw_id, hw_idnum, hw_num, hw_psfa);
		boolean result=false;
		if(result1 !=0 ) {
			HomeworkBean hb = new HomeworkBean();
			hb.setGr_id(hw_id);
			hb.setGr_idnum(hw_idnum);
			hb.setGr_num(Integer.parseInt(hw_num));
			hb.setGr_lv(Integer.parseInt(hw_lv));
			if(hw_psfa.equals("p")) {
				hb.setGr_score(100);
			}
			 result = hd.insertGr(hb);
			 
		}
		return result;
	}




	
	




}
