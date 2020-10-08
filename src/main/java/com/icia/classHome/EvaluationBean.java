package com.icia.classHome;

import org.apache.ibatis.type.Alias;

import lombok.Data;
@Alias("evaluation")
@Data
public class EvaluationBean {
	private Integer ef_num;
	private Integer ef_lv;
	private String ef_item;
	private String ef_idnum;
	private String ef_question;
	
	//answer
	private String ea_id;
	private String ak_scName;
	private Integer ak_score;
}
