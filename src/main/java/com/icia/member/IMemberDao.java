package com.icia.member;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.icia.email.Email;


public interface IMemberDao {

	boolean insertMemberJoin(Member mb);

	String securityPwd(String mb_id);

	void insertConcern(Member mb);

	void insertAuthority(Member mb);

	List<String> selectConcern(Member mb);

	int selectIdclick(String id);

	List<String> idChecknumConfirm(Email em);

	List<String> pwChecknumConfirm(Email em);

	boolean PwUpdate(Member mb);

	void insertAuthority2(@Param("mb_id")String mb_id, @Param("spl3")int spl3);
	
	@Select("select * from mb where mb_id=#{id}")
	List<Member> selectMbInfo(String id);

	
	@Select("select * from mb where mb_id=#{mb_id}")
	List<Member> selectMyInfo(String mb_id);

	
	@Update("UPDATE MB SET MB_NAME =#{name}, MB_LOE=#{loe} WHERE MB_ID = #{id}")
	int updateMyinfo(@Param("id")String id, @Param("name")String name, @Param("loe")String loe);

	
	@Update("UPDATE MB SET MB_PHONE =#{phone} WHERE MB_ID = #{id}")
	int goupphone(@Param("id")String id, @Param("phone")String phone);

	
	@Update("UPDATE MB SET MB_EMAIL =#{email} WHERE MB_ID = #{id}")
	int goupemailbtn(@Param("id")String id,@Param("email") String email);
}

