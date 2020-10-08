package com.icia.materialUpload;

import java.util.List;

import org.apache.ibatis.type.Alias;

import lombok.Data;
import lombok.experimental.Accessors;

@Alias("muDetailProblem")
@Data
@Accessors(chain = true)
public class MaterialUpload_DetailProblem {
	//detailProblem
	private int dp_pbnum;		//문제번호
	private String dp_idnum;
	private List<MaterialUpload_DPExm> muDpExmList;		//문제보기 리스트
	
}






