package com.icia.classHome;

import java.util.HashSet;
import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.icia.classHome.ClassBean;
import com.icia.classHome.CourseBean;
import com.icia.classHome.CourseBoardBean;
import com.icia.classHome.FileBean;
import com.icia.classHome.MemoBean;
import com.icia.classHome.ProblemBean;
import com.icia.classHome.ScheduleBean;
import com.icia.homework.HomeworkBean;
import com.icia.member.Member;


public interface ClassHomeDao {
	
		
		//scheduel select, delete, insert -lv값 수정 완료  // test 못함
		@Select("SELECT * FROM aaCl WHERE aa_id = #{aa_id}")
		List<AdmiApplicationBean> selectMyCalendar(AdmiApplicationBean ab);
		List<ScheduleBean> selectSchedule(ScheduleBean sb);
		boolean insertSchedule(ScheduleBean cb);
		boolean deleteSchedule(ScheduleBean cb);
		
		//classHome 들어왔을 때 - lv값 수정, test 완료
		List<ClassBean> selectClassHome(ClassBean cb);
		@Select("SELECT * FROM co WHERE co_idnum = #{co_idnum} and co_lv=#{co_lv}")
		List<CourseBean> selectCourseList(CourseBean cb);
		@Select("SELECT ROUND(AVG(gpa_gpa),1) FROM gpa WHERE gpa_idnum = #{cl_idnum} AND gpa_lv=#{cl_lv}")
		String selectClassAvgNum(ClassBean cb);
		@Select("SELECT * FROM (SELECT * FROM cobKindAndGpa ORDER BY gpa_gpa DESC) WHERE cob_idnum=#{cl_idnum} AND cob_lv=#{cl_lv} AND ROWNUM <= 2")
		List<CourseBoardBean> selectInfoReview(ClassBean cb);
		
		//강의목록 들어갔을 때, 출석값, course 출력위해 - lv 수정, test 완료
		@Select("SELECT * FROM courseAttend WHERE co_idnum=#{co_idnum} AND co_lv=#{co_lv} AND aa_id = #{aa_id}")
		List<CourseBean> classLecture(CourseBean cob);
		
		//classLecture video 재생하기 위해 -lv 수정, test 완료
		@Select("SELECT * FROM classFileName WHERE fl_idnum=#{fl_idnum} AND fl_lv=#{fl_lv} AND fl_num=#{fl_num}")
		List<FileBean> selectLectureVideoPage(FileBean fl);
		
		//restTime insert select - lv 수정, test 완료
		@Insert("INSERT INTO rt(rt_id, rt_idnum, rt_lv, rt_num, rt_restTime, rt_duration)"
				+ " VALUES(#{rt_id}, #{rt_idnum}, #{rt_lv}, #{rt_num}, #{rt_restTime}, #{rt_duration})")
		boolean insertRestTime(RestTimeBean rt);
		@Select("SELECT COUNT(*) FROM rt WHERE rt_idnum=#{rt_idnum} AND rt_lv=#{rt_lv} AND rt_num=#{rt_num} AND rt_id = #{rt_id}")
		int selectRestTimeCount(RestTimeBean rt); // lv 수정함
		@Select("SELECT rt_restTime, rt_duration FROM restTime WHERE rt_id=#{fl_id} AND rt_idnum=#{fl_idnum} AND rt_lv=#{fl_lv} AND rt_num=#{fl_num}")
		public RestTimeBean selectRestTime(FileBean fl);// lv수정함
		@Update("UPDATE rt SET rt_restTime=#{rt_restTime} WHERE rt_idnum=#{rt_idnum} AND rt_lv=#{rt_lv} AND rt_num=#{rt_num} AND rt_id=#{rt_id}")
		public boolean updateRestTime(RestTimeBean rt);//lv 수정함
		
