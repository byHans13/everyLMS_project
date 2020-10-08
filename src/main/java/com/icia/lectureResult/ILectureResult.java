package com.icia.lectureResult;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.icia.lectureTestAnswer.LectureTestAnswer;

public interface ILectureResult {

	List<LectureResult> selectLectureResult(LectureResult lr);

	List<LectureResult> allSelectLectureResult(@Param("id") String id, @Param("cont") String cont,
											   @Param("box1") String box1);

	List<LectureResult> classSelectLectureResult(@Param("id") String id, @Param("cont") String cont,
												 @Param("box1") String box1);

	List<LectureResult> courseSelectLectureResult(@Param("id") String id, @Param("cont") String cont,
												  @Param("box1") String box1);

	List<LectureResult> goLectureResultShowPage(LectureResult lr);

	List<LectureResult> selectLectureResultUpdate(LectureResult lr);

	List<LectureResult> selectDetailProblem(LectureResult lr);

	boolean LectureResultUpdate(LectureResult lr);

	boolean gradeUpdate(LectureResult lr);

	List<LectureResult> selectQuizLectureResult(LectureResult lr);

	List<LectureResult> goQuizLectureResultShowPage(LectureResult lr);

}

