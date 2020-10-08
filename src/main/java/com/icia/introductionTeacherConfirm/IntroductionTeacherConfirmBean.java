package com.icia.introductionTeacherConfirm;

import java.sql.Date;

import org.apache.ibatis.type.Alias;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;
import lombok.experimental.Accessors;

@Data
@Alias("intrTeaConf")
@Accessors(chain = true)
public class IntroductionTeacherConfirmBean {
	private String ct_prof;
	private String ct_id;
	private String ct_cont;
	private Date ct_date;
	private int ct_check;
	
	private String mb_id;
	
	private String fl_sysname;
	private String co_name;
	private String cl_clname;
	private int co_num;
	private int co_lv;
	@JsonFormat(pattern = "yyyy-MM-dd")
	private Date cl_fnday; 
	@JsonFormat(pattern = "yyyy-MM-dd")
	private Date cl_stday;
	private String cl_idnum;
	private String cl_cc;
	private String co_cont;
	private int cl_pt;
	}
	
	
	
	
	

