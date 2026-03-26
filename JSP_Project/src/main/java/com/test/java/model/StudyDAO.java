package com.test.java.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import com.test.library.BasicDao; // 너의 DB 연결 부모 클래스!

public class StudyDAO extends BasicDao {

	public List<StudyDTO> getManageStudyList(String seq_user) {
	    
	    List<StudyDTO> list = new ArrayList<>();
	    
	    try {
	        // 🌟 JOIN 쿼리로 변경!
	    	// StudyDAO.java의 쿼리 수정!
	    	String sql = "SELECT s.seq_study, s.title, s.population, s.max_population, "
	    	           + "TO_CHAR(s.regdate, 'YYYY.MM.DD') AS regdate, s.status "
	    	           + "FROM tbl_Study s "
	    	           + "INNER JOIN tbl_Study_Join j ON s.seq_study = j.seq_study "
	    	           + "WHERE j.seq_user = ? AND j.authority = 1 "
	    	           + "ORDER BY s.seq_study DESC";
	        
	        pstat = conn.prepareStatement(sql);
	        pstat.setString(1, seq_user); // 서블릿에서 넘겨준 "9"가 들어감
	        
	        rs = pstat.executeQuery();
	        
	        while (rs.next()) {
	            StudyDTO dto = new StudyDTO();
	            // DTO 담는 코드는 기존과 동일!
	            dto.setSeq_study(rs.getString("seq_study"));
	            dto.setTitle(rs.getString("title"));
	            dto.setPopulation(rs.getString("population"));
	            dto.setMax_population(rs.getString("max_population"));
	            
	            // 만약 Study 테이블의 regdate를 쓰고 싶다면 아래처럼
	            dto.setRegdate(rs.getString("regdate")); 
	            dto.setStatus(rs.getString("status"));
	            
	            list.add(dto);
	        }
	        return list;
	        
	    } catch (Exception e) {
	        System.out.println("StudyDAO.getManageStudyList 에러");
	        e.printStackTrace();
	    }
	    return null;
	}
	
