package com.icia.lectureQuiz;

import org.apache.ibatis.type.Alias;

import lombok.Data;
import lombok.experimental.Accessors;

@Alias("lecturequiz")
@Data
@Accessors(chain = true)
public class LectureQuiz {
	String cl_idnum;
	String cl_clname;
	String co_name;
	Integer co_num;
	Integer cl_lcnum;
	Integer co_lv;
	String gr_id1;
	int gr_id;
	int gr_score;
	String cl_id;
	String tfb_feedback;
	String tfb_id;
	String tfb_idnum;
}
