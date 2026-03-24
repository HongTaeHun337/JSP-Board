// 게시글
package com.test.java;

import java.util.Random;

public class NoteDummyGenerator {
    public static void main(String[] args) {
        Random random = new Random();
        
        // 생성할 더미 데이터 개수
        int totalCount = 60; 
        
        // 게시글 제목 샘플 (기획서에 있던 내용들 활용!)
        String[] titles = {
            "스프링 설정 파일 오류 해결법 아시는 분?",
            "오늘 점심 메뉴 추천 받습니다.",
            "NullPointerException 질문드려요",
            "오라클 DB 모델링 질문 있습니다.",
            "스터디 구합니다 (백엔드)",
            "어제 축구 보신 분?",
            "UI 와이어프레임 어떤 툴 쓰시나요?",
            "정보처리기사 실기 꿀팁 공유합니다.",
            "ERD 화살표 방향 헷갈리네요",
            "자바 기초부터 다시 공부 중입니다."
        };
        
        String[] suffixes = {
        	    " 관련해서 궁금한 점이 있어서 글 남깁니다. 답변 부탁드려요!",
        	    "에 대해 자세히 알고 싶어 문의드립니다. 확인 부탁드려요!",
        	    "에 대해 몇 가지 여쭤볼 게 있습니다. 답변 기다릴게요.",
        	    " 상세 정보가 궁금합니다. 혹시 알려주실 수 있나요?",
        	    " 관련 내용 확인했습니다. 추가로 궁금한 점이 있어 글 남겨요!"
        	};

        System.out.println("--- tbl_Note 더미 데이터 INSERT 쿼리 시작 ---\n");

        for (int i = 1; i <= totalCount; i++) {
            int seq_note = i; // 게시글 번호 (1부터 순차 증가)
            int seq_user = random.nextInt(100) + 1; // 회원 번호 (1~50번 회원이 있다고 가정)
            
            // 게시판 번호 (1: 자유게시판, 2: 질문게시판, 3: 스터디모집 등 1~4 사이 랜덤)
            int seq_board = random.nextInt(4) + 1; 
            
            // 제목과 내용 랜덤 생성
            String title = titles[random.nextInt(titles.length)];
            String suffixe = suffixes[random.nextInt(suffixes.length)];
            String detail = title + suffixe;
            
            // 조회수 (0 ~ 300 사이 랜덤)
            int viewcount = random.nextInt(300);
            
            // 작성일 (현재 날짜로부터 0~60일 전 사이 랜덤으로 설정하여 현실감 부여)
            int minusDays = random.nextInt(60);

            // 오라클 INSERT문 문자열 포맷팅
            String sql = String.format(
                "INSERT INTO tbl_Note (seq_note, seq_user, seq_board, title, detail, regdate, fixdate, viewcount) " +
                "VALUES (seq_note.nextVal, %d, %d, '%s', '%s', SYSDATE - %d, null, %d);",
                 seq_user, seq_board, title, detail, minusDays, viewcount
            );

            System.out.println(sql);
        }
        
        System.out.println("\n--- tbl_Note 더미 데이터 INSERT 쿼리 끝 ---");
    }
}