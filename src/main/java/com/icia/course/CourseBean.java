package com.icia.course;


import java.util.List;

import org.apache.ibatis.type.Alias;

import lombok.Data;
import lombok.experimental.Accessors;


@Alias("courses")
@Data
@Accessors(chain = true)
public class CourseBean {

	String co_num;
	Integer co_lv;
	String co_name;
	String co_cont;
	String co_idnum;
	
	List<CourseFilesBean> fbList; 
	
}
