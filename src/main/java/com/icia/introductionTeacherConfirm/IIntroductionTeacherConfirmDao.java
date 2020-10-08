package com.icia.introductionTeacherConfirm;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

public interface IIntroductionTeacherConfirmDao {
	@Insert("INSERT INTO CERTIFILE (ctf_prof, ctf_id, ctf_oriname, ctf_sysname, ctf_check)VALUES(#{ctf_prof},#{ctf_id}, #{oriFileName},#{sysFileName},#{ctf_check})")
	boolean fileInsert(Map<String, String> fMap);
	
	int insertRegister(IntroductionTeacherConfirmBean itc);
	@Select("SELECT COUNT(*) FROM CERTIFORPROF WHERE CT_ID=#{ct_id}")
	int selectProfCheck(String ct_id);
	
	@Update ("UPDATE certiforprof SET ct_check='2' WHERE ct_id =#{mb_id}")
	void updateYesConfirm(String mb_id);

	List<IntroductionTeacherConfirmBean> selectLectureConfirm();

	List<IntroductionTeacherConfirmBean> selectLectureData(@Param("cl_idnum")String cl_idnum, @Param("co_lv")String co_lv);
	

	List<IntroductionTeacherConfirmBean> selectLectureConfirmYes(@Param("cl_idnum")String cl_idnum, @Param("co_lv")String co_lv);
	@Update("UPDATE class SET cl_ct=2 WHERE cl_idnum=#{cl_idnum} and cl_lv=#{co_lv}")
	void updateLectureConfirm(@Param("cl_idnum")String cl_idnum, @Param("co_lv")String co_lv);
	@Insert("INSERT INTO COURSE(co_num, co_lv, co_name, co_idnum,co_cont) VALUES (0, #{co_lv}, 'All Course gogo', #{cl_idnum},'오리엔테이션'")
	void insertCourseZero(String cl_idnum, String co_lv);

}