		//classLecture memo insert, update, select - lv수정, test 완료
		@Select("SELECT count(*) FROM memo WHERE mo_idnum=#{mo_idnum} AND mo_lv=#{mo_lv} AND mo_num=#{mo_num} AND mo_id=#{mo_id}")
		public int selectMemoCnt(MemoBean mb); // lv 수정
		@Insert("INSERT INTO memo(mo_idnum, mo_lv, mo_num, mo_id, mo_contents)"
				+ " values(#{mo_idnum},#{mo_lv},#{mo_num},#{mo_id},#{mo_contents})")
		boolean insertMemo(MemoBean mb);
		@Select("SELECT * FROM memo WHERE mo_idnum=#{mo_idnum} AND mo_lv=#{mo_lv} AND mo_num=#{mo_num} AND mo_id=#{mo_id}")
		List<MemoBean> selectMemo(MemoBean mb); // lv수정
		@Update("UPDATE memo SET mo_contents = #{mo_contents} where mo_idnum=#{mo_idnum} AND mo_lv=#{mo_lv} AND mo_num=#{mo_num} AND mo_id = #{mo_id}")
		boolean updateMemo(MemoBean mb);// - lv 수정
		
		//CourseQuiz 강의평가 항목, kind 가져가기 - lv 수정, test 완료
		@Select("SELECT * FROM ef WHERE ef_idnum=#{ef_idnum} AND ef_lv=#{ef_lv} AND ef_num=#{ef_num} AND ef_item=#{ef_item}")
		List<EvaluationBean> selectCourseQuiz(EvaluationBean eb); // lv 수정
		@Select("SELECT * FROM ak")
		List<EvaluationBean> selectAnswerKind();
		@Select("SELECT COUNT(*) FROM ea WHERE ea_idnum = #{ef_idnum} AND ea_lv=#{ef_lv} AND ea_num = #{ef_num} AND ea_id = #{ea_id}")
		int selectEvaluationCntChk(EvaluationBean eBean);// lv 수정
		@Select("SELECT ef_item FROM ef WHERE ef_idnum=#{ef_idnum} AND ef_lv=#{ef_lv} AND ef_num=#{ef_num}")
		HashSet<String> selectEfItemForEvaluation(EvaluationBean ef);// lv 수정
		@Insert("INSERT INTO ea(ea_num, ea_idnum, ea_item, ea_question, ea_lv, ea_id, ea_score)"
				+ "VALUES(#{ef_num}, #{ef_idnum}, #{ef_item}, #{ef_question}, #{ef_lv}, #{ea_id}, #{ak_score})")
		boolean insertCourseEvaluation(EvaluationBean evaluationBean);
		@Insert("Insert INTO gpa(gpa_num, gpa_idnum, gpa_lv, gpa_id, gpa_gpa) "
				+ "VALUES(#{ef_num},#{ef_idnum},#{ef_lv},#{ea_id},#{ak_score})")
		boolean insertCourseGpa(EvaluationBean evaluationBean);
		@Select("SELECT COUNT(*) FROM problem WHERE pb_idnum=#{ef_idnum} AND pb_lv=#{ef_lv} AND pb_num=#{ef_num} AND pb_id=#{ea_id}")
		int selectCourseQuizCnt(EvaluationBean evaluationBean);// lv 수정
		
