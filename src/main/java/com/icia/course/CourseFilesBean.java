package com.icia.course;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Alias("files")
@Data
public class CourseFilesBean {
	
	String fl_subvd;
	String fl_sysname;
	String fl_oriname;
	Integer fl_num;
	String fl_id;
	String fl_idnum;
	Integer fl_lv;

}
