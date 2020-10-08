package com.icia.member;

import java.util.List;

import org.apache.ibatis.type.Alias;

import lombok.Data;
import lombok.experimental.Accessors;
@Alias("member")
@Data
@Accessors(chain = true)
public class Member {
	private String mb_id;
	private String mb_pw;
	private String mb_name;
	private String mb_email;
	private String mb_phone;
	private String mb_loe;
	private String mb_addr;
	private String mb_rrn;
	private String mb_gender;
	private int mb_rrn1;
	private int mb_rrn2;
	private int mb_point;
	private String cc_cc;
	
	private List<String> t1_menu;
}
