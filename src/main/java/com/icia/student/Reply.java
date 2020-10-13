package com.icia.student;
import java.util.Date;
import java.sql.Timestamp;
import java.time.LocalDateTime;

import org.apache.ibatis.type.Alias;
import org.apache.ibatis.type.MappedTypes;
import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;
import lombok.experimental.Accessors;

@Alias("reply")
@Accessors(chain=true)
@Data
public class Reply {
	private String cr_idnum;
	private int cr_lv;
	private int cr_num; 
	private String cr_id;
	private String cr_bonum;
	private String cr_reply;

@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "Asia/Seoul")
	private Timestamp cr_date;
	
	
}
