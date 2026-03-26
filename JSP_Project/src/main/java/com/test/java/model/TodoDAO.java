package com.test.java.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.test.library.BasicDao; // 이건 네가 만든 DB 연결용 부모 클래스 같네!

public class TodoDAO extends BasicDao {

	public List<TodoDTO> todolist(String userId) {
		
        // 1. 결과를 담을 빈 리스트 준비
        List<TodoDTO> list = new ArrayList<>(); 
        
		try {
            // 주의: SQL 끝에 세미콜론(;)은 뺐어!
			String sql = "SELECT "
					+ "    seq_plan, seq_user, title, topic, detail, "
					+ "    endtype, goal, "
					+ "    TO_CHAR(startdate, 'YYYY.MM.DD') AS startdate, "
					+ "    TO_CHAR(enddate, 'YYYY.MM.DD') AS enddate, "
					+ "    status "
					+ "FROM tbl_Plan "
					+ "WHERE seq_user = ? "
					+ "ORDER BY startdate DESC";
			
			pstat = conn.prepareStatement(sql);
            
            // 2. 쿼리의 첫 번째 '?' 자리에 userId(로그인 아이디) 넣어주기
            pstat.setString(1, userId); 
            
            // 3. 쿼리 실행 및 결과 받기
            rs = pstat.executeQuery();
            
            // 4. 결과가 있는 만큼 한 줄씩 반복하면서 꺼내기
            while (rs.next()) {
                TodoDTO dto = new TodoDTO(); // 빈 상자(DTO) 만들고
                
                // DB 컬럼에서 꺼내서 DTO에 예쁘게 포장
                dto.setSeq_plan(rs.getString("seq_plan"));
                dto.setSeq_user(rs.getString("seq_user"));
                dto.setTitle(rs.getString("title"));
                dto.setTopic(rs.getString("topic"));
                dto.setDetail(rs.getString("detail"));
                dto.setEndtype(rs.getString("endtype"));
                dto.setGoal(rs.getString("goal"));
                dto.setStartdate(rs.getString("startdate"));
                dto.setEnddate(rs.getString("enddate"));
                dto.setStatus(rs.getString("status"));
                
                // 포장된 DTO를 리스트에 쏙!
                list.add(dto); 
            }
            
            return list; // 5. 데이터가 꽉 찬 리스트를 서블릿으로 반환
		
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return null; // 에러 나면 null 반환
	}
	
		public int addTodo(TodoDTO dto) {
			
			try {
				// 🚨 주의: seq_plan.nextval 은 네 오라클 DB에 만들어둔 시퀀스 이름으로 맞춰야 해!
				// (보통 테이블명_seq.nextval 이나 seq_plan.nextval 을 많이 써)
				String sql = "INSERT INTO tbl_Plan (seq_plan, seq_user, title, topic, detail, endtype, goal, startdate, enddate, regdate, status) "
						   + "VALUES (seq_plan.nextval, ?, ?, ?, ?, ?, ?, TO_DATE(?, 'YYYY-MM-DD'), TO_DATE(?, 'YYYY-MM-DD'), sysdate, '0')";
				
				pstat = conn.prepareStatement(sql);
				
				// 물음표(?) 자리에 DTO에서 꺼낸 데이터 쏙쏙 넣기
				pstat.setString(1, dto.getSeq_user());
				pstat.setString(2, dto.getTitle());
				pstat.setString(3, dto.getTopic());
				pstat.setString(4, dto.getDetail());
				pstat.setString(5, dto.getEndtype());
				pstat.setString(6, dto.getGoal());
				pstat.setString(7, dto.getStartdate());
				
				pstat.setString(8, dto.getEnddate());
				
				return pstat.executeUpdate();
				
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			return 0; // 에러 나면 0 리턴
		}
		
		public TodoDTO getTodo(String seq) {
		    try {
		        String sql = "SELECT * FROM tbl_Plan WHERE seq_plan = ?";
		        pstat = conn.prepareStatement(sql);
		        pstat.setString(1, seq);
		        rs = pstat.executeQuery();

		        if (rs.next()) {
		            TodoDTO dto = new TodoDTO();
		            dto.setSeq_plan(rs.getString("seq_plan"));
		            dto.setSeq_user(rs.getString("seq_user"));
		            dto.setTitle(rs.getString("title"));
		            dto.setDetail(rs.getString("detail"));
		            dto.setGoal(rs.getString("goal"));
		            dto.setStartdate(rs.getString("startdate"));
		            dto.setEnddate(rs.getString("enddate"));
		            dto.setEndtype(rs.getString("endtype"));
		            dto.setStatus(rs.getString("status"));
		            dto.setRegdate(rs.getString("regdate"));
		            
		            return dto;
		        }
		    } catch (Exception e) {
		        e.printStackTrace();
		    }
		    return null;
		}
		
		// 🌟 1. 이 계획에 달린 학습 기록이 총 몇 개인지 세어오기
	    public int getHistoryCount(String seq) {
	        try {
	            String sql = "SELECT COUNT(*) FROM tbl_Plan_History WHERE seq_plan = ?";
	            pstat = conn.prepareStatement(sql);
	            pstat.setString(1, seq);
	            rs = pstat.executeQuery();
	            if (rs.next()) {
	                return rs.getInt(1);
	            }
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	        return 0;
	    }

	    // 🌟 2. 페이징 처리된 학습 기록 리스트 가져오기 (오라클 ROWNUM 방식)
	    public List<RecordDTO> getHistoryList(String seq, int begin, int end) {
	        List<RecordDTO> list = new ArrayList<>();
	        try {
	            // 서브쿼리로 최신순 정렬 먼저 하고, ROWNUM 붙여서, begin~end 만큼만 딱 자르기!
	            String sql = "SELECT * FROM ("
	                       + "    SELECT a.*, ROWNUM AS rnum FROM ("
	                       + "        SELECT * FROM tbl_Plan_History WHERE seq_plan = ? ORDER BY studydate DESC"
	                       + "    ) a"
	                       + ") WHERE rnum BETWEEN ? AND ?";
	            
	            pstat = conn.prepareStatement(sql);
	            pstat.setString(1, seq);
	            pstat.setInt(2, begin); // 시작 번호
	            pstat.setInt(3, end);   // 끝 번호
	            
	            rs = pstat.executeQuery();
	            
	            while (rs.next()) {
	                RecordDTO dto = new RecordDTO();
	                dto.setSeq_plan_history(rs.getString("seq_plan_history"));
	                dto.setSeq_plan(rs.getString("seq_plan"));
	                dto.setStudydate(rs.getString("studydate"));
	                dto.setDetail(rs.getString("detail"));
	                list.add(dto);
	            }
	            return list;
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	        return null;
	    }

		public int addHistory(RecordDTO dto) {
			try {
		        // 테이블명(tblPlanHistory)과 컬럼명은 실제 DB에 맞게 확인 필수!
				String sql = "INSERT INTO tbl_Plan_History (seq_plan_history, seq_plan, seq_user, studydate, detail) "
		                   + "VALUES (seq_Plan_History.nextVal, ?, ?, ?, ?)"; 

		        pstat = conn.prepareStatement(sql);
		        pstat.setString(1, dto.getSeq_plan());
		        pstat.setString(2, dto.getSeq_user()); 
		        pstat.setString(3, dto.getStudydate());
		        pstat.setString(4, dto.getDetail());

		        return pstat.executeUpdate(); // 성공하면 1 반환

		    } catch (Exception e) {
		        System.out.println("TodoDAO.addHistory 에러");
		        e.printStackTrace();
		    }
			return 0;
		}

		public int delHistory(String seq) {
			try {
		        // 🌟 테이블명(tblPlanHistory)과 컬럼명(seq_plan_history) 맞는지 확인!
		        String sql = "DELETE FROM tbl_Plan_History WHERE seq_plan_history = ?";

		        pstat = conn.prepareStatement(sql);
		        pstat.setString(1, seq);

		        return pstat.executeUpdate();

		    } catch (Exception e) {
		        System.out.println("TodoDAO.delHistory 에러");
		        e.printStackTrace();
		    }
			return 0;
		}

		public int delTodo(String seq) {
			try {
		        // 🌟 1. 이 계획에 달린 '학습 기록(자식)'들 먼저 싹 다 지우기!
		        String sql1 = "DELETE FROM tbl_Plan_History WHERE seq_plan = ?";
		        pstat = conn.prepareStatement(sql1);
		        pstat.setString(1, seq);
		        pstat.executeUpdate(); // 기록이 없으면 0건 지웠다고 치고 쿨하게 넘어감
		        
		        // 🌟 2. 이제 진짜 본체인 '학습 계획(부모)' 지우기!
		        String sql2 = "DELETE FROM tbl_Plan WHERE seq_plan = ?";
		        pstat = conn.prepareStatement(sql2);
		        pstat.setString(1, seq);
		        
		        return pstat.executeUpdate(); // 찐 본체를 지운 결과를 서블릿으로 반환

		    } catch (Exception e) {
		        System.out.println("TodoDAO.delTodo 에러");
		        e.printStackTrace();
		    }
			return 0;
		}

		public int editTodo(TodoDTO dto) {
			try {
		        // 🌟 UPDATE 쿼리: 입력받은 값으로 싹 다 덮어쓰기! (WHERE 조건 빼먹으면 대참사 남!)
		        String sql = "UPDATE tbl_Plan "
		                   + "SET title = ?, detail = ?, goal = ?, endtype = ?, "
		                   + "startdate = TO_DATE(?, 'YYYY-MM-DD'), enddate = TO_DATE(?, 'YYYY-MM-DD') "
		                   + "WHERE seq_plan = ?";

		        pstat = conn.prepareStatement(sql);
		        pstat.setString(1, dto.getTitle());
		        pstat.setString(2, dto.getDetail());
		        pstat.setString(3, dto.getGoal());
		        pstat.setString(4, dto.getEndtype());
		        pstat.setString(5, dto.getStartdate());
		        pstat.setString(6, dto.getEnddate());
		        pstat.setString(7, dto.getSeq_plan()); // 마지막 7번째 물음표가 글 번호!

		        return pstat.executeUpdate();

		    } catch (Exception e) {
		        System.out.println("TodoDAO.editTodo 에러");
		        e.printStackTrace();
		    }
			return 0;
		}

}