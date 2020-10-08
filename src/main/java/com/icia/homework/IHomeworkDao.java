package com.icia.homework;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.icia.classup.ClassUpBean;

public interface IHomeworkDao {
	
	
	
	
	boolean insertHomework(HomeworkBean hb);

	List<HomeworkBean> selectHomeworkList(@Param("hw_num")String hw_num, @Param("hw_lv")String hw_lv, @Param("hw_idnum")String hw_idnum);

	@Select("SELECT CL_ID FROM CL WHERE CL_IDNUM=#{cl_idnum}")
	String selectProId(String cl_idnum);

	
	@Select("SELECT HW_ID FROM HW WHERE NOT HW_ID=#{hw_id} AND NOT HW_PSFA='0' AND HW_NUM=#{hw_num} AND HW_LV=#{hw_lv} AND HW_IDNUM=#{hw_idnum}")
	List<String> selectStHWList(@Param("hw_id")String hw_id, @Param("hw_lv")String hw_lv, @Param("hw_idnum")String hw_idnum, @Param("hw_num")String hw_num);

	List<HomeworkBean> selectHwResult(@Param("hw_id")String hw_id, @Param("hw_num")String hw_num,@Param("hw_lv")String hw_lv, @Param("hw_idnum")String hw_idnum);
	
	
	
	
	
	@Update("UPDATE HW SET HW_PSFA=#{hw_psfa} WHERE HW_ID=#{hw_id} AND HW_NUM=#{hw_num} AND HW_IDNUM=#{hw_idnum} AND NOT HW_PSFA='0'")
	Integer updateStHw(@Param("hw_id") String hw_id, @Param("hw_idnum") String hw_idnum, @Param("hw_num") String hw_num, @Param("hw_psfa") String hw_psfa);
	
}
