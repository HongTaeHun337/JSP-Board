// 🚨 주의: 맨 윗줄은 네 프로젝트 패키지명으로 꼭 수정해! (예: package com.test.java;)
package com.test.java;

import java.util.Random;

public class FileMappingDummyGenerator {
    public static void main(String[] args) {
        Random random = new Random();
        
        // 생성할 매핑 데이터 개수
        int totalCount = 30; 

        System.out.println("--- tbl_File_mapping 더미 데이터 INSERT 쿼리 시작 ---\n");

        for (int i = 1; i <= totalCount; i++) {
            
            // 게시글 번호: 1 ~ 60번 게시글 중 랜덤으로 하나 선택해서 매핑
            int seq_number = random.nextInt(60) + 1; 
            
            // 파일 번호: 1 ~ 30번 파일을 순차적으로 매핑
            // (만약 한 게시글에 여러 파일이 랜덤하게 묶이는 걸 원하면 random.nextInt(30) + 1 로 바꿔도 좋아!)
            int seq_file_data = random.nextInt(30) + 1; 

            // 🔥 type 컬럼이 깔끔하게 제거된 INSERT 문 🔥
            String sql = String.format(
                "INSERT INTO tbl_File_mapping (seq_file_mapping, seq_number, seq_file_data) " +
                "VALUES (seq_file_mapping.nextVal, %d, %d);",
                seq_number, seq_file_data
            );

            System.out.println(sql);
        }
        
        System.out.println("\n--- tbl_File_mapping 더미 데이터 INSERT 쿼리 끝 ---");
    }
}