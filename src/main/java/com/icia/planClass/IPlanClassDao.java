package com.icia.planClass;

import org.apache.ibatis.annotations.Param;

import com.icia.classup.ClassUpBean;

public interface IPlanClassDao {
	
	
	boolean insertplanclass(ClassUpBean cb);

	boolean updateplanclass(ClassUpBean cub);



}
