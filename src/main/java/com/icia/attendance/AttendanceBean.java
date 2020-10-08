package com.icia.attendance;



import lombok.Data;
import lombok.experimental.Accessors;


@Data
@Accessors(chain = true)
public class AttendanceBean {
	String atd_atmk;//1
	Integer atd_num;
	String atd_id; 
	String atd_idnum; 
	Integer atd_lv;   
	
	
}
