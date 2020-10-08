package com.icia.student;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.type.Alias;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;
import lombok.experimental.Accessors;

@Alias("cl")
@Accessors(chain=true)
@Data
public class Clasc {
private String Cl_idnum;
private int Cl_lv;
private String cl_clname;
private String Cl_id;
private Timestamp cl_fnday;
@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "Asia/Seoul")
private Timestamp cl_stday;
private int Cl_pt;
private int Cl_lcnum;
private String Cl_cc;

//bean 연결
private String co_name;
private int co_num;
private int mo_num;
private int pb_pbnum;
private String atd_atmk;
private String cob_id;
private String cob_title;
private String cob_bonum;
private int cob_kind;
private Timestamp cob_date;
private String mo_contents;
private String pi_pisysname;
private String pi_pioriname;
private String cc_cc;
private double gpa_gpa;
@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "Asia/Seoul")
private Timestamp point_date;
private int point_pt;

}