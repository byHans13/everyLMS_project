package com.icia.classHome;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("grades")
public class GradeBean {
	private String gr_idnum; 
	private String gr_id;
	private int gr_num;
	private int gr_lv;
	private double gr_score;
	private String gr_kind;
}
