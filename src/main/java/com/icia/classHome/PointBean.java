package com.icia.classHome;

import org.apache.ibatis.type.Alias;

import lombok.Data;
@Alias("point")
@Data
public class PointBean {

	private String point_date;
	private int point_pt;
	private String point_id;
}
