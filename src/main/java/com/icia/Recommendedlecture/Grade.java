package com.icia.Recommendedlecture;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.type.Alias;

import lombok.Data;
import lombok.experimental.Accessors;

@Alias("gr")
@Accessors(chain=true)
@Data
public class Grade {
private String lv_idnum;
private int lv_lv;
private String lv_id;
private String gr_idnum;
private String gr_id;
private int gr_num;
private int gr_iv;
private int gr_score;
private String gr_kind;
}