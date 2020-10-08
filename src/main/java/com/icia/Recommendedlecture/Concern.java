package com.icia.Recommendedlecture;



import org.apache.ibatis.type.Alias;

import lombok.Data;
import lombok.experimental.Accessors;

@Alias("cc")
@Accessors(chain=true)
@Data
public class Concern {
private String cc_id;
private String cc_cc;
private int cc_check;

}