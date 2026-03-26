package com.test.java;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.test.java.model.TodoService;

@WebServlet("/historyDel.do")
public class HistoryDel extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        
        // 1. 주소창에서 넘어온 데이터 꺼내기
        String seq = req.getParameter("seq");   // 지울 기록 번호
        String pseq = req.getParameter("pseq"); // 지우고 돌아갈 상세페이지 번호

        // 2. Service에게 삭제 심부름 시키기
        TodoService service = new TodoService();
        int result = service.delHistory(seq);

        // 3. 결과에 따른 화면 이동
        if (result == 1) {
            // 삭제 성공하면 원래 보던 상세 페이지로 돌아가기
            resp.sendRedirect("view.do?seq=" + pseq);
        } else {
            // 실패하면 경고창
            resp.setContentType("text/html; charset=UTF-8");
            PrintWriter writer = resp.getWriter();
            writer.print("<script>alert('삭제에 실패했습니다.'); history.back();</script>");
            writer.close();
        }
    }
}