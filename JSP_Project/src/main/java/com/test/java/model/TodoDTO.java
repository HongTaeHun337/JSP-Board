package com.test.java.model;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString

public class TodoDTO {

private String seq_plan;
private String seq_user;
private String title;
private String topic;
private String detail;
private String endtype;
private String goal;
private String startdate;
private String enddate;
private String regdate;
private String fixdate;
private String status;

private String name;
private long progressDays;
private long dday;
private long percent;

	
}
