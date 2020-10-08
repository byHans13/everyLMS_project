package com.icia.classHome;


import org.apache.ibatis.type.Alias;

import lombok.Data;
@Alias("courseBoard")
@Data
public class CourseBoardBean {
	
	private String cob_idnum;
	private int cob_lv;
	private int cob_num;
	private String cob_id;
	private String cob_bonum;
	private String cob_title;
	private String cob_cont;
	private String cob_date;
	private int cob_kind;
	//view
	private String bk_boardName;
	private String cr_id;
	private String cr_reply;
	private String cr_date;
	private double gpa_gpa;
}
