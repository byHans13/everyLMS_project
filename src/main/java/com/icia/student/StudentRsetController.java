package com.icia.student;

import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.request;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.Gson;
import com.icia.email.Email;


@RestController
@RequestMapping(value = "/stud/rest")
public class StudentRsetController {
	@Autowired
	StudentMM mm;
	
	ModelAndView mav;
	//구글 라이브러리쓰는 에이작스
	@PostMapping(value = "/selectClassListAjax", produces = "application/json;charset=utf-8") //강의진도 확인 에이작스
	public List<Clasc> selectClassListAjax(@RequestBody JSONObject cl_clname, HttpSession session) { //json으로 변환된거 모두받고 강
	List<Clasc> cList = mm.selectClassListAjax(cl_clname.get("cl_clName").toString(),session); //cl_clname 골라서 가져서 mvc패턴 쭉 넘어감
	return cList;
	}
	@PostMapping(value = "/clickmymemo", produces = "application/json;charset=utf-8") // 2번째 셀렉박스에 값넣어주는 에이작스
	public List<Clasc> clickmymemo(@RequestBody JSONObject Cl_idnum, HttpSession session) {
		List<Clasc> cList = mm.clickmymemo(Cl_idnum.get("cl_idnum").toString(),session);
		return cList;
	}
	@PostMapping(value = "/memolist", produces = "application/json;charset=utf-8") //강좌 목록 가져오는 에이작스
	public List<Clasc> memolist(@RequestBody JSONObject memo ) { //여러개의 json 변환된거 가져올때
		HashMap<String, Object> memoview = new HashMap<String, Object>(); //hashmap으로 감싸서 mvc패턴으로 감
		memoview.put("cl_idnum", memo.get("cl_idnum").toString());
		memoview.put("co_name", memo.get("co_name").toString());
		memoview.put("mo_id", memo.get("mo_id").toString());
		System.out.println("memoview 보기:" + memoview);
		List<Clasc> cList = mm.Memo(memoview);
		return cList;
		
	}
	@PostMapping(value = "/updatemymemo", produces = "application/json;charset=utf-8")
	public void updatemymemo(@RequestBody JSONObject MEMO, HttpSession session) { //메모장 업데이트
		HashMap<String, Object> test = new HashMap<String, Object>();
		test.put("mo_num", MEMO.get("mo_num").toString());
		test.put("mo_contents", MEMO.get("mo_contents").toString());
		test.put("mo_id", MEMO.get("mo_id").toString());
		System.out.println(MEMO);
		System.out.println(test);
		mm.updatemymemo(test, session);
	}
	@PostMapping(value = "/cobdelete", produces = "application/json;charset=utf-8") // 게시판 삭제기능
	public int cobdelete(@RequestBody JSONObject cob_bonum, HttpSession session) {
HashMap<String , Object>cobdelete = new HashMap<String , Object>();
cobdelete.put("cob_bonum", cob_bonum.get("cob_bonum").toString());
mm.cobdelete(cobdelete, session);
		return 1;
}
	   @PostMapping(value = "/selectMyPointAjax", produces = "application/json;charset=utf-8") // 포인트
	   public String selectMyPointAjax(@RequestBody JSONObject pt_id, HttpSession session) {
	      String pt_pt = mm.selectMyPointAjax(pt_id.get("pt_id").toString(),session);
	      return pt_pt;
	   }
	   @PostMapping(value = "/replyselect", produces = "application/json;charset=utf-8") // 포인트
	   public List<Reply> replyselect(@RequestBody JSONObject cob_bonum) {
		   List<Reply> rList = mm.replyselect(cob_bonum.get("cob_bonum").toString());
		   return rList;
	   }
	   @PostMapping(value = "/replyinsert", produces = "application/json;charset=utf-8") // 포인트
	   public int replyinsert(@RequestBody JSONObject crList) {
		   HashMap<String , Object>replylist = new HashMap<String , Object>();
		   replylist.put("cr_idnum",crList.get("cr_idnum").toString());
		   replylist.put("cr_lv",crList.get("cr_lv").toString());
		   replylist.put("cr_num",crList.get("cr_num").toString());
		   replylist.put("cr_id",crList.get("cr_id").toString());
		   replylist.put("cr_bnum",crList.get("cr_bnum").toString());
		   replylist.put("cr_Reply",crList.get("cr_Reply").toString());
		   System.out.println(replylist);
		   mm.replyinsert(replylist);
		   return 1;
	   }
}
