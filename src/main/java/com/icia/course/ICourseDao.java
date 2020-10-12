package com.icia.course;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.springframework.web.bind.annotation.RequestParam;

import com.icia.classup.ClassUpBean;

public interface ICourseDao {

	List<CourseBean> courseList(String co_idnum);

	List<CourseBean> myCoList(@Param("co_num") String co_num, @Param("co_idnum") String co_idnum);

	List<CourseFilesBean> myfilesList(String co_num);

	
	@Select("SELECT CL_LV FROM CL WHERE CL_IDNUM=#{idnum}")
	List<ClassUpBean> selectLv(String idnum);

	boolean insertCourse(CourseBean cb);

	boolean courseFileInsert(CourseFilesBean cfb);

	boolean deleteCourseFiles(CourseFilesBean cfb);

	boolean deleteCourse(CourseBean cb);

	
	boolean updateCourse(CourseBean cb);

	boolean updateCourseFile(CourseFilesBean cfb);

	
	@Select("SELECT * FROM FL WHERE FL_IDNUM=#{fl_idnum} AND FL_LV=#{fl_lv} AND FL_NUM=#{fl_num}")
	List<CourseFilesBean> selectDelFile(CourseFilesBean cfb);

	
	@Select("SELECT CL_LCNUM FROM CL WHERE CL_IDNUM=#{co_idnum}")
	int getlcnum(@Param("co_idnum")String co_idnum);


	
	



}
