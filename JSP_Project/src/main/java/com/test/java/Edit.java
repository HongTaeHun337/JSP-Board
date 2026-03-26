package com.test.java;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.test.java.model.TodoDTO;
import com.test.java.model.TodoService;

@WebServlet("/edit.do")
public class Edit extends HttpServlet {

	@Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        
        String seq = req.getParameter("seq");

        TodoService service = new TodoService();
        TodoDTO dto = service.getTodo(seq); 

        // 🌟🌟 3. 보안 체크 전, 임시 로그인 세팅! (나중에 찐 로그인 붙이면 지울 부분) 🌟🌟
        HttpSession session = req.getSession();
        if (session.getAttribute("seq_user") == null) {
            session.setAttribute("seq_user", "3"); // 👈 3번으로 통일!
        }
        
        String loginSeq = (String) session.getAttribute("seq_user");

        // 이제 에러 안 나고 무사 통과할 거야!
        if (loginSeq == null || !loginSeq.equals(dto.getSeq_user())) {
            resp.setContentType("text/html; charset=UTF-8");
            PrintWriter writer = resp.getWriter();
            writer.print("<script>alert('수정 권한이 없습니다!'); history.back();</script>");
            writer.close();
            return; 
        }

        // 검사 통과하면 정상적으로 수정 화면 보여주기
        req.setAttribute("dto", dto);
        req.getRequestDispatcher("/WEB-INF/views/edit.jsp").forward(req, resp);
    }

    // 🌟 2. 수정한 데이터 받아서 DB 덮어쓰기
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        
        req.setCharacterEncoding("UTF-8"); // 한글 깨짐 방지!

        // 폼에서 넘어온 수정된 데이터들 꺼내기
        String seq_plan = req.getParameter("seq_plan"); // 🌟 어떤 글을 수정할지 알아야 하니까 필수!
        String title = req.getParameter("title");
        String detail = req.getParameter("detail");
        String endtype = req.getParameter("endtype");
        String goal = req.getParameter("goal");
        String startdate = req.getParameter("startdate");
        String enddate = req.getParameter("enddate");

        // DTO에 예쁘게 포장
        TodoDTO dto = new TodoDTO();
        dto.setSeq_plan(seq_plan);
        dto.setTitle(title);
        dto.setDetail(detail);
        dto.setEndtype(endtype);
        dto.setGoal(goal);
        dto.setStartdate(startdate);
        dto.setEnddate(enddate);

        // Service로 넘기기
        TodoService service = new TodoService();
        int result = service.editTodo(dto);

        if (result > 0) {
            // 수정 성공하면 수정한 그 글의 상세페이지로 쿨하게 이동!
            resp.sendRedirect("view.do?seq=" + seq_plan);
        } else {
            // 실패 시 뒤로 가기
            resp.setContentType("text/html; charset=UTF-8");
            PrintWriter writer = resp.getWriter();
            writer.print("<script>alert('수정에 실패했습니다.'); history.back();</script>");
            writer.close();
        }
    }
}