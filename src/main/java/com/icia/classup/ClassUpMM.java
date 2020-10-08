package com.icia.classup;

 
import java.util.Calendar;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.Gson;
import com.icia.basic.userClass.FileManager;
import com.icia.course.CourseBean;
import com.icia.course.CourseFilesBean;

@Component
public class ClassUpMM {
	@Autowired 
	private IClassUpDao cd;
	@Autowired
	FileManager fm;

	public ModelAndView insertclassupload(MultipartHttpServletRequest multi, RedirectAttributes attr, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		ClassUpBean cb = new ClassUpBean();
		cb.setCl_id(session.getAttribute("id").toString());
		//cl_clname, fileName, cl_stday, cl_fnday, cl_pt, cl_lcnum, cl_lv, cl_cc
		cb.setCl_clname(multi.getParameter("cl_clname"));
		cb.setCl_stday(multi.getParameter("cl_stday"));
		cb.setCl_fnday(multi.getParameter("cl_fnday"));
		cb.setCl_pt(Integer.parseInt(multi.getParameter("cl_pt")));
		cb.setCl_lcnum(Integer.parseInt(multi.getParameter("cl_lcnum")));
		cb.setCl_cc(multi.getParameter("cl_cc"));
		cb.setCl_lv(Integer.parseInt(multi.getParameter("cl_lv")));
	
		String [] fnsp = cb.getCl_fnday().split("-");
		String fnSpSum ="";
		for(int i=0; i<fnsp.length; i++) {
			fnSpSum += fnsp[i];
		}
		cb.setCl_idnum(""+cb.getCl_id()+cb.getCl_cc()+cb.getCl_lcnum()+fnSpSum);
		System.out.println("cb.getCl_idnum():  "+ cb.getCl_idnum());
		

		//rc_idnum, rc_lv, rc_at, rc_hw, rc_qz, rc_test
		cb.setRc_idnum(cb.getCl_idnum());
		cb.setRc_lv(cb.getCl_lv());
		cb.setRc_at(Integer.parseInt(multi.getParameter("rc_at")));
		cb.setRc_hw(Integer.parseInt(multi.getParameter("rc_hw")));
		cb.setRc_qz(Integer.parseInt(multi.getParameter("rc_qz")));
		cb.setRc_test(Integer.parseInt(multi.getParameter("rc_test")));

		boolean clResult = cd.insertclassupload(cb);
		boolean rcResult = cd.insertrate(cb);
		if(clResult && rcResult) {
			System.out.println("oooooooo");
			boolean fiResult = fm.pictureInsert(multi, cb);
			if(fiResult) {
				mav.addObject("insertclassupload","성공");
				mav.addObject("cl_ct", 0);
				//attr.addFlashAttribute("goAjax","go");
				//${cl_ct}
				 mav.setViewName("teacher/gahee/classmain");
			}
			
		}else {
			System.out.println("xxxxxxxxxxxx");
			mav.addObject("insertclassupload","실패");
			mav.setViewName("teacher/gahee/classUploadPage");
		}
		return mav;
	}
	
	public List<ClassUpBean> classList(HttpSession session) {
		String id = session.getAttribute("id").toString();
		System.out.println("hamq1"+id);
		List <ClassUpBean> myClassList = cd.classList(id);
		System.out.println("LISTFILE "+myClassList.get(0).getPc_title());
		session.removeAttribute("cl_ct");
		return myClassList;
		
	}

	public int updateGoAdmin(String idnum) {
		int result = cd.updateGoAdmin(idnum);
		return result;
	}

	public String selectCt(String idnum) {
		String selectCt = cd.selectCt(idnum);
		System.out.println("CL_IDNUM=#{idnum}:   "+selectCt);
		return selectCt;
	}

	public List<ClassUpBean> getClassList(String cl_ct, HttpSession session) {
		String cl_id = session.getAttribute("id").toString();
		updateClass(session);
		List <ClassUpBean> classListVal = cd.getClassList(cl_id, cl_ct);
		return classListVal;
	}
	
	
	public void updateClass(HttpSession session) {
		String cl_id = session.getAttribute("id").toString();
		Calendar cal = Calendar.getInstance();
		int yy = cal.get(cal.YEAR);
		int mm = cal.get(cal.MONTH)+1;
		int dd = cal.get(cal.DATE);
		String year = String.format("%04d", yy);
		String month = String.format("%02d", mm);
		String date = String.format("%02d", dd);
		
		String strnow =""+year+month+date;
		int now = Integer.parseInt(strnow);
		System.out.println("now: "+now);
		
		List<ClassUpBean>fnday = cd.fnday(cl_id);
		System.out.println("fnday: "+fnday.get(0).cl_idnum);
		
		for(int i=0; i<fnday.size(); i++) {
			String fnd="";
			String[] f = fnday.get(i).cl_fnday.split(" ");
			String[] fn = f[0].split("-");
			for(int j=0; j<fn.length; j++) {
				fnd += fn[j];
			}
			int fnda = Integer.parseInt(fnd);
			
			if(fnda < now) {
				//System.out.println("鍮↔뎄= "+fnda);
				cd.updateClass(fnday.get(i).cl_idnum);
			}else {
				System.out.println("�끂�끂�끂�끂= "+fnda);
			}
		}
	}
	
	
	
	
	
	
	

}
