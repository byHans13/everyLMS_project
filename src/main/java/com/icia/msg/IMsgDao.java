package com.icia.msg;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Update;

import com.icia.classup.ClassUpBean;

public interface IMsgDao {

	
	
	
	@Insert("INSERT INTO MESSAGE(msg_id,msg_receiver,msg_date,msg_text,msg_st) VALUES(#{msg_id},#{receiver},default,#{msg},default)")
	boolean insertSendMsg(@Param("msg_id")String msg_id, @Param("receiver")String receiver,@Param("msg") String msg);

	
	
	
	
	
	
	@Update("UPDATE MESSAGE SET MSG_ST ='1' WHERE MSG_ID=#{msg_id} AND MSG_RECEIVER=#{receiver}")
	int updateSt(@Param("msg_id")String msg_id, @Param("receiver")String receiver);
	
	


}
