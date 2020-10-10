package com.icia.Recommendedlecture;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.icia.email.Email;
import com.icia.student.Clasc;

public interface RecommendDao {
	List<Levels> LevelMatchPage(String id);

	@Select("select * from Lvmat_vw where cl_lv = #{MyLevel}")
	List<Clasc> selectMyLevelMatch(String MyLevel);

	int getlevelmatchCount(@Param("search") String search,@Param("selvalue") String selvalue); // 레벨 매칭 게시물 갯수

	@Select("SELECT cc_cc FROM cc where cc_id = #{id}")
	List<Concern> CCMatchPage(String id);

	@Select("SELECT * FROM Ccmat_vw where cl_cc = #{Mycc}")
	List<Clasc> selectMyinterestAjax(String Mycc);

	List<Clasc> searchLevelDetail(@Param("pageNum") int pageNum, @Param("search") String search,
			@Param("selvalue") String selvalue); // 레벨 매칭 검색

	List<Clasc> lnterestSearchDetail(@Param("pageNum") int pageNum, @Param("search") String search,
			@Param("selvalue") String selvalue); // 관심 매칭 검색

	List<Clasc> DeeplearningSearchDetail(@Param("pageNum") int pageNum, @Param("search") String search,
			@Param("selvalue") String selvalue);// 심화 매칭 검색

	
	int lnterestCount(@Param("search") String search,@Param("selvalue") String selvalue); // 관심 매칭 게시물 갯수

	@Select("select * from avgmat_vw  where cl_cc = #{cc} and cl_lv > 4")
	List<Clasc> selectMylnterestLevel(String lnterestLevel);

	@Select("SELECT floor(avg(lv_lv)) FROM lv where lv_id = #{mb_id}")
	int selectMyDeepenlnterestAjax(String mb_id);

}
