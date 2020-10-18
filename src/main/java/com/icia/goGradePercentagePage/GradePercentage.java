package com.icia.goGradePercentagePage;

import org.apache.ibatis.type.Alias;


import lombok.Data;
import lombok.experimental.Accessors;

@Alias("gradepercentage")
@Data
@Accessors(chain = true)
public class GradePercentage {
	String cl_idnum;
	String cl_clname;
	String co_name;
	Integer cl_lcnum;
	Integer co_lv;
	Integer co_num;
	
	String gr_id1;
	Integer gr_id;
	Integer gr_score;
	String cl_id;
	Integer ranking;
	String gr_idnum;
	Integer gr_num;
	
	Integer rc_at;
	Integer rc_hw;
	Integer rc_qz;
	Integer rc_test;
}
