package com.icia.homework;

import java.util.Date;
import java.util.List;

import com.icia.course.CourseFilesBean;

import lombok.Data;
import lombok.experimental.Accessors;



@Data
@Accessors(chain = true)
public class HomeworkBean {
	
			String hw_hwname; 
			String hw_id ;
			Integer hw_num;
			String hw_idnum;
			Integer hw_lv;
			String hw_date;
			String hw_psfa;//업로드시0
			
			List<CourseFilesBean> fbList; 
			
			
			
			String gr_seqnum; 
			String gr_idnum;
			String gr_id;
			Integer gr_num;
			Integer gr_lv;
			Integer gr_score;
			String gr_kind="H";
			
			
			
			
		
			   
}
