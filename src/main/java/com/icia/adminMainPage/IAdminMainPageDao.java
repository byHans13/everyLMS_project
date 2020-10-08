package com.icia.adminMainPage;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.icia.introductionTeacherConfirm.IntroductionTeacherConfirmBean;

public interface IAdminMainPageDao {

	
	

	



	

	@Select ("SELECT AT_DATE FROM AT") 
	List<String> selectJoinMemberAdmin();
	
	int selectCountJoinMember(@Param("searchMonth")String searchMonth, @Param("setCompLast")String setCompLast);
	@Select("SELECT COUNT(*) FROM CERTIFORPROF WHERE CT_CHECK= 1 ")
	int selectCountCtTable();
	@Select("SELECT * FROM CERTIFORPROF WHERE CT_CHECK=1")
	List<IntroductionTeacherConfirmBean> selectProfCerti();
	
	List<AdminMainPageBean> selectIntroduction(@Param("mb_id")String mb_id, @Param("ct_prof")String ct_prof);

	List<AdminMainPageBean> selectCertification(@Param("mb_id")String mb_id, @Param("ct_prof")String ct_prof);
	@Insert("INSERT INTO at (AT_ID,AT_AT,AT_DATE) VALUES(#{mb_id},'ROLE_PROF', default)")
	String insertYesConfirm(String mb_id);

}
