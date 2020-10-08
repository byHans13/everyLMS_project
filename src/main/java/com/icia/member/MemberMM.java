package com.icia.member;
//회원관리 서비스 클래스

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.Gson;
import com.icia.email.Email;
import com.icia.introductionTeacherConfirm.IIntroductionTeacherConfirmDao;


@Service // @Component //IoC컨테이너 등록
public class MemberMM {
	@Autowired
	private IMemberDao mDao;
	
	@Autowired
	IIntroductionTeacherConfirmDao itcDao; 
	
	
	ModelAndView mav;

	public ModelAndView insertMemberJoin(Member mb) {
		mav = new ModelAndView();
		String view = null;
		BCryptPasswordEncoder pwdEncoder = new BCryptPasswordEncoder();
		mb.setMb_rrn(mb.getMb_rrn1() +""+ mb.getMb_rrn2());
		System.out.println(mb.getMb_rrn());
		System.out.println(mb.getMb_pw());
		mb.setMb_pw(pwdEncoder.encode(mb.getMb_pw()));
		System.out.println(mb.getMb_pw());
		
		
			if (mDao.insertMemberJoin(mb)) {
				String str = mb.getCc_cc();
				if (str.contains(",")) {
					System.out.println(",있음");
					String[] array = str.split(",");

					for (int i = 0; i < array.length; i++) {
						mb.setCc_cc(array[i]);
						mDao.insertConcern(mb);
						System.out.println(i);
						
					}mDao.insertAuthority(mb);
					
				} else {
					System.out.println(",없음");
					mDao.insertConcern(mb);
					mDao.insertAuthority(mb);
				}
				
				view = "h2k5every";
			} else {
				view = "goMainJoinPage";
			}
	
		mav.setViewName(view);
		return mav;
	}

	public ModelAndView selectAccessPage(Member mb, HttpSession session) {
		mav = new ModelAndView();
		String view = null;
		BCryptPasswordEncoder pwdEncoder = new BCryptPasswordEncoder();
		System.out.println("mb.getMb_id() = " + mb.getMb_id());
		String pwdEncode = mDao.securityPwd(mb.getMb_id());
		System.out.println("pwdEncode = " + pwdEncode);
		if (pwdEncode != null) {
			if (pwdEncoder.matches(mb.getMb_pw(), pwdEncode)) {
				session.setAttribute("id", mb.getMb_id());
				System.out.println("로그인 성공!");
				view = "goLoginFrm";
			} else {
				System.out.println("비밀 번호가 틀립니다.");
				mav.addObject("msg", 0);
				view = "goLoginPage";
			}
		} else {
			System.out.println("존재하는 아이디가 없습니다.");
			mav.addObject("msg", 0);
			view = "goLoginPage";
		}
		mav.setViewName(view);
		return mav;
	}

	public List<String> selectConcern(Member mb) {
		List<String> list = mDao.selectConcern(mb);

		return list;
	}

	public int selectIdclick(String id) {
		int cnt= mDao.selectIdclick(id);
		
		return cnt;
	}

	public ModelAndView idChecknumConfirm(Email em, RedirectAttributes attr) {
		mav = new ModelAndView();
		String view = null;
		 if (em.getE_checknum().equals(em.getE_checknum2())) {
	            System.out.println("인증번호 일치");
	            List<String> list = mDao.idChecknumConfirm(em);
	            System.out.println(list.size());
	            if(list.size()!=0) {
	            	view="goSearchIdPage";
	            	mav.setViewName(view);
	            	mav.addObject("idList", new Gson().toJson(list));
	            	return mav;
	            }else {
	            	view="goSearchIdPage";
	            	mav.setViewName(view);
	            	mav.addObject("List", "가입된 아이디가 없습니다.");
	            	return mav;
	            }
	          
	        }
	        	System.out.println("인증번호 불일치");
	        	mav.setViewName("redirect:/goSearchIdPwPage");
	        	attr.addFlashAttribute("msg","인증번호 불일치! 다시 인증해주세요.");
	        	return mav;
	    
	}

	public ModelAndView pwChecknumConfirm(Email em, RedirectAttributes attr) {
		mav = new ModelAndView();
		String view = null;
		 if (em.getE_checknum().equals(em.getE_checknum2())) {
	            System.out.println("인증번호 일치");
	            List<String> list = mDao.pwChecknumConfirm(em);
	            System.out.println(list.size());
	           
	            if(list.size()!=0) {
	            	view="goPwUpdatePage";
	 	            mav.setViewName(view);
	 	            mav.addObject("idList", new Gson().toJson(list));
	 	            return mav;
	            }else {
	            	view="goSearchIdPage";
	            	mav.setViewName(view);
	            	mav.addObject("List", "가입된 아이디가 없습니다.");
	            	return mav;
	            }
	        }
	        	System.out.println("인증번호 불일치");
	        	view="goSearchIdPwPage";
	        	mav.setViewName("redirect:/goSearchIdPwPage");
	        	attr.addFlashAttribute("msg","인증번호 불일치! 다시 인증해주세요.");
	        	return mav;
	    
	}

