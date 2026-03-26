package com.test.java;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.test.java.model.TodoService;

@WebServlet("/delete.do")
public class Delete extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        
        // 1. 주소창에서 넘어온 지울 글 번호 받기
        String seq = req.getParameter("seq");

        // 2. 서비스한테 지워달라고 넘기기
        TodoService service = new TodoService();
        int result = service.delTodo(seq);

        // 3. 결과에 따른 이동
        if (result > 0) {
            // 삭제 성공하면 시원하게 메인 목록으로 돌아가기
            resp.sendRedirect("index.do");
        } else {
            // 실패하면 뒤로 가기
            resp.setContentType("text/html; charset=UTF-8");
            PrintWriter writer = resp.getWriter();
            writer.print("<script>alert('게시글 삭제에 실패했습니다.'); history.back();</script>");
            writer.close();
        }
    }
}