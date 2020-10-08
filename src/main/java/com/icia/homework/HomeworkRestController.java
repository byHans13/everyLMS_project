package com.icia.homework;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.google.gson.Gson;
import com.icia.classup.ClassUpBean;
import com.icia.classup.ClassUpMM;

@org.springframework.web.bind.annotation.RestController
public class HomeworkRestController {
	@Autowired
	private HomeworkMM hm;
	
		@RequestMapping(value = "prof/rest/homeworkList")
		public String selecthomeworkList(@RequestParam(value="hw_num") Integer hw_num, @RequestParam(value="hw_lv") Integer hw_lv, @RequestParam(value="hw_idnum") String hw_idnum) {
			List<HomeworkBean> homeworkList = hm.selectHomeworkList(hw_num,hw_lv,hw_idnum);
			return new Gson().toJson(homeworkList);	
		
	}
		@RequestMapping(value = "prof/rest/stHWList")
		public String selectStHWList(@RequestParam(value = "hw_lv") String hw_lv, @RequestParam(value = "hw_idnum")String hw_idnum, @RequestParam(value = "hw_num")String hw_num) {
			String hw_id = hm.selectProId(hw_idnum);
			List<String> stHWList = hm.selectStHWList(hw_id,hw_lv,hw_idnum, hw_num);
			return new Gson().toJson(stHWList);

	}
		
		@RequestMapping(value = "prof/rest/updateStHw")
		public Integer updateStHw(@RequestParam(value = "idnum")String hw_idnum,@RequestParam(value = "num")String hw_num,@RequestParam(value = "id")String hw_id,@RequestParam(value = "pafa")String hw_psfa) {
			Integer result = hm.updateStHw(hw_idnum, hw_num, hw_id, hw_psfa);
			System.out.println("result:   "+result);
			return result;
			
			
			
		}

}


