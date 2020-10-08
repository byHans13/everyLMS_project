package com.icia.lectureTestAnswer;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.icia.isTestTaker.isTestTaker;

public interface ILectureTestAnswer {

	List<LectureTestAnswer> selectLectureTestAnswer(String id);

	List<isTestTaker> allSelectLectureTestAnswer(@Param("id") String id, @Param("cont") String cont);

	List<isTestTaker> classSelectLectureTestAnswer(@Param("id") String id, @Param("cont") String cont);

	List<isTestTaker> courseSelectLectureTestAnswer(@Param("id") String id, @Param("cont") String cont);

	List<LectureTestAnswer> selectlectureTestAnswerShow(LectureTestAnswer lta);

	List<LectureTestAnswer> selectDetailProblem(LectureTestAnswer lta);

	List<LectureTestAnswer> selectPercentage(LectureTestAnswer lta);

}
