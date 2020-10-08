package com.icia.Recommendedlecture;

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
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.Gson;
import com.icia.email.Email;
import com.icia.student.Clasc;


@RestController
@RequestMapping(value = "/stud/rest")
public class RecommendrestController {
	@Autowired
	RecommendMM mm;
	
	ModelAndView mav;
	
	@PostMapping(value = "/selectMyLevelMatch", produces = "application/json;charset=utf-8") //레벨에 맞는 추천강의 셀렉트박스 체인지 펑션
	public List<Clasc> selectMyLevelMatch(@RequestBody JSONObject MyLevel) {
		System.out.println(MyLevel);
	List<Clasc> cList = mm.selectMyLevelMatch(MyLevel.get("lv_lv").toString()); 
	return cList;
	}
	@PostMapping(value = "/selectMyinterestAjax", produces = "application/json;charset=utf-8") //취향에 맞는 추천강의 셀렉트박스 체인지 펑션
	public List<Clasc> selectMyinterestAjax(@RequestBody JSONObject Mycc) {
		List<Clasc> cList = mm.selectMyinterestAjax(Mycc.get("cc_cc").toString()); 
		return cList;
	}

	@PostMapping(value = "/selectMylnterestLevel", produces = "application/json;charset=utf-8")  //심화학습 셀렉트박스 체인지 펑션
	public List<Clasc> selectMylnterestLevel(@RequestBody JSONObject lnterestLevel ) { 
		List<Clasc> cList = mm.selectMylnterestLevel(lnterestLevel.get("cc_cc").toString());

		return cList;
	}
	@PostMapping(value = "/selectMyDeepenlnterestAjax", produces = "application/json;charset=utf-8") //심화학습 셀렉트박스 체인지 펑션2 레벨띄우기
	public int selectMyDeepenlnterestAjax(@RequestBody JSONObject mb_id ) { 
		int cList = mm.selectMyDeepenlnterestAjax(mb_id.get("mb_id").toString());
		return cList;
	}
}
