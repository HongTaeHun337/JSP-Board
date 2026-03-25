package com.test.java;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.test.java.model.RecordDTO;
import com.test.java.model.TodoDTO;
import com.test.java.model.TodoService;

@WebServlet("/view.do")
public class View extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String seq = req.getParameter("seq"); // 주소창의 ?seq=123 읽기
        
        TodoService service = new TodoService();
        TodoDTO dto = service.getTodo(seq); 
        
        List<RecordDTO> hlist = service.getHistoryList(seq);
        
        req.setAttribute("dto", dto);
        req.setAttribute("hlist", hlist);
        req.getRequestDispatcher("/WEB-INF/views/view.jsp").forward(req, resp);
    }
}