	// 🌟 1. 스터디 기본 정보 가져오기 (상단에 제목, 인원 표시용)
    public StudyDTO getStudy(String seq_study) {
        try {
        	String sql = "SELECT s.*, "
                    + "(SELECT COUNT(*) FROM tbl_Study_Join WHERE seq_study = s.seq_study AND status = 1) AS now_count "
                    + "FROM tbl_Study s WHERE s.seq_study = ?";
            pstat = conn.prepareStatement(sql);
            pstat.setString(1, seq_study);
            rs = pstat.executeQuery();

            if (rs.next()) {
                StudyDTO dto = new StudyDTO();
                dto.setSeq_study(rs.getString("seq_study"));
                dto.setTitle(rs.getString("title"));
                dto.setPopulation(rs.getString("population"));
                dto.setMax_population(rs.getString("max_population"));
                dto.setPopulation(rs.getString("now_count"));
                dto.setStudyType(rs.getString("studyType")); // 진행방식
                dto.setLocation(rs.getString("location"));   // 장소
                dto.setContent(rs.getString("content"));     // 상세내용
                return dto;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // 🌟 2. 상태(대기/참여)에 따른 멤버 목록 가져오기
    public List<StudyMemberDTO> getStudyMemberList(String seq_study, String status) {
        List<StudyMemberDTO> list = new ArrayList<>();
        try {
            // tbl_Study_Join이랑 tbl_User를 조인해서 '닉네임'을 빼오는 게 핵심!
            // 방장(authority=1)이 항상 맨 위에 오게 정렬(ORDER BY) 해둠!
            String sql = "SELECT j.*, u.nickname AS userName "
                       + "FROM tbl_Study_Join j "
                       + "INNER JOIN tbl_User u ON j.seq_user = u.seq_user "
                       + "WHERE j.seq_study = ? AND j.status = ? "
                       + "ORDER BY j.authority DESC, j.regdate ASC";
            
            pstat = conn.prepareStatement(sql);
            pstat.setString(1, seq_study);
            pstat.setString(2, status); // 서블릿에서 '0'(대기) 또는 '1'(참여)을 넣어줄 거임
            
            rs = pstat.executeQuery();
            
            while (rs.next()) {
                StudyMemberDTO dto = new StudyMemberDTO();
                dto.setSeq_study_join(rs.getString("seq_study_join"));
                dto.setSeq_study(rs.getString("seq_study"));
                dto.setSeq_user(rs.getString("seq_user"));
                
                // 날짜 예쁘게 자르기 (2026-03-20 14:15:44 -> 2026-03-20)
                String date = rs.getString("regdate");
                if (date != null && date.length() > 10) date = date.substring(0, 10);
                dto.setRegdate(date);
                
                dto.setStatus(rs.getString("status"));
                dto.setAuthority(rs.getString("authority"));
                dto.setUserName(rs.getString("userName")); // 조인해온 닉네임 쏙!
                
                list.add(dto);
            }
            return list;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    
 // 🌟 1. 가입 승인 (status를 1로 변경)
    public int approveMember(String joinSeq) {
        try {
            String sql = "UPDATE tbl_Study_Join SET status = 1 WHERE seq_study_join = ?";
            pstat = conn.prepareStatement(sql);
            pstat.setString(1, joinSeq);
            
            return pstat.executeUpdate(); // 성공하면 1 반환
        } catch (Exception e) {
            System.out.println("StudyDAO.approveMember 에러");
            e.printStackTrace();
        }
        return 0;
    }

    // 🌟 2. 가입 거절 & 강퇴 (테이블에서 아예 삭제)
    public int removeMember(String joinSeq) {
        try {
            String sql = "DELETE FROM tbl_Study_Join WHERE seq_study_join = ?";
            pstat = conn.prepareStatement(sql);
            pstat.setString(1, joinSeq);
            
            return pstat.executeUpdate(); // 성공하면 1 반환
        } catch (Exception e) {
            System.out.println("StudyDAO.removeMember 에러");
            e.printStackTrace();
        }
        return 0;
    }
    
 // 🌟 1. 특정 스터디의 일정 목록 가져오기 (이거 빠졌었음!)
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
                dto.setDetail(rs.getString("detail")); 
                
                // 날짜와 시간 쪼개기 마술!
                String startStr = rs.getString("startperiod");
                if (startStr != null && startStr.length() >= 16) {
                    dto.setScheduleDate(startStr.substring(0, 10)); // "2026-03-25"
                    dto.setScheduleTime(startStr.substring(11, 16)); // "20:00"
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

    // 🌟 2. 스터디 새 일정 등록하기 (이것도 빠졌었음!)
    public int addStudySchedule(StudyScheduleDTO dto) {
        try {
            // 💡 scheduleDate 와 scheduleTime 을 공백으로 이어붙여서 오라클 TO_DATE 로 쏙!
            // 🚨 주의: seq_study_day.nextVal 부분은 본인 DB의 시퀀스 이름으로 맞춰야 함!
        	String sql = "INSERT INTO tbl_Study_day (seq_study_day, seq_study, title, startperiod, detail, topic, regdate) "
                    + "VALUES (seq_study_day.nextVal, ?, ?, TO_DATE(?, 'YYYY-MM-DD HH24:MI'), ?, ?, sysdate)";
            
            pstat = conn.prepareStatement(sql);
            pstat.setString(1, dto.getSeq_study());
            pstat.setString(2, dto.getTitle());
            pstat.setString(3, dto.getScheduleDate() + " " + dto.getScheduleTime()); // 🌟 날짜+시간 합체!
            pstat.setString(4, dto.getDetail()); // 장소를 detail에 저장
            pstat.setString(5, dto.getTopic());
            
            return pstat.executeUpdate(); 
        } catch (Exception e) {
            System.out.println("StudyDAO.addStudySchedule 에러");
            e.printStackTrace();
        }
        return 0;
    }
    
 // 🌟 스터디 일정 삭제하기 (DELETE)
    public int deleteStudySchedule(String seq_schedule) {
        try {
            // PK(고유번호)인 seq_study_day로 딱 그 일정만 날려버리기!
            String sql = "DELETE FROM tbl_Study_day WHERE seq_study_day = ?";
            
            pstat = conn.prepareStatement(sql);
            pstat.setString(1, seq_schedule);
            
            return pstat.executeUpdate(); // 성공하면 1 반환
            
        } catch (Exception e) {
            System.out.println("StudyDAO.deleteStudySchedule 에러");
            e.printStackTrace();
        }
        return 0;
    }
    
 // 🌟 특정 일정 1개 데이터만 쏙 가져오기 (수정 폼에 뿌려줄 용도)
    public StudyScheduleDTO getStudySchedule(String seq_schedule) {
        try {
            String sql = "SELECT * FROM tbl_Study_day WHERE seq_study_day = ?";
            pstat = conn.prepareStatement(sql);
            pstat.setString(1, seq_schedule);
            rs = pstat.executeQuery();

            if (rs.next()) {
                StudyScheduleDTO dto = new StudyScheduleDTO();
                dto.setSeq_study_day(rs.getString("seq_study_day"));
                dto.setSeq_study(rs.getString("seq_study"));
                dto.setTitle(rs.getString("title"));
                dto.setTopic(rs.getString("topic"));
                dto.setDetail(rs.getString("detail"));

                // 날짜/시간 분리
                String startStr = rs.getString("startperiod");
                if (startStr != null && startStr.length() >= 16) {
                    dto.setScheduleDate(startStr.substring(0, 10)); // "2026-03-25"
                    dto.setScheduleTime(startStr.substring(11, 16)); // "20:00"
                }
                return dto;
            }
        } catch (Exception e) {
            System.out.println("StudyDAO.getStudySchedule 에러");
            e.printStackTrace();
        }
        return null;
    }

    // 🌟 스터디 일정 수정(UPDATE) 하기
    public int editStudySchedule(StudyScheduleDTO dto) {
        try {
            // 💡 fixdate(수정일) 컬럼도 sysdate로 업데이트 해줄게!
            String sql = "UPDATE tbl_Study_day "
                       + "SET title = ?, startperiod = TO_DATE(?, 'YYYY-MM-DD HH24:MI'), detail = ?, topic = ?, fixdate = sysdate "
                       + "WHERE seq_study_day = ?";
            
            pstat = conn.prepareStatement(sql);
            pstat.setString(1, dto.getTitle());
            pstat.setString(2, dto.getScheduleDate() + " " + dto.getScheduleTime());
            pstat.setString(3, dto.getDetail());
            pstat.setString(4, dto.getTopic());
            pstat.setString(5, dto.getSeq_study_day()); // 조건(WHERE): 이 일정 번호만!

            return pstat.executeUpdate();
        } catch (Exception e) {
            System.out.println("StudyDAO.editStudySchedule 에러");
            e.printStackTrace();
        }
        return 0;
    }
    
 // 🌟 스터디 메인 정보 수정하기 (UPDATE)
    public int editStudyInfo(StudyDTO dto) {
        try {
            // DB 테이블 컬럼명(studyType, location, content, tech 등)은 네 ERD에 맞게 살짝 수정해야 할 수 있어!
            String sql = "UPDATE tbl_Study SET title = ?, max_population = ?, studyType = ?, location = ?, tech = ?, content = ? WHERE seq_study = ?";
            
            pstat = conn.prepareStatement(sql);
            pstat.setString(1, dto.getTitle());
            pstat.setString(2, dto.getMax_population());
            pstat.setString(3, dto.getStudyType());
            pstat.setString(4, dto.getLocation());
            pstat.setString(5, dto.getTech()); // "Java, Spring Boot" 형태로 저장
            pstat.setString(6, dto.getContent());
            pstat.setString(7, dto.getSeq_study());

            return pstat.executeUpdate(); // 성공하면 1
        } catch (Exception e) {
            System.out.println("StudyDAO.editStudyInfo 에러");
            e.printStackTrace();
        }
        return 0;
    }
    
}