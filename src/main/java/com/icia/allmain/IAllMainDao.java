package com.icia.allmain;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Select;

public interface IAllMainDao {

List<AllmainBean> selectmainstudentview();
@Select("SELECT CC_CC FROM CC WHERE CC_ID=#{cc_id} and cc_check=1")
ArrayList<String> selectCc(String cc_id);

}
