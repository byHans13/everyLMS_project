package com.icia.Recommendedlecture;


import org.apache.ibatis.type.Alias;

import lombok.Data;
import lombok.experimental.Accessors;

@Alias("pi")
@Accessors(chain=true)
@Data
public class Picture {
private int  pi_lv;
private String pi_pisysname;
private String pi_pioriname;
private String pi_idnum;
}

