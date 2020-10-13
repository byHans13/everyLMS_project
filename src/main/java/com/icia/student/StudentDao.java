package com.icia.student;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.icia.email.Email;

public interface StudentDao {

	@Select("SELECT DISTINCT CL_CLNAME,cl_idnum FROM sb_class WHERE aa_ID = #{mb_id}")
	List<Clasc> selectMyClassProgressPage(String id); // 강의진도확인 , 메모 , QNA , 리뷰 셀렉트박스 값추가

	// 페이징
	List<Clasc> getsearchqnaList(@Param("pageNum") int pageNum, @Param("search") String search); // QNA 게시판 검색시 페이징

	List<Clasc> searchClassQnaDetail(@Param("pageNum") int pageNum, @Param("search") String search,
			@Param("selvalue") String selvalue);// QNA 게시판 조건검색시 페이징

	List<Clasc> reviewlist(@Param("pageNum") int pageNum, @Param("search") String search); // REVIEW 검색시 페이징

	List<Clasc> searchClassReviewDetail(@Param("pageNum") int pageNum, @Param("search") String search,
			@Param("selvalue") String selvalue);// REVIEW 게시판 조건검색시 페이징
//총 게시물 카운트 

	@Select("SELECT COUNT(*) FROM QNA_VW where cl_clname =#{search}")
	int getqnaCount(String search); // qna 총 게시물 갯수

	int getqnaDetailCount(@Param("search") String search, @Param("selvalue") String selvalue);// 검색시 카운트

	@Select("SELECT COUNT(*) FROM REVIEW_VW where cl_clname =#{search}")
	int getreviewCount(String search); // review 총 게시물 갯수

	int getreviewDetailCount(@Param("search") String search, @Param("selvalue") String selvalue);

	@Select("SELECT  * FROM vw_class WHERE CL_CLNAME = #{cl_clname} and AA_ID = #{id} order by Co_NUM asc")
	List<Clasc> selectClassListAjax(@Param("cl_clname") String cl_clname, @Param("id") String id);

	@Select("SELECT  * FROM co WHERE Co_idnum = #{Cl_idnum} order by Co_NAME asc")
	List<Clasc> clickmymemo(String Cl_idnum);

	List<Clasc> Memo(Map<String, Object> cList);// mapper 보냄

	void updatemymemo(HashMap<String, Object> test);// mapper 보냄

	@Delete("DELETE FROM COB WHERE COB_BONUM=#{cob_bonum}")
	void cobdelete(HashMap<String, Object> cobdelete);


	List<Clasc> selectClassHome(Clasc cb);

	@Select("SELECT ROUND(AVG(gpa_gpa),1) FROM gpa WHERE gpa_idnum = #{cl_idnum} AND gpa_lv=#{cl_lv}")
	String selectClassAvgNum(Clasc cb);

	@Select("SELECT * FROM (SELECT * FROM cobKindAndGpa ORDER BY gpa_gpa DESC) WHERE cob_idnum=#{cl_idnum} AND cob_lv=#{cl_lv} AND ROWNUM <= 2")
	List<CourseBoard> selectInfoReview(Clasc cb);

	@Select ("SELECT mb_point FROM mb WHERE mb_ID = #{MB_ID}")
	   String selectMypoint(String id);
	@Select("SELECT mb_point FROM mb WHERE mb_ID = #{MB_ID}")
	String selectMyPointAjax(String pt_id);
	String UpdateMyPoint(@Param("resultpt")String resultpt,@Param("id")String id);

}
