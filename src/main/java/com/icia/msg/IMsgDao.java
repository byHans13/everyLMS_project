package com.icia.msg;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.icia.classup.ClassUpBean;

public interface IMsgDao {

	
	
	
	@Insert("INSERT INTO MESSAGE(msg_id,msg_receiver,msg_date,msg_text,msg_st) VALUES(#{msg_id},#{receiver},default,#{msg},default)")
	boolean insertSendMsg(@Param("msg_id")String msg_id, @Param("receiver")String receiver,@Param("msg") String msg);

	
	
	
	
	
	
	@Update("UPDATE MESSAGE SET MSG_ST ='1' WHERE MSG_ID=#{msg_id} AND MSG_RECEIVER=#{receiver} AND MSG_TEXT=#{msg_text}")
	int updateSt(@Param("msg_id")String msg_id, @Param("receiver")String receiver,@Param("msg_text")String msg_text);






	@Select("SELECT * FROM AACLMSG WHERE MSG_RECEIVER=#{msg_receiver}")
	List<MsgBean> selectMsg(@Param("msg_receiver") String msg_receiver);
	
	


}
