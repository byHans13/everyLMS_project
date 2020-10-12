package com.icia.student;

import java.sql.Timestamp;
import java.util.ArrayList;

import org.apache.ibatis.type.Alias;
import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;
import lombok.experimental.Accessors;

@Alias("cobs")
@Accessors(chain=true)
@Data
public class CourseBoard {
private String cob_idnum;
private int cob_lv;
private int cob_num;
private String cob_id;
private String cob_title;
private String cob_bonum;
private String cob_cont;
private String cob_contents;
@DateTimeFormat
private Timestamp cob_date;
private int cob_kind;
}