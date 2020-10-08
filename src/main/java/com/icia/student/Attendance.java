package com.icia.student;

import java.sql.Timestamp;
import java.util.ArrayList;

import org.apache.ibatis.type.Alias;

import lombok.Data;
import lombok.experimental.Accessors;

@Alias("atd")
@Accessors(chain=true)
@Data
public class Attendance {
private String atd_atmk;
private int atd_num;
private String atd_id;
private String atd_idnum;
private int atd_lv;
}