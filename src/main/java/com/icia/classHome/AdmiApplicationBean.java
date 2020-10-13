package com.icia.classHome;

import org.apache.ibatis.type.Alias;

import lombok.Data;
import lombok.experimental.Accessors;

@Data
@Alias("admiApplication")
@Accessors(chain=true)
public class AdmiApplicationBean {
private String cl_idnum;
private int cl_lv;
private String aa_id;
private String cl_clName;
private String cl_id;
private int cl_lcnum;
private String cl_cc;
private String cl_ct;
// cl + aa = aaCl view Page BeanClass
private int at_atmkCnt;
}
