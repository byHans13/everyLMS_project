package com.icia.student;

import java.sql.Timestamp;
import java.util.ArrayList;

import org.apache.ibatis.type.Alias;

import lombok.Data;
import lombok.experimental.Accessors;

@Alias("pt")
@Accessors(chain=true)
@Data
public class Point {
private Timestamp point_date;
private int point_pt;
private String point_id;
}