//파일 데이터

package com.test.java;

import java.util.Random;
import java.util.UUID;

public class InsertQueryGenerator {
    public static void main(String[] args) {
        Random random = new Random();
        
        // 랜덤으로 조합할 파일명과 확장자 배열
        String[] fileNames = {"profile", "board_img", "report", "test_data", "project_final"};
        String[] extensions = {".png", ".jpg", ".pdf", ".zip", ".docx"};
        
        int totalCount = 30; // 뽑고 싶은 더미 데이터 개수

        for (int i = 1; i <= totalCount; i++) {
            int fileNo = i; // 파일 번호 (1부터 순차 증가)
            int memberNo = random.nextInt(100) + 1; // 회원 번호 (1~50 사이 랜덤)
            
            // 파일명, 확장자 랜덤 선택
            String fileName = fileNames[random.nextInt(fileNames.length)];
            String ext = extensions[random.nextInt(extensions.length)];
            
            // 원본 파일명 (예: report_1.pdf)
            String originalFileName = fileName + "_" + i + ext;
            
            // 저장 파일명 (UUID 사용해서 실무처럼 안 겹치게 생성)
            String savedFileName = UUID.randomUUID().toString().replaceAll("-", "") + ext;
            
            // 저장 경로
            String savedPath = "C:/uploads/2026/03/";
            
            // 파일 크기 (10KB ~ 5MB 사이 랜덤)
            int fileSize = random.nextInt(5000000) + 10240; 

            // 오라클 INSERT문 문자열 포맷팅
            // 테이블명(FILE_TABLE)과 영문 컬럼명은 네 DB에 맞게 수정해서 써!
            String sql = String.format(
                "insert into TBL_FILE_DATA(seq_file_data, seq_user, origin_name, save_name, link, size_byte, regdate)" +
                "VALUES (SEQ_FILE_DATA.nextVal, %d, '%s', '%s', '%s', %d, SYSDATE);",
                 memberNo, originalFileName, savedFileName, savedPath, fileSize
            );

            // 콘솔에 출력
            System.out.println(sql);
        }
    }
}