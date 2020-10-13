package com.icia.lectureTestAnswer;

import org.apache.ibatis.type.Alias;


import lombok.Data;
import lombok.experimental.Accessors;

@Alias("lecturetestanswer")
@Data
@Accessors(chain = true)
public class LectureTestAnswer {
	String cl_idnum;
	String cl_clname;
	String co_name;
	Integer cl_lcnum;
	Integer co_lv;
	String cl_id;
	Integer gr_id1;
	Integer co_num;
	String gr_kind;
	
	String pb_idnum;
	Integer pb_pbnum;
	String pb_pbname;
	Integer pb_pbexplain;
	Integer	pb_answerchk;
	Integer pb_pbstudent;
	
	Integer dp_pbnum;
	String dp_pbexm;
	Integer dp_pbexmnum;
	
}
