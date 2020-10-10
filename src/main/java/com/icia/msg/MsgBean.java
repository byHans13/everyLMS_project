package com.icia.msg;

import lombok.Data;
import lombok.experimental.Accessors;

@Data
@Accessors(chain = true)
public class MsgBean {
	
	String msg_id;
	String msg_receiver;
	String msg_date;
	String msg_text;
	String msg_st;
	
}
