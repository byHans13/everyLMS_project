package com.icia.materialUpload;

import java.util.List;

import org.apache.ibatis.type.Alias;

import lombok.Data;
import lombok.experimental.Accessors;

@Alias("muProblem")
@Data
@Accessors(chain = true)
public class MaterialUpload_Problem {
	//problem
	private String pb_idnum;		//일련번호
	
	private int pb_num;				//강의회차
	private String pb_numSt;		//강의회차 문자열타입
	
	private int pb_pbnum;			//문제번호
	private String pb_pbnumSt;		//문제번호 문자열타입
	
	private String pb_id;			//아이디
	private int pb_lv;				//레벨값
	private String pb_pbname;		//문제명
	private String pb_pbanswer;		//해설
	private String pb_pbexplain;	//정답
	private String pb_pbstudent;	//학생답
	private String pb_pbdate;		//제출날짜
	private int pb_pbchkqz;			//시험/퀴즈
	
	//detailProblem
	private List<MaterialUpload_DetailProblem> muDpList;		//문제보기 리스트
	private String dp_coname;
	
}




