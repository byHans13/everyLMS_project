package com.icia.board;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Select;

import com.icia.email.Email;
import com.icia.student.Clasc;
import com.icia.student.CourseBoard;


public interface BoardDao {
@Select("SELECT * FROM COB")
	List<CourseBoard> insertcounselboard(String id);

List<CourseBoard> Boardlist(Integer pageNum);

@Select("SELECT COUNT(*) FROM COB")
int getBoardCount();

boolean boardWriteSelectKey(CourseBoard board);

	
}

