package com.icia.studyAvg;

import java.util.List;

import org.apache.ibatis.annotations.Param;

public interface IStudyAvgDao {

	List<StudyAvg> selectStudyAvg(String id);

	List<StudyAvg> allSelectStudyAvg(@Param("id") String id, @Param("cont") String cont);

	List<StudyAvg> classSelectStudyAvg(@Param("id") String id, @Param("cont") String cont);

	List<StudyAvg> courseSelectStudyAvg(@Param("id") String id, @Param("cont") String cont);

	List<StudyAvg> selectStudyAvgShow(StudyAvg sa);

}
