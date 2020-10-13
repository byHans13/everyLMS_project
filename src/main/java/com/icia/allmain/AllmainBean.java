package com.icia.allmain;

import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.type.Alias;

import com.icia.member.Member;

import lombok.Data;
import lombok.experimental.Accessors;

@Alias("allmain")
@Data
@Accessors(chain = true)
public class AllmainBean {
	
	private String cc_id;
	private ArrayList<String> cc_cc;
	private String cc_check;
	
	
	private String cl_idnum;
	private int cl_lv;
	private String cl_clname;
	private String cl_id;
	private Date cl_fnday;
	private Date cl_stday;
	private int cl_pt;
	private int cl_lcnum;
	private String cl_cc;
	private int cl_ct;
	
	
	private String pi_idnum;
	private int pi_lv;
	private String pi_pisysname;
	private String pi_pioriname;
	
	private String pc_idnum;
	private int pc_lv;
	private String pc_title;
	private String pc_cont;

}