	public ModelAndView PwUpdate(Member mb, RedirectAttributes attr) {
		mav = new ModelAndView();
		BCryptPasswordEncoder pwdEncoder = new BCryptPasswordEncoder();
		mb.setMb_pw(pwdEncoder.encode(mb.getMb_pw()));
		
		if(mDao.PwUpdate(mb)) {
			System.out.println("비밀번호 변경 성공");
			mav.setViewName("redirect:/gologinpage");
        	attr.addFlashAttribute("msg","비밀번호 변경에 성공하였습니다.");
        	return mav;
		}
		System.out.println("비밀번호 변경 실패");
    	mav.setViewName("redirect:/goPwUpdatePage");
    	attr.addFlashAttribute("msg","비밀번호 변경에 실패하였습니다. 다시 확인해주세요.");
    	return mav;
		
	}

	public ModelAndView goLoginFrm(HttpSession session) {
		mav= new ModelAndView();
		SecurityContext context = SecurityContextHolder.getContext();
		User user = (User) context.getAuthentication().getPrincipal();
		System.out.println(user.getAuthorities());
		System.out.println(user.getUsername());
		String ct_id=user.getUsername();
		session.setAttribute("id", user.getUsername());
		mav.addObject("aut", user.getAuthorities());
		mav.addObject("profCheck", itcDao.selectProfCheck(ct_id));
		mav.setViewName("goLoginFrm");
		return mav;
	}

	public ModelAndView goTeacherLoginFrm(HttpSession session) {
		mav= new ModelAndView();
		SecurityContext context = SecurityContextHolder.getContext();
		User user = (User) context.getAuthentication().getPrincipal();
		System.out.println(user.getAuthorities());
		System.out.println(user.getUsername());
		session.setAttribute("id", user.getUsername());
		mav.addObject("aut", user.getAuthorities());
		mav.setViewName("goTeacherLoginFrm");
		
		return mav;
	}
	
	
	public ModelAndView insertMemberJoin2(Member mb, String mb_id, int spl3) {
		mav = new ModelAndView();
		String view = null;
		BCryptPasswordEncoder pwdEncoder = new BCryptPasswordEncoder();
		mb.setMb_rrn(mb.getMb_rrn1() +""+ mb.getMb_rrn2());
		System.out.println(mb.getMb_rrn());
		System.out.println(mb.getMb_pw());
		mb.setMb_pw(pwdEncoder.encode(mb.getMb_pw()));
		System.out.println(mb.getMb_pw());
		
		
			if (mDao.insertMemberJoin(mb)) {
				String str = mb.getCc_cc();
				if (str.contains(",")) {
					System.out.println(",있음");
					String[] array = str.split(",");

					for (int i = 0; i < array.length; i++) {
						mb.setCc_cc(array[i]);
						mDao.insertConcern(mb);
						System.out.println(i);
						
					}mDao.insertAuthority2(mb_id,spl3);
					
				} else {
					System.out.println(",없음");
					mDao.insertConcern(mb);
					mDao.insertAuthority2(mb_id,spl3);
				}
				
				view = "h2k5every";
			} else {
				view = "goMainJoinPage";
			}
	
		mav.setViewName(view);
		return mav;
	}

	public ModelAndView registerToProf(HttpSession session) {
		mav = new ModelAndView();
		String view = null;
		String id = session.getAttribute("id").toString();
		System.out.println("register session id= "+id);
		List<Member> mList = new ArrayList<Member>();
		mList = mDao.selectMbInfo(id);
		mav.addObject("mList", mList);
		
		view="Admin/hans/registerToProf";
		mav.setViewName(view);
		return mav;
	}

	public ModelAndView goAdminLoginFrm(HttpSession session) {
		mav = new ModelAndView();
		String view = null;
		SecurityContext context = SecurityContextHolder.getContext();
		User user = (User) context.getAuthentication().getPrincipal();
		System.out.println(user.getAuthorities());
		System.out.println(user.getUsername());
		session.setAttribute("id", user.getUsername());
		mav.addObject("aut", user.getAuthorities());
		view="h2k5every_admi";
		mav.setViewName(view);
		return mav;
	}

	public ModelAndView myInfoPage(HttpSession session) {
		mav = new ModelAndView();
		Member mb = new Member();
		mb.setMb_id(session.getAttribute("id").toString());
		List <Member> myInfo = mDao.selectMyInfo(mb.getMb_id());
		mav.addObject("myInfo", new Gson().toJson(myInfo));
		mav.setViewName("myInfoPage");
		return mav;
	}

	public String updateMyinfo(HttpSession session, String name, String loe) {
		String id = session.getAttribute("id").toString();
		int result = mDao.updateMyinfo(id,name,loe);
		if(result != 0) {
			return "ok";
		}
		return "no";
	}

	public boolean goupphone(HttpSession session, String phone) {
		String id = session.getAttribute("id").toString();
		int result = mDao.goupphone(id,phone);
		if(result != 0) {
			return true;
		}
		return false;
	}

	public boolean goupemailbtn(HttpSession session, String email) {
		String id = session.getAttribute("id").toString();
		int result = mDao.goupemailbtn(id,email);
		if(result != 0) {
			return true;
		}
		return false;
	}
	}


