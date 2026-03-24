// 댓글
package com.test.java;

import java.util.Random;

public class CommentDummyGenerator {
    public static void main(String[] args) {
        Random random = new Random();
        
        // 생성할 댓글 개수 (게시글이 60개니까 댓글은 150개 정도로 넉넉하게!)
        int totalComments = 150; 
        
     // 1. 인사말/감탄사 (앞부분)
        String[] greetings = {
            "오!", "와...", "안녕하세요~", "대박!", "헐", "" // 빈 문자열도 넣어서 자연스럽게
        };
        
        // 실제 스터디/개발 커뮤니티에서 쓸 법한 리얼한 댓글 내용들
        String[] comments = {
            "좋은 정보 감사합니다! 당장 적용해 봐야겠네요.",
            "저도 같은 에러 때문에 며칠 고생했는데, 덕분에 해결했습니다!",
            "오라클 조인할 때 이 부분 항상 헷갈렸는데 정리 최고입니다.",
            "혹시 스프링부트 버전은 몇 점 대 사용하셨나요?",
            "이거 퍼가도 될까요? 출처는 꼭 남기겠습니다.",
            "와... 코드가 진짜 깔끔하네요. 많이 배워갑니다.",
            "질문 있습니다! 여기서 이 메서드를 쓴 특별한 이유가 있을까요?",
            "저도 같이 스터디 참여하고 싶은데 아직 자리 있나요?",
            "링크가 안 열리는 것 같아요. 확인 한 번 부탁드립니다~",
            "비밀댓글입니다.", // 진짜 게시판 같은 디테일 ㅋㅋ
            "오늘도 좋은 글 잘 읽고 갑니다. 화이팅!",
            "이 방식 말고 다른 방법으로 구현해 보는 건 어떨까요?"
        };
        
        String[] endings = {
                "ㅎㅎ", "ㅠㅠ", "!!", "👍", "화이팅!", "감사합니다.", "" 
            };

        System.out.println("--- tbl_Comment 더미 데이터 INSERT 쿼리 시작 ---\n");

        for (int i = 1; i <= totalComments; i++) {
            
            // 유저 번호: 1 ~ 100번 사이 랜덤 (100명 제약조건 반영)
            int seq_user = random.nextInt(100) + 1; 
            
            // 게시글 번호: 1 ~ 60번 사이 랜덤 (60개 제약조건 반영)
            int seq_note = random.nextInt(60) + 1; 
            
            // 댓글 내용 랜덤 선택
            String comment = comments[random.nextInt(comments.length)];
            String greeting = greetings[random.nextInt(greetings.length)];
            String ending = endings[random.nextInt(endings.length)];
            String detail = comment + greeting + ending;
            
            // 작성일 & 수정일 (0~30일 전 사이 랜덤으로 설정)
            int minusDays = random.nextInt(30);
            
            // 삭제 여부 status (0: 정상, 1: 삭제)
            // random.nextInt(10) == 0 이면 10% 확률로 1(삭제)을 부여
            int status = (random.nextInt(10) == 0) ? 1 : 0; 

            // 오라클 INSERT문 문자열 포맷팅
            String sql = String.format(
                "INSERT INTO tbl_Comment (seq_comment, seq_user, seq_note, detail, regdate, fixdate, status) " +
                "VALUES (seq_comment.nextval, %d, %d, '%s', SYSDATE - %d, null, %d);",
                seq_user, seq_note, detail, minusDays, status
            );

            System.out.println(sql);
        }
        
        System.out.println("\n--- tbl_Comment 더미 데이터 INSERT 쿼리 끝 ---");
    }
}