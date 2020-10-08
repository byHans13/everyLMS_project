package com.icia.email;

import java.util.List;

import org.apache.ibatis.type.Alias;

import lombok.Data;
import lombok.experimental.Accessors;
@Alias("email")
@Data
@Accessors(chain = true)
public class Email {
	
	String e_id;
	String e_name;
	String e_email;
	String e_checknum;
	String e_checknum2;
	
}
