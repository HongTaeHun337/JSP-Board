package com.test.java;

import java.util.Random;

public class PlanHistoryDummyGenerator {
    public static void main(String[] args) {
        Random random = new Random();
        
        // 생성할 학습기록 개수 (회원이 100명이니 200개 정도 넉넉하게!)
        int totalCount = 300; 

        // 1. 학습내용 (짧은 요약)
        String[] details = {
            "자바 기초 문법 복습", 
            "오라클 다중 JOIN 실습", 
            "스프링 MVC 동작 원리 이해",
            "HTML/CSS 레이아웃 연습", 
            "JavaScript 이벤트 처리", 
            "게시판 페이징 로직 구현",
            "ERD 설계 및 데이터베이스 정규화", 
            "깃(Git)과 깃허브(GitHub) 협업 세팅", 
            "JSP 파일 업로드 기능 구현",
            "REST API 설계 및 테스트"
        };

        // 2. 메모 (구체적인 소감이나 남길 말)
        String[] memos = {
            "오늘 진도 나간 부분 완벽하게 이해함! 내일은 응용 예제 풀어보기.",
            "에러가 계속 나서 2시간 동안 구글링함.. 결국 오타였음 ㅠㅠ",
            "스터디원들과 코드 리뷰하면서 더 좋은 로직을 찾았다.",
            "개념이 아직 헷갈린다. 주말에 인강 다시 돌려봐야겠다.",
            "포트폴리오에 바로 적용할 수 있을 것 같아서 따로 블로그에 정리해둠.",
            "시간이 부족해서 계획한 분량을 다 못 끝냄. 내일 이어서 할 예정!",
            "생각보다 너무 재밌다! 진도가 쑥쑥 나감 ㅎㅎ",
            "강사님이 짚어주신 핵심 포인트 위주로 복습 완료."
        };

        System.out.println("--- tbl_Plan_History 더미 데이터 INSERT 쿼리 시작 ---\n");

        for (int i = 1; i <= totalCount; i++) {
            // 계획 번호: 1 ~ 100번 (학습 계획이 50개 정도 있다고 가정)
            int seq_plan = random.nextInt(100) + 1; 
            
            // 유저 번호: 1 ~ 100번 (100명 회원 풀 유지)
            int seq_user = random.nextInt(100) + 1; 

            // 배열에서 랜덤으로 텍스트 뽑기
            String detail = details[random.nextInt(details.length)];
            String memo = memos[random.nextInt(memos.length)];

            // 학습 날짜 및 등록일 (최근 60일 이내의 랜덤한 과거 날짜)
            int minusDays = random.nextInt(60);

            // 오라클 INSERT문 문자열 포맷팅
            // PK는 seq_plan_history.nextVal 사용, 수정일(fixdate)은 쿨하게 NULL 처리!
            String sql = String.format(
                "INSERT INTO tbl_Plan_History (seq_plan_history, seq_plan, seq_user, studydate, detail, memo, regdate, fixdate) " +
                "VALUES (seq_plan_history.nextVal, %d, %d, SYSDATE - %d, '%s', '%s', SYSDATE - %d, NULL);",
                seq_plan, seq_user, minusDays, detail, memo, minusDays
            );

            System.out.println(sql);
        }
        
        System.out.println("\n--- tbl_Plan_History 더미 데이터 INSERT 쿼리 끝 ---");
    }
}