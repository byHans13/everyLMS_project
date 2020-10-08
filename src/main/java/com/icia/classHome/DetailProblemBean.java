package com.icia.classHome;

import org.apache.ibatis.type.Alias;

import lombok.Data;
@Alias("DetailProblem")
@Data
public class DetailProblemBean {
	private int dp_num;
	private int dp_lv;
	private String dp_id;
	private String dp_idnum;
	private int dp_pbnum;
	private String dp_pbexm;
	private String dp_pbexmnum;
}