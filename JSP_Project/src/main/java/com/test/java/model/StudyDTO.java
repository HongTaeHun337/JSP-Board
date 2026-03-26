package com.test.java.model;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString

public class StudyDTO {
    private String seq_study;       // 스터디 번호
    private String seq_user;        // 방장(개설자) 번호
    private String title;           // 스터디명
    private String introduce;       // 소개글
    private String max_population;  // 최대 인원
    private String population;      // 현재 인원
    private String regdate;         // 개설일
    private String fixdate;         // 수정일
    private String status;          // 상태 (0:모집중, 1:진행중, 2:종료)
    private String location;        // 지역
    private String isonline;        // 온/오프라인 여부
    
    private String studyType; // 진행 방식 (ONLINE / OFFLINE)
    private String content;   // 스터디 상세 설명
    private String tech;      // 기술 스택 (예: "Java, Spring Boot, JPA")
    
}