package com.test.java.model;

import java.util.ArrayList;
import java.util.List;

import com.test.library.BasicDao;

public class StudyScheduleDAO extends BasicDao {
	
	// 🌟 특정 스터디의 일정 목록 가져오기
    public List<StudyScheduleDTO> getStudyScheduleList(String seq_study) {
        
        List<StudyScheduleDTO> list = new ArrayList<>();
        
        try {
            // 다가오는 일정이 먼저 보이게 startperiod 기준 오름차순(ASC) 정렬
            String sql = "SELECT * FROM tbl_Study_day WHERE seq_study = ? ORDER BY startperiod ASC";
            pstat = conn.prepareStatement(sql);
            pstat.setString(1, seq_study);
            rs = pstat.executeQuery();
            
            while (rs.next()) {
                StudyScheduleDTO dto = new StudyScheduleDTO();
                dto.setSeq_study_day(rs.getString("seq_study_day"));
                dto.setSeq_study(rs.getString("seq_study"));
                dto.setTitle(rs.getString("title"));
                dto.setTopic(rs.getString("topic"));
                dto.setDetail(rs.getString("detail")); // 장소 데이터가 여기 들어감
                
                // 🌟 날짜와 시간 쪼개기 마술! (예: "2026-03-25 20:00:00" 형태라면)
                String startStr = rs.getString("startperiod");
                if (startStr != null && startStr.length() >= 16) {
                    dto.setScheduleDate(startStr.substring(0, 10)); // "2026-03-25"만 쏙!
                    dto.setScheduleTime(startStr.substring(11, 16)); // "20:00"만 쏙!
                }
                
                list.add(dto);
            }
            return list;
            
        } catch (Exception e) {
            System.out.println("StudyDAO.getStudyScheduleList 에러");
            e.printStackTrace();
        }
        return null;
    }
    
 // 🌟 스터디 새 일정 등록하기 (INSERT)
    public int addStudySchedule(StudyScheduleDTO dto) {
        try {
            // 💡 포인트: scheduleDate 와 scheduleTime 을 공백으로 이어붙여서 오라클 TO_DATE 로 쏙!
            // 예: "2026-03-25" + " " + "20:00" -> "2026-03-25 20:00"
        	String sql = "INSERT INTO tbl_Study_day (seq_study_day, seq_study, title, startperiod, detail, topic, regdate) "
                    + "VALUES (seq_study_day.nextVal, ?, ?, TO_DATE(?, 'YYYY-MM-DD HH24:MI'), ?, ?, sysdate)";
         
         pstat = conn.prepareStatement(sql);
         pstat.setString(1, dto.getSeq_study());
         pstat.setString(2, dto.getTitle());
         pstat.setString(3, dto.getScheduleDate() + " " + dto.getScheduleTime()); 
         pstat.setString(4, dto.getDetail()); // 장소 (detail)
         
         // 🌟 새로 추가: 5번째 물음표에 설명(topic) 넣기!
         pstat.setString(5, dto.getTopic());
            
            return pstat.executeUpdate(); // 성공하면 1 반환
            
        } catch (Exception e) {
            System.out.println("StudyDAO.addStudySchedule 에러");
            e.printStackTrace();
        }
        return 0;
    }

}
