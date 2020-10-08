package com.icia.isTestTaker;

import org.apache.ibatis.type.Alias;


import lombok.Data;
import lombok.experimental.Accessors;

@Alias("istesttaker")
@Data
@Accessors(chain = true)
public class isTestTaker {
	String cl_idnum;
	String cl_clname;
	String co_name;
	Integer cl_lcnum;
	Integer co_lv;
	String cl_id;
	Integer co_num;
	
	String gr_idnum;
	Integer gr_num;
	String gr_id;
	String pb_id;
	
	
}
