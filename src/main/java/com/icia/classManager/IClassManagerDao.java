package com.icia.classManager;

import java.util.List;

import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.icia.course.CourseBean;
import com.icia.classup.ClassUpBean;

public interface IClassManagerDao {

	
	@Select("SELECT * FROM CLPC WHERE CL_ID=#{id} AND CL_CT='2'")
	List<ClassUpBean> selectClass(String id);

	List<CourseBean> selectCourse(String co_idnum);



}
