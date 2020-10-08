package com.icia.lectureResult;

import org.apache.ibatis.type.Alias;

import lombok.Data;
import lombok.experimental.Accessors;

@Alias("lectureresult")
@Data
@Accessors(chain = true)
public class LectureResult {
	String cl_idnum;
	String cl_clname;
	String co_name;
	Integer cl_lcnum;
	Integer co_lv;
	Integer gr_id;
	String gr_id1;
	String cl_id;
	String gr_kind;
	Integer co_num;

	Integer ranking;
	String gr_idnum;
	Integer gr_num;
	Integer gr_score; 
	
	String pb_idnum;
	Integer pb_pbnum;
	String pb_pbname;
	String pb_pbexplain;
	String pb_pbstudent;
	Integer pb_answerchk;
	String pb_id;
	Integer pb_pbchkqz;
	Integer pb_lv;
	Integer pb_num;
	
	Integer dp_pbnum;
	String dp_pbexm;
	Integer dp_pbexmnum;
}