		//courseQuiz select insert update - lv 수정, test 완료
		@Select("SELECT pb_pbnum FROM pb WHERE pb_idnum = #{pb_idnum} AND pb_lv=#{pb_lv} AND pb_num = #{pb_num} AND pb_id = #{pb_id}")
		List<ProblemBean> selectCoursePbnum(ProblemBean pb);// lv modi
		@Select("SELECT COUNT(*) FROM problem WHERE pb_idnum=#{pb_idnum} AND pb_lv=#{pb_lv} AND pb_num=#{pb_num} AND pb_id=#{pb_id} AND pb_pbnum = #{pb_pbnum}")
		int selectCoQuizCntForchk(ProblemBean pb);// lv modi 
		@Select("SELECT * FROM problemView WHERE pb_idnum=#{pb_idnum} AND pb_lv=#{pb_lv} AND pb_num=#{pb_num} AND pb_id=#{pb_id} AND pb_pbnum=#{pb_pbnum}")
		List<ProblemBean> selectCoQuizThroughId(ProblemBean pb);// lv modi
		@Select("SELECT COUNT(*) FROM problem WHERE pb_idnum=#{pb_idnum} AND pb_lv=#{pb_lv} AND pb_num=#{pb_num} AND pb_id=#{pb_id} AND pb_pbnum=#{pb_pbnum}")
		int selectCourseQuizForInsertChk(ProblemBean pb);// lv modi 
		@Update("UPDATE problem SET pb_pbstudent=#{pb_pbstudent} WHERE pb_idnum=#{pb_idnum} AND pb_lv=#{pb_lv} AND pb_num=#{pb_num} AND pb_pbnum=#{pb_pbnum} AND pb_id=#{pb_id}")
		boolean updateCourseQuiz(ProblemBean pb); // lv modi
		@Insert("INSERT INTO problem VALUES(#{pb_num}, #{pb_lv}, #{pb_id}, #{pb_idnum}, #{pb_pbnum}, #{pb_pbname}, #{pb_pbanswer},"
				+ " #{pb_pbexplain}, #{pb_pbstudent}, #{pb_answerchk}, default , #{pb_pbchkqz} )")
		boolean insertCourseQuiz(ProblemBean pb);
		@Select("SELECT * FROM problem WHERE pb_idnum=#{pb_idnum} AND pb_lv=#{pb_lv} AND pb_num=#{pb_num} AND pb_pbnum=#{pb_pbnum} AND pb_id=#{pb_id}")
		ProblemBean selectPbdata(ProblemBean pb);// lv modi
		@Select("SELECT COUNT(pb_pbnum) FROM pb WHERE pb_idnum=#{pb_idnum} AND pb_lv=#{pb_lv} AND pb_num=#{pb_num} AND pb_id=#{pb_id}")
		int selectcqCnt(ProblemBean pb);// lv modi 
		@Select("SELECT pb_pbnum FROM pb WHERE pb_idnum=#{pb_idnum} AND pb_lv=#{pb_lv} AND pb_num=#{pb_num} AND pb_id=#{pb_id}")
		List<ProblemBean> selectCourseQuizPbnum(ProblemBean pb);// lv modi
		boolean insertLastQuiz(ProblemBean pb); // insert modi
		@Select("SELECT COUNT(*) FROM pb WHERE pb_idnum=#{pb_idnum} AND pb_lv=#{pb_lv} AND pb_num=#{pb_num} AND pb_id=#{pb_id}")
		int selectLastQuizCnt(ProblemBean pb);// lv modi
		@Insert("INSERT INTO atd(atd_atmk, atd_num, atd_id, atd_idnum, atd_lv) "
				+ "VALUES(1, #{pb_num}, #{pb_id}, #{pb_idnum}, #{pb_lv})")
		boolean insertCourseAtmk(ProblemBean pb);
		@Insert("INSERT INTO atd(atd_atmk, atd_num, atd_id, atd_idnum, atd_lv) "
				+ "VALUES(1, #{pb_num}, #{pb_id}, #{pb_idnum}, #{pb_lv})")
		boolean insertOrientationAtmk(ProblemBean pb);

		//previewQuiz 게시글 랜덤으로 출력해서 가져가기 위해 - lv 수정, test 완료
		@Select("SELECT * FROM course WHERE co_idnum = #{cl_idnum} AND co_lv=#{cl_lv} AND not co_num=0")
		List<CourseBean> selectCourseNum(ClassBean cl);// lv modi
		@Select("SELECT * FROM problem WHERE pb_idnum=#{pb_idnum} AND pb_lv=#{pb_lv} AND pb_num = #{pb_num} AND pb_id=#{pb_id}")
		List<ProblemBean> selectProblemNum(ProblemBean pb);// lv modi 
		@Select("SELECT * FROM problemView WHERE pb_idnum = #{pb_idnum} AND pb_lv=#{pb_lv} AND pb_num = #{pb_num} AND pb_pbnum = #{pb_pbnum}")
		List<ProblemBean> selectPreviewQuiz(ProblemBean pb);// lv modi
		
		//공지사항 게시판 들어갔을 때 게시글 출력 위해 - lv 수정, test  완료
		@Select("SELECT * FROM courseBoardKind WHERE cob_idnum=#{cob_idnum} AND cob_lv=#{cob_lv} AND cob_kind=#{cob_kind}")
		List<CourseBoardBean> selectClassNotice(CourseBoardBean cNB); //lv modi
		
		//Q&A게시판 들어갔을 때, 게시글 출력 위해 - lv 수정, test success
		@Select("SELECT * FROM courseBoardKind WHERE cob_idnum=#{cob_idnum} AND cob_lv=#{cob_lv} AND cob_kind=#{cob_kind} AND cob_id = #{cob_id}")
		List<CourseBoardBean> selectClassQNA(CourseBoardBean QNA); // lv modi
		
