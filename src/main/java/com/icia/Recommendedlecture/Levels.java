package com.icia.Recommendedlecture;



import org.apache.ibatis.type.Alias;

import lombok.Data;
import lombok.experimental.Accessors;

@Alias("lvs")
@Accessors(chain=true)
@Data
public class Levels {
private String lv_idnum;
private int lv_lv;
private String lv_id;

}