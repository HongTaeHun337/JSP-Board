package com.test.java.model;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class StudyScheduleDTO {
    private String seq_study_day; // 일정 번호
    private String seq_study;     // 스터디 번호
    private String title;         // 일정 제목
    private String startperiod;   // 원본 시작 날짜+시간 (DB용)
    private String endperiod;     // 일정 종료 날짜
    private String topic;         // 학습 주제
    private String detail;        // 일정 설명 (장소 용도로 활용!)
    private String regdate;       // 생성일
    private String fixdate;       // 수정일
    
    // 🌟 JSP에서 편하게 쓰기 위해 만든 가공용 데이터
    private String scheduleDate;  // 날짜만 (예: 2026-03-25)
    private String scheduleTime;  // 시간만 (예: 20:00)
    
    // JSP에서 location으로 불렀으니 매핑용으로 하나 만들어둠
    public String getLocation() {
        return this.detail; 
    }
}