		//Q&A 게시글 insert 위한 - insert 수정
		boolean insertMyClassQna(CourseBoardBean QNA); 
		
		//detail page 갔을 때, 게시글, 댓글 출력 위한 - lv, test success
		@Select("SELECT COUNT(*) FROM courseReplyView WHERE cob_idnum = #{cob_idnum} AND cob_lv=#{cob_lv} AND cob_bonum = #{cob_bonum} AND cob_kind = #{cob_kind}")
		int selectDetailViewReplyCount(CourseBoardBean PK); // lv modi
		@Select("SELECT * FROM courseReplyView WHERE cob_idnum = #{cob_idnum} AND cob_lv=#{cob_lv} AND cob_kind = #{cob_kind} AND cob_bonum = #{cob_bonum} ORDER BY cr_date asc")
		List<CourseBoardBean> selectClassDetailViewReply(CourseBoardBean PK);// lv modi
		@Select("SELECT * FROM courseBoardKind WHERE cob_idnum=#{cob_idnum} AND cob_lv=#{cob_lv} AND cob_kind=#{cob_kind} AND cob_bonum=#{cob_bonum}")
		List<CourseBoardBean> selectClassDetailView(CourseBoardBean PK); // lv modi
		
		//classQnaDetail reply insert - 수정함 test success
		@Select("SELECT cob_idnum, cob_lv, cob_num, cob_bonum FROM cob WHERE cob_bonum = #{cob_bonum}")
		CourseBoardBean selectReplyNumInfo(CourseBoardBean QR);
		@Insert("INSERT INTO cr(cr_idnum, cr_lv, cr_num, cr_id, cr_bonum, cr_reply, cr_date) "
				+ "VALUES(#{cob_idnum}, #{cob_lv}, #{cob_num}, #{cob_id}, #{cob_bonum}, #{cr_reply}, default)")
		boolean insertQnaReply(CourseBoardBean qR);
		
		//classReview page 갔을 때, 강의 후기 값 출력하기 위해  -- lv modi, test success
		@Select("SELECT * FROM cobKindAndGpa WHERE cob_idnum=#{cob_idnum} AND cob_lv=#{cob_lv} AND cob_kind=#{cob_kind}")
		List<CourseBoardBean> selectClassReview(CourseBoardBean review);// lv modi

		//classReview view page 가기전 평균값 구하기  // lv modi, test success
		@Select("SELECT count(*) FROM gpa WHERE gpa_idnum=#{cob_idnum} AND gpa_lv=#{cob_lv} AND gpa_id=#{cob_id}")
		int selectGpaCount(CourseBoardBean review);// lv modi
		@Select("SELECT count(*) FROM co WHERE co_idnum=#{cob_idnum} AND co_lv=#{cob_lv}")
		int selectCourseCount(CourseBoardBean review);// lv modi 
		@Select("SELECT count(*) FROM AA WHERE aa_idnum=#{cob_idnum} AND aa_lv=#{cob_lv} AND aa_id=#{cob_id}")
		int selectClassAdmi(CourseBoardBean review); // lv modi
		@Select("SELECT ROUND(AVG(gpa_gpa),1) FROM gpa WHERE gpa_idnum=#{cob_idnum} AND gpa_lv=#{cob_lv} AND gpa_id=#{cob_id}")
		double selectMyClassAvg(CourseBoardBean review);// lv modi
		
