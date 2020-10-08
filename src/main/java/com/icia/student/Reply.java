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
	private int r_bnum; //원글 번호(FK)
	private int r_num; //댓글 번호(PK)
	private String r_contents; //댓글
	//메세지 컨버터(jackson): 서버에서 클라이언트로 데이터를 변환해서 보내준다.
	//jackson 과 Timestamp서로 호환되지 않는다.(외장jackson 필요)
	@JsonFormat(pattern="yyyy-MM-dd hh:mm:ss")
	private Timestamp r_date; // 날짜-->문자 to_char()사용안하기 위해
	private String r_id; // 작성자(FK)
}
