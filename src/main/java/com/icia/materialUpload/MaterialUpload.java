package com.icia.materialUpload;

import java.util.List;

import org.apache.ibatis.type.Alias;

import lombok.Data;
import lombok.experimental.Accessors;

@Alias("materialUpload")
@Data
@Accessors(chain = true)
public class MaterialUpload {
	//class
	private String cl_idnum;
	private int cl_lv;
	private String cl_clname;
	private String cl_id;
	private String cl_fnday;
	private String cl_stday;
	private int cl_pt;
	private int cl_lcnum;
	private String cl_cc;
	
	//course
	private int co_num;
	private int co_lv;
	private String co_name;
	private String co_idnum;
	
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
	private String pb_pbstudans;	//학생답
	private String pb_pbdate;		//제출날짜
	private int pb_pbchkqz;			//시험/퀴즈
	
	private List<MaterialUpload_Problem> muPbList;
	
	//detailProblem
	private int dp_num;				//강의 회차
	private String dp_idnum;		//일련번호
	private int dp_pbnum;			//문제번호
	private String dp_id;			//아이디
	private int dp_lv;				//레벨값
	private String dp_pbexm;		//문제보기
	private int dp_pbexmnum;		//문제보기번호
	private String dp_pbexmnumSt;	//문제보기번호 문자열타입
	private String dp_coname;		//관련강좌명
	
}
