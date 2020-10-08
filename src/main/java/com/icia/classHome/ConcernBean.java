package com.icia.classHome;

import org.apache.ibatis.type.Alias;

import lombok.Data;
@Alias("concern")
@Data
public class ConcernBean {

	private String cc_id;
	private String cc_cc;
	private int cc_check;
}
