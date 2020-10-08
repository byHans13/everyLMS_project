package com.icia.materialUpload;

import java.util.List;

import org.apache.ibatis.type.Alias;

import lombok.Data;
import lombok.experimental.Accessors;

@Alias("muDPExm")
@Data
@Accessors(chain = true)
public class MaterialUpload_DPExm {
	//detailProblem
	private String dp_idnum;
	private String dp_pbexm;		//문제보기 리스트
	private int dp_pbexmnum;		//문제보기번호 리스트

}






