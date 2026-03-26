package com.test.java;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession; // 👈 세션 쓰려면 이거 임포트 필수!

import com.test.java.model.RecordDTO; 
import com.test.java.model.TodoService;

@WebServlet("/historyAdd.do")
public class HistoryAdd extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        
        // 1. 한글 깨짐 방지
        req.setCharacterEncoding("UTF-8");

        // 🌟 2. 세션에서 로그인 정보(seq_user) 꺼내기 (테스트용 강제 세팅 포함)
        HttpSession session = req.getSession();
        
        // 아직 로그인 기능이 없으니, 세션이 비어있으면 강제로 '1'번 사용자로 세팅해줄게!
        // (주의: DB의 회원 테이블에 seq_user가 '1'인 사람이 실제로 있어야 에러가 안 나!)
        if (session.getAttribute("seq_user") == null) {
            session.setAttribute("seq_user", "3"); 
        }
        
        // 이제 안전하게 내 번호를 꺼낼 수 있어
        String seq_user = (String) session.getAttribute("seq_user");

        // 3. 폼에서 넘어온 데이터 꺼내기 (여기서 seq_user는 빼야 해!)
        String seq_plan = req.getParameter("seq_plan");
        String studydate = req.getParameter("studydate");
        String detail = req.getParameter("detail");

        // 4. DTO에 예쁘게 담기
        RecordDTO dto = new RecordDTO();
        dto.setSeq_plan(seq_plan);
        dto.setStudydate(studydate);
        dto.setDetail(detail);
        dto.setSeq_user(seq_user); // 세션에서 꺼낸 진짜 내 번호를 담아줌!

        // 5. Service에게 DB 저장 심부름 시키기
        TodoService service = new TodoService();
        int result = service.addHistory(dto);
        
        // 6. 결과에 따른 화면 이동
        if (result == 1) {
            // 성공하면 방금 보던 그 상세 페이지로 다시 돌아가기! 
            resp.sendRedirect("view.do?seq=" + seq_plan);
        } else {
            // 실패하면 경고창 띄우고 이전 페이지로
            resp.setContentType("text/html; charset=UTF-8");
            PrintWriter writer = resp.getWriter();
            writer.print("<script>alert('기록 추가에 실패했습니다.'); history.back();</script>");
            writer.close();
        }
    }
}