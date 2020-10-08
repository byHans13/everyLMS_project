package com.icia.student;

import java.util.List;

import org.apache.ibatis.type.Alias;

import lombok.Data;
import lombok.experimental.Accessors;
@Alias("co")
@Data
@Accessors(chain = true)
public class Course{
String co_name;
String co_idenum;
int co_num;
int co_lv;
}