		//classReview 작성 insert -- lv modi, test success
		@Select("SELECT COUNT(*) FROM gpa WHERE gpa_idnum=#{cob_idnum} AND gpa_lv=#{cob_lv} AND gpa_id=#{cob_id} AND gpa_num=#{cob_num}")
		int selectClassReviewCnt(CourseBoardBean review); // lv modi
		@Insert("INSERT INTO cob(cob_idnum, cob_lv, cob_num, cob_id, cob_bonum, cob_title, cob_cont, cob_date, cob_kind) "
				+ "VALUES(#{cob_idnum}, #{cob_lv}, #{cob_num},#{cob_id}, #{cob_bonum}||LPAD(CR_seq.NEXTVAL,5,0), #{cob_title}, #{cob_cont}, default, #{cob_kind})")
		boolean insertClassReviewBoard(CourseBoardBean review);
		@Insert("INSERT INTO gpa(gpa_num, gpa_idnum, gpa_lv, gpa_id, gpa_gpa)"
				+ " VALUES(#{cob_num}, #{cob_idnum}, #{cob_lv}, #{cob_id}, #{gpa_gpa})")
		boolean insertClassReviewGpa(CourseBoardBean review);
		@Select("SELECT cob_bonum FROM cobKindAndGpa WHERE cob_idnum=#{cob_idnum} AND cob_lv=#{cob_lv} AND cob_id=#{cob_id}")
		String selectClassReviewBoardNum(CourseBoardBean review); //lv modi
		
		///////////////////
		//class Like 
		@Select("SELECT likes_check FROM likes WHERE likes_idnum=#{likes_idnum} AND likes_lv=#{likes_lv} AND likes_id=#{likes_id} ")
		Integer selectClassLikeById(LikeBean lb);
		@Insert("INSERT INTO likes(likes_id, likes_idnum, likes_lv, likes_check) VALUES(#{likes_id},#{likes_idnum},#{likes_lv},#{likes_check})")
		boolean insertClassLike(LikeBean lb);
		@Update("UPDATE likes SET likes_check=#{likes_check} WHERE likes_id=#{likes_id} AND likes_idnum=#{likes_idnum} AND likes_lv=#{likes_lv}")
		boolean updateClassLike(LikeBean lb);
		
		//classManagementPage로 이동 
		@Select("SELECT * FROM likes WHERE likes_id=#{sessionId} AND likes_check=1")
		List<LikeBean> selectMyLikeList(String sessionId);
		@Select("SELECT * FROM classInfo WHERE cl_idnum=#{likes_idnum} AND cl_lv=#{likes_lv}")
		ClassBean selectMyLikeListInfo(LikeBean likeBean);
		@Select("SELECT COUNT(*) FROM atd WHERE atd_idnum=#{cl_idnum} AND atd_lv=#{cl_lv} AND atd_id=#{aa_id}")
		int selectCountMyClassAtmk(AdmiApplicationBean aaBean);
		
		//classManagementPage/buyPage select
		@Select("SELECT * FROM cl WHERE cl_idnum=#{cl_idnum} AND cl_lv=#{cl_lv}")
		ClassBean selectClassInfo(ClassBean cb);
		@Select("SELECT * FROM mb WHERE mb_id=#{sessionId}")
		Member selectMemberInfo(String sessionId);
		@Update("UPDATE mb SET mb_point=#{mb_point} WHERE mb_id=#{mb_id}")
		boolean updateMyPoint(Member mb);
		@Insert("INSERT INTO point(point_date, point_pt, point_id) VALUES(default, #{point_pt}, #{point_id})")
		boolean insertPointBreakdown(PointBean pb);
		@Insert("INSERT INTO aa(aa_idnum, aa_lv, aa_id) VALUES(#{cl_idnum}, #{cl_lv}, #{cl_id})")
		boolean insertClassAdmiApplication(ClassBean cb);
		
		//LevelCheckPage
		@Select("SELECT * FROM cc WHERE cc_id=#{sessionId} AND cc_check=1")
		List<ConcernBean> selectLevelCheckPage(String sessionId);
		@Select("SELECT pb_lv from problemCC WHERE cl_cc=#{cl_cc}")
		HashSet<Integer> selectConcernMaxLevel(ProblemBean pb);
		//mapper random list 3개 출력
		List<ProblemBean> selectLevelCheckRandomQuizInfo(ProblemBean pb);
		@Select("SELECT * FROM detailProblemCC WHERE pb_idnum=#{pb_idnum} AND pb_lv=#{pb_lv} AND pb_num=#{pb_num} AND pb_pbnum=#{pb_pbnum}")
		List<ProblemBean> selectLevelCheckQuizDetail(ProblemBean problemBean);
		@Insert("INSERT INTO grade(gr_idnum, gr_id, gr_num, gr_lv, gr_score, gr_kind) "
				+ "VALUES(#{gr_idnum}, #{gr_id}, #{gr_num}, #{gr_lv}, #{gr_score}, #{gr_kind})")
		boolean insertCourseGrade(GradeBean gb);
		@Update("UPDATE pb SET pb_answerchk=#{pb_answerchk} WHERE pb_idnum=#{pb_idnum} AND pb_lv=#{pb_lv} "
				+ "AND pb_num=#{pb_num} AND pb_pbnum=#{pb_pbnum} AND pb_id=#{pb_id}")
		boolean updateCourseQuizAnswerchk(ProblemBean pb);

