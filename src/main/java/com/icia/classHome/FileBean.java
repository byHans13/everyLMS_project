package com.icia.classHome;

import org.apache.ibatis.type.Alias;
import lombok.Data;

@Alias("file")
@Data
public class FileBean {

	private String fl_subvd; // 강의 동영상 과제 
	private String fl_sysname; 
	private String fl_oriname;
	private Integer fl_num;
	private String fl_id;
	private String fl_idnum;
	private Integer fl_lv;
	
	//view 
	private String cl_clname;
	private String co_name;
}
