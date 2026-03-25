package com.test.java;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.test.java.model.TodoService; // DAO 대신 Service 임포트!
import com.test.java.model.TodoDTO;

@WebServlet(value = "/index.do")
public class Index extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	    
	    HttpSession session = req.getSession();
	    
	    // 🚨 [테스트용] 강제로 세션에 로그인 정보 박아넣기! (나중에 진짜 로그인 만들면 꼭 지워야 해)
	    session.setAttribute("id", "user07afe8b9");
	    session.setAttribute("seq_user", "3"); 
	    
	    // 1. 세션에서 유저 번호(seq_user) 꺼내기
	    // (네 DAO 쿼리가 WHERE seq_user = ? 니까, 아이디 대신 번호를 꺼내서 넘겨야 해!)
	    String seqUser = (String) session.getAttribute("seq_user"); 

	    /* 원래 있던 로그인 체크 로직은 테스트를 위해 잠시 주석 처리할게!
	    if (seqUser == null) {
	        resp.sendRedirect("/login.do");
	        return;
	    }
	    */

	    // 2. Service 호출 (유저 번호 '1'을 넘겨줌)
	    TodoService service = new TodoService();
	    List<TodoDTO> list = service.getTodoList(seqUser); 
	    req.setAttribute("todolist", list);

	    // 4. JSP 화면 띄우기
	    req.getRequestDispatcher("/WEB-INF/views/index.jsp").forward(req, resp);
	}
}