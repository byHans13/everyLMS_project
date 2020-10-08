package com.icia.adminMainPage;

import java.util.List;

import org.apache.ibatis.type.Alias;

import com.icia.attendance.AttendanceBean;

import lombok.Data;
import lombok.experimental.Accessors;

@Alias("adminmain")
@Data
@Accessors(chain = true)
public class AdminMainPageBean {

	
	private String mb_id;
	private String mb_email;
	private String mb_phone;
	private String mb_loe;
	private String mb_name;
	
	private List<String> cc_cc;
	private String ct_prof;
	private String ct_cont;
	
	private String ctf_sysname;
	
}
