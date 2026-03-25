package com.test.java.model;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class RecordDTO {
	
    private String seq_plan_history;
    private String seq_plan;
    private String seq_user;
    private String studydate;
    private String detail;
    private String memo;
    private String regdate;
    private String fixdate;
    
}