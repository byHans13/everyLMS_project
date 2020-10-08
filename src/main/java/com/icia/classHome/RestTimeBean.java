package com.icia.classHome;

import org.apache.ibatis.type.Alias;

import lombok.Data;
@Alias("restTime")
@Data
public class RestTimeBean {
	private String rt_id;
	private String rt_idnum; 
	private int rt_lv;
	private int rt_num;
	private double rt_restTime;
	private double rt_duration;
}
