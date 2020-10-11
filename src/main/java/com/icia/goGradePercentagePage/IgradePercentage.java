package com.icia.goGradePercentagePage;

import java.util.List;

public interface IgradePercentage {

	List<GradePercentage> goGradePercentagePage(String id);

	List<GradePercentage> goGradePercentageShowPage(GradePercentage gp);

	Integer testPbMaxNum(GradePercentage gp);

	Integer teststudPbNum(GradePercentage gp);

	Integer quizPbMaxNum(GradePercentage gp);

	Integer quizStudPbNum(GradePercentage gp);

	Integer homeworkMaxNum(GradePercentage gp);

	Integer homeworkStudNum(GradePercentage gp);

	Integer classMaxRoundNum(GradePercentage gp);

	Integer studAttendanceNum(GradePercentage gp);

	List<GradePercentage> selectRateclass(GradePercentage gp);
	
}