		//finalTest
		@Select("SELECT * FROM problem WHERE pb_idnum=#{pb_idnum} AND pb_lv=#{pb_lv} AND pb_num=#{pb_num}")
		List<ProblemBean> selectClassFinalTest(ProblemBean pb);
		@Select("SELECT * FROM finalTest where aa_id=#{sessionId}")
		List<ClassBean> selectClassFinalTestPage(String sessionId);
		@Select("SELECT * FROM finalTestChk WHERE aa_id=#{sessionId}")
		List<GradeBean> selectClassFinalTestGrade(String sessionId);
		@Select("SELECT * FROM pb WHERE pb_idnum=#{pb_idnum} AND pb_lv=#{pb_lv} AND pb_num=#{pb_num} AND pb_id=#{pb_id}")
		List<ProblemBean> selectFinalTestPbnum(ProblemBean pb);
		@Select("SELECT pb_pbnum FROM pb WHERE pb_idnum=#{pb_idnum} AND pb_lv=#{pb_lv} AND pb_num=#{pb_num} AND pb_id=#{pb_id}")
		List<ProblemBean> selectClassFinalTestLength(ProblemBean pb);
		@Select("SELECT * FROM pb WHERE pb_idnum=#{pb_idnum} AND pb_lv=#{pb_lv} AND pb_num=#{pb_num} AND pb_pbnum=#{pb_pbnum} AND pb_id=#{pb_id}")
		ProblemBean selectClassFinalTestPbInfo(ProblemBean pb);
		@Select("SELECT COUNT(*) FROM pb WHERE pb_idnum=#{pb_idnum} AND pb_lv=#{pb_lv} AND pb_num=#{pb_num} AND pb_pbnum=#{pb_pbnum} AND pb_id=#{pb_id}")
		int selectClassFinalTestInsertChk(ProblemBean pb);
		@Update("UPDATE pb SET pb_pbstudent=#{pb_pbstudent}, pb_answerchk=#{pb_answerchk} WHERE"
				+ " pb_idnum=#{pb_idnum} AND pb_lv=#{pb_lv} AND pb_num=#{pb_num} AND pb_pbnum=#{pb_pbnum} AND pb_id=#{pb_id}")
		boolean updateClassFinalTest(ProblemBean pb);
		@Insert("INSERT INTO pb(pb_num, pb_lv, pb_id, pb_idnum, pb_pbnum, pb_pbname, pb_pbanswer, pb_pbexplain, pb_pbstudent, pb_answerchk, pb_pbdate, pb_pbchkqz"
				+ "VALUES(#{pb_num}, #{pb_lv}, #{pb_id},#{pb_idnum},#{pb_pbnum},#{pb_pbname},#{pb_pbanswer},#{pb_pbexplain},#{pb_pbstudent},#{pb_answerchk},default,#{pb_pbchkqz})")
		boolean insertClassFinalTestForceStop();

		//ClassHome - Homework
		List<HomeworkBean> selectClassHomeworkList(HomeworkBean hw);
		@Insert("INSERT INTO hw(hw_hwname, hw_id, hw_num, hw_idnum, hw_lv, hw_date, hw_psfa) VALUES"
				+ "(#{hw_hwname}, #{hw_id}, #{hw_num}, #{hw_idnum}, #{hw_lv}, sysdate, #{hw_psfa})")
		boolean insertHwHomework(HomeworkBean hw);
		@Insert("INSERT INTO fl(fl_subvd, fl_sysname, fl_oriname, fl_num, fl_id, fl_idnum, fl_lv) VALUES"
				+ "(#{fl_subvd}, #{fl_sysname}, #{fl_oriname}, #{fl_num}, #{fl_id}, #{fl_idnum}, #{fl_lv})")
		boolean insertFlHomework(FileBean fl);





		


		

}
