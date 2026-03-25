package com.test.java;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.test.java.model.TodoDTO;
import com.test.java.model.TodoService;

@WebServlet(value = "/create.do")
public class Create extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		HttpSession session = req.getSession();
		// 🚨 아까 테스트용으로 쓰던 seq_user 가져오기 (나중에 실제 로그인 연동하면 바꿀 부분!)
		String seqUser = (String) session.getAttribute("seq_user"); 
		
		// JSP로 이동
		req.getRequestDispatcher("/WEB-INF/views/create.jsp").forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		
		// 🚨 제일 중요! POST로 넘어올 때 한글 깨지지 않게 인코딩 설정 (무조건 맨 위에!)
	    req.setCharacterEncoding("UTF-8");
	    
	    // 1) 세션에서 작성자(로그인한 유저) 번호 가져오기
	    HttpSession session = req.getSession();
	    String seqUser = (String) session.getAttribute("seq_user");
	    
	    // 2) 폼에서 사용자가 입력한 데이터들 꺼내기 (name 속성 값과 동일해야 함!)
	    String endtype = req.getParameter("endtype");     // 1:기간형, 0:목표형
	    String title = req.getParameter("title");         // 계획명
	    String startdate = req.getParameter("startdate"); // 시작일
	    String enddate = req.getParameter("enddate");     // 종료일 (목표형이면 null이거나 빈 문자열)
	    String goal = req.getParameter("goal");           // 목표
	    String detail = req.getParameter("detail");       // 상세설명
	    String topic = req.getParameter("topic");         // 주제(기본값)
	    
	    // 3) 꺼낸 데이터들을 잃어버리지 않게 DTO 상자에 예쁘게 포장하기
	    TodoDTO dto = new TodoDTO();
	    dto.setSeq_user(seqUser);
	    dto.setEndtype(endtype);
	    dto.setTitle(title);
	    dto.setStartdate(startdate);
	    dto.setEnddate(enddate);
	    dto.setGoal(goal);
	    dto.setDetail(detail);
	    dto.setTopic(topic);
	    
	    // 4) Service한테 이 DTO 던져주면서 "DB에 INSERT 해줘!" 라고 부탁하기
	    TodoService service = new TodoService();
	    int result = service.addTodo(dto); // (🌟 이 addTodo 메서드는 우리가 이제 만들어야 해!)
	    
	    // 5) INSERT 성공/실패에 따라 화면 이동시키기
	    if (result > 0) {
	        // 성공하면 내가 쓴 글이 잘 등록됐는지 보러 메인 목록으로 이동!
	        resp.sendRedirect("index.do");
	    } else {
	        // 실패하면 다시 글쓰기 화면으로 돌려보내기
	        resp.sendRedirect("create.do");
	    }
	}
		
}
	