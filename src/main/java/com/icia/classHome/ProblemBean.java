package com.icia.classHome;

import java.sql.Date;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Alias("problem")
@Data
public class ProblemBean {
	
	private int pb_num;
	private int pb_lv;
	private String pb_id;
	private String pb_idnum;
	private int pb_pbnum;
	private String pb_pbname;
	private String pb_pbanswer;
	private String pb_pbexplain;
	private String pb_pbstudent;
	private int pb_answerchk;
	private Date pb_pbdate;
	private int pb_pbchkqz;
	//detailProblem view
	private String dp_pbexmnum;
	private String dp_pbexm;
	private String cl_cc;
	private Integer count;
}