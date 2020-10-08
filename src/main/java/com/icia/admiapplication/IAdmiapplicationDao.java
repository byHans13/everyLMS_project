package com.icia.admiapplication;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;


public interface IAdmiapplicationDao {
	
	
	@Select("SELECT * FROM AA WHERE AA_LV=#{aa_lv} AND AA_IDNUM=#{aa_idnum}")
	List<AdmiapplicationBean> selectAaList(@Param("aa_lv")String aa_lv, @Param("aa_idnum")String aa_idnum);

	



}
