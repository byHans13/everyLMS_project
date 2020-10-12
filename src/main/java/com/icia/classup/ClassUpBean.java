package com.icia.classup;


import lombok.Data;
import lombok.experimental.Accessors;



@Data
@Accessors(chain = true)
public class ClassUpBean {
	
	
	//강의
	String cl_idnum;
	int cl_lv;
	String cl_clname;
	String cl_id;
	String cl_stday;
	String cl_fnday;
	int cl_pt;
	int cl_lcnum;
	String cl_cc;
	String cl_ct;
	
	
	//강의계획서
	String pc_idnum;
	Integer pc_lv;
	String pc_title;
	String pc_cont;
	
	//섬네일
	String pi_idnum;
	Integer pi_lv; 
	String pi_pisysname;
	String pi_pioriname;
	
	
	
	//강의백분율
	String rc_idnum;
    Integer rc_lv;
    Integer rc_at;
    Integer rc_hw;
    Integer rc_qz;
    Integer rc_test;


	
	
}
