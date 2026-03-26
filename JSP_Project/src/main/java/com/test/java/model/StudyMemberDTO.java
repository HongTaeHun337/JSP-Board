package com.test.java.model;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class StudyMemberDTO {
    private String seq_study_join; // 조인 고유번호
    private String seq_study;      // 스터디 번호
    private String seq_user;       // 유저 번호
    private String regdate;        // 가입(신청)일
    private String status;         // 상태 (0:대기, 1:참여)
    private String authority;      // 권한 (0:일반, 1:방장)
    
    // 🌟 tbl_User 테이블과 조인해서 가져올 닉네임!
    private String userName;       
}