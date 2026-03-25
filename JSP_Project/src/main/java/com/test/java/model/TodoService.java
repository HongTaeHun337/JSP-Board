package com.test.java.model;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.List;

public class TodoService {

    private TodoDAO dao;

    public TodoService() {
        this.dao = new TodoDAO();
    }

    public List<TodoDTO> getTodoList(String userId) {
        
        // 1. DAO에서 일단 DB 데이터(리스트)를 싹 가져옴
        List<TodoDTO> list = dao.todolist(userId);
        
        // 2. 날짜 계산을 위한 준비 (오늘 날짜와 DB 날짜 형식 지정)
        LocalDate today = LocalDate.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy.MM.dd"); // 네 DB 날짜 포맷에 맞춤!

        // 3. 리스트를 한 바퀴 돌면서 각각의 디데이/진행일 계산
        for (TodoDTO dto : list) {
            
            // 데이터가 널이 아닐 때만 계산 (에러 방지)
            if (dto.getStartdate() != null) {
                // 시작일 문자열을 진짜 날짜(LocalDate) 객체로 변환
                LocalDate startDate = LocalDate.parse(dto.getStartdate(), formatter);
                
                long diff = ChronoUnit.DAYS.between(today, startDate);
                
                if (diff > 0) {
                    // 1️⃣ 시작일이 미래인 경우 (예: 오늘 25일, 시작 28일 -> "3일 전")
                    // DTO의 progressDays에 음수나 0을 저장해서 JSP에서 구분하게 할게!
                    dto.setProgressDays(-diff); 
                } else {
                    // 2️⃣ 오늘이거나 과거인 경우 (예: 오늘 25일, 시작 23일 -> "3일째 도전 중")
                    // 당일부터 1일차이므로 절대값 + 1
                    dto.setProgressDays(Math.abs(diff) + 1);
                }
            }

            // 목표형 말고 '기간형(endtype=1)'이면서 종료일이 있을 때만 디데이 계산!
            if ("1".equals(dto.getEndtype()) && dto.getEnddate() != null) {
                LocalDate endDate = LocalDate.parse(dto.getEnddate(), formatter);
                
                // 🚀 [디데이 계산] 종료일 - 오늘 날짜
                long dday = ChronoUnit.DAYS.between(today, endDate);
                dto.setDday(dday);
            }
            String statusCode = dto.getStatus();
            if ("0".equals(statusCode)) {
                dto.setStatus("예정");
            } else if ("1".equals(statusCode)) {
                dto.setStatus("진행중");
            } else if ("2".equals(statusCode)) {
                dto.setStatus("종료");
            }
        }
        
        // 4. 계산이 다 끝난 리스트를 리턴!
        return list;
    }

	public int addTodo(TodoDTO dto) {
		
		if ("0".equals(dto.getEndtype()) || dto.getEnddate() == null || dto.getEnddate().equals("")) {
            dto.setEnddate(null);
        }
		
		return dao.addTodo(dto);
	}

	public TodoDTO getTodo(String seq) {
	    
	    // 1. DAO에서 데이터 가져오기
	    TodoDTO dto = dao.getTodo(seq);
	    
	    if (dto != null) {
	        // 🌟 날짜 가공 설정
	        LocalDate today = LocalDate.now();
	        DateTimeFormatter dbFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
	        DateTimeFormatter outFormatter = DateTimeFormatter.ofPattern("yyyy.MM.dd.");

	        // 퍼센트 계산을 위해 날짜 객체를 미리 선언
	        LocalDate startDate = null;
	        LocalDate endDate = null;

	        // 2. 시작일 가공
	        if (dto.getStartdate() != null) {
	            LocalDateTime startDT = LocalDateTime.parse(dto.getStartdate(), dbFormatter);
	            startDate = startDT.toLocalDate(); // 객체 저장
	            
	            // 화면용 텍스트로 변환
	            dto.setStartdate(startDate.format(outFormatter));
	            
	            // 진행일 계산
	            long progress = ChronoUnit.DAYS.between(startDate, today) + 1;
	            dto.setProgressDays(progress > 0 ? progress : -ChronoUnit.DAYS.between(today, startDate));
	        }

	        // 3. 종료일 가공 & 디데이 계산
	        if (dto.getEnddate() != null) {
	            LocalDateTime endDT = LocalDateTime.parse(dto.getEnddate(), dbFormatter);
	            endDate = endDT.toLocalDate(); // 객체 저장
	            
	            // 화면용 텍스트로 변환
	            dto.setEnddate(endDate.format(outFormatter));
	            
	            // 디데이 계산
	            long dday = ChronoUnit.DAYS.between(today, endDate);
	            dto.setDday(dday);
	        }

	        // 4. 진행 퍼센트(%) 계산 (시작일과 종료일이 모두 있을 때)
	        if (startDate != null && endDate != null) {
	            long totalDays = ChronoUnit.DAYS.between(startDate, endDate);
	            long passedDays = ChronoUnit.DAYS.between(startDate, today);

	            double percent = 0;
	            if (totalDays > 0) {
	                // (경과일 / 전체기간) * 100
	                percent = (double) passedDays / totalDays * 100;
	            } else if (totalDays == 0 && !today.isBefore(startDate)) {
	                // 당일치기 일정인데 오늘이거나 오늘 이후면 100%
	                percent = 100;
	            }

	            // 범위 제한 (0% ~ 100%)
	            if (percent < 0) percent = 0;
	            if (percent > 100) percent = 100;
	            
	            dto.setPercent((int) Math.round(percent)); // 반올림하여 정수로 저장
	        }
	        
	        // 5. 등록일 가공
	        if (dto.getRegdate() != null) {
	            LocalDateTime regDT = LocalDateTime.parse(dto.getRegdate(), dbFormatter);
	            dto.setRegdate(regDT.toLocalDate().format(outFormatter));
	        }

	        // 6. 상태값 가공 (예정/진행/종료)
	        String status = dto.getStatus();
	        if ("0".equals(status)) dto.setStatus("예정");
	        else if ("1".equals(status)) dto.setStatus("진행");
	        else if ("2".equals(status)) {
	            dto.setStatus("종료");
	            dto.setPercent(100); // 종료 상태면 퍼센트를 강제로 100으로 세팅
	        }
	    }

	    return dto;
	}

	// 특정 계획에 달린 학습 기록 목록 가져오기
    public List<RecordDTO> getHistoryList(String seq) {
        
        // DAO한테 일 시키기
        List<RecordDTO> list = dao.getHistoryList(seq);
        
        // 🌟 날짜 가공 (기록 날짜도 '2026.03.25.' 형식으로 예쁘게 바꾸기)
        for (RecordDTO rdto : list) {
            if (rdto.getStudydate() != null) {
                // DB에서 가져온 날짜 형식을 입맛에 맞게 가공 (예: yyyy-MM-dd -> yyyy.MM.dd.)
                String date = rdto.getStudydate().substring(0, 10).replace("-", ".");
                rdto.setStudydate(date);
            }
        }
        
        return list;
    }
}