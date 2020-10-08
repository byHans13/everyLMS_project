package com.icia.lectureQuiz;

import java.util.List;

import org.apache.ibatis.annotations.Param;

public interface ILectureQuizDao {

	List<LectureQuiz> selectLectureQuiz(String id);

	List<LectureQuiz> allSelectLectureQuiz(@Param("id") String id, @Param("cont") String cont);

	List<LectureQuiz> classSelectLectureQuiz(@Param("id") String id, @Param("cont") String cont);

	List<LectureQuiz> courseSelectLectureQuiz(@Param("id") String id, @Param("cont") String cont);

	List<LectureQuiz> LectureQuizShow(@Param("id") String id, @Param("name") String name, 
										@Param("lcnum") String lcnum);

	List<LectureQuiz> selectLectureTest(String id);

	List<LectureQuiz> allSelectLectureTest(@Param("id") String id, @Param("cont") String cont);

	List<LectureQuiz> classSelectLectureTest(@Param("id") String id, @Param("cont") String cont);

	List<LectureQuiz> courseSelectLectureTest(@Param("id") String id, @Param("cont") String contt);

	List<LectureQuiz> LectureTestShow(LectureQuiz lq);

	boolean studentCommentInsert(LectureQuiz lq);

	boolean studentCommentUpdate(LectureQuiz lq);
	
}
