package com.icia.classHome;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Alias("meme")
@Data
public class MemoBean {
private String mo_idnum;
private int mo_lv;
private int mo_num;
private String mo_id;
private String mo_contents;
}
