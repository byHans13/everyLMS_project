package com.icia.student;

import java.sql.Timestamp;
import java.util.ArrayList;

import org.apache.ibatis.type.Alias;

import lombok.Data;
import lombok.experimental.Accessors;

@Alias("MO")
@Accessors(chain=true)
@Data
public class MEMO {
private String mo_idnum;
private String mo_id;
private String mo_contents;
private int mo_lv;
private int mo_num;
}