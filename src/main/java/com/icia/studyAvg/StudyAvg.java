package com.icia.studyAvg;

import org.apache.ibatis.type.Alias;

import lombok.Data;
import lombok.experimental.Accessors;

@Alias("studyavg")
@Data
@Accessors(chain = true)
public class StudyAvg {
	String cl_idnum;
	String cl_clname;
	String co_name;
	Integer cl_lcnum;
	Integer co_lv;
	String gr_id1;
	int gr_id;
	int gr_score;
	String cl_id;
	int ranking;
	String gr_idnum;
	int gr_num;
	

}
