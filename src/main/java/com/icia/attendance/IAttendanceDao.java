package com.icia.attendance;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.springframework.web.bind.annotation.RequestParam;

public interface IAttendanceDao {
	
	
	
	
	@Select("SELECT COUNT (*) FROM ATD WHERE ATD_ATMK='1' AND ATD_ID=#{atd_id}"
			+ " AND ATD_LV=#{atd_lv} AND ATD_IDNUM=#{atd_idnum}")
	
	Integer countAt(@Param("atd_id")String atd_id, @Param("atd_idnum") String atd_idnum,
			        @Param("atd_lv") String atd_lv);



}
