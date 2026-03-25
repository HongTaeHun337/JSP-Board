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
		
		public List<RecordDTO> getHistoryList(String seq) {
	        
	        try {
	            // 최신순으로 정렬해서 가져오기
	            String sql = "SELECT * FROM tbl_Plan_History WHERE seq_plan = ? ORDER BY studydate DESC";
	            
	            pstat = conn.prepareStatement(sql);
	            pstat.setString(1, seq);
	            
	            rs = pstat.executeQuery();
	            
	            List<RecordDTO> list = new ArrayList<>();
	            
	            while (rs.next()) {
	                RecordDTO dto = new RecordDTO();
	                dto.setSeq_plan_history(rs.getString("seq_plan_history"));
	                dto.setStudydate(rs.getString("studydate"));
	                dto.setDetail(rs.getString("detail"));
	                // 필요한 컬럼들(memo 등) 쭉쭉 담기...
	                
	                list.add(dto);
	            }
	            return list;
	            
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	        return null;
	    }

}