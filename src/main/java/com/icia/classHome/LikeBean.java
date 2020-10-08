package com.icia.classHome;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Alias("likes")
@Data
public class LikeBean {
	private String likes_id;
	private String likes_idnum;
	private int likes_lv;
	private int likes_check;
}
