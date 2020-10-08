package com.icia.isTestTaker;

import java.util.List;

import org.apache.ibatis.annotations.Param;

public interface IisTestTaker {

	List<isTestTaker> selectIsTestTaker(String id);

	List<isTestTaker> allSelectIsTestTaker(@Param("id") String id, @Param("cont") String cont);

	List<isTestTaker> classSelectLectureTestAnswer(@Param("id") String id, @Param("cont") String cont);

	List<isTestTaker> courseSelectIsTestTaker(@Param("id") String id, @Param("cont") String cont);

	List<isTestTaker> isTestTakerSelect(isTestTaker it);

	List<isTestTaker> selectnumlist(isTestTaker it);

}
