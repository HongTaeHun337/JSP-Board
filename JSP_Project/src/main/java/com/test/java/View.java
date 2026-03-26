package com.test.java;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.test.java.model.RecordDTO;
import com.test.java.model.TodoDTO;
import com.test.java.model.TodoService;

@WebServlet("/view.do")
public class View extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    	
    	// View.java의 doGet() 시작 부분
    	HttpSession session = req.getSession();
    	// 🌟 테스트용: 나는 지금 1번 유저고, 일반 권한('1')이라고 서버에 최면 걸기!
    	session.setAttribute("seq_user", "3"); // (본인 DB에 있는 진짜 번호로 넣어!)
    	
        String seq = req.getParameter("seq"); // 주소창의 ?seq=123 읽기
        
        TodoService service = new TodoService();
        TodoDTO dto = service.getTodo(seq); 

        // 🌟 페이징 처리 변수 준비
        int nowPage = 1;     // 현재 페이지 번호
        int pageSize = 5;    // 한 페이지에 보여줄 기록 개수 (5개씩!)
        int blockSize = 5;   // 페이지 버튼 블럭 개수 (1 2 3 4 5)
        
        // 주소창에서 ?page=2 처럼 페이지 번호가 넘어오면 그거 쓰고, 없으면 1페이지
        String pageParam = req.getParameter("page");
        if (pageParam != null && !pageParam.equals("")) {
            nowPage = Integer.parseInt(pageParam);
        }
        
        // 어디서부터 어디까지 가져올지 계산 (예: 1페이지는 1~5, 2페이지는 6~10)
        int begin = ((nowPage - 1) * pageSize) + 1;
        int end = begin + pageSize - 1;

        // DB에서 총 개수랑, 잘라낸 리스트 가져오기
        int totalCount = service.getHistoryCount(seq);
        int totalPage = (int) Math.ceil((double) totalCount / pageSize);
        
        List<RecordDTO> hlist = service.getHistoryList(seq, begin, end);
        // 🌟 예쁜 페이지 버튼(HTML) 만들기
        StringBuilder pagebar = new StringBuilder();
        pagebar.append("<div style='text-align:center; margin-top:20px; font-weight:bold;'>");
        
        int loop = 1; // 루프 변수
        int n = ((nowPage - 1) / blockSize) * blockSize + 1; // 페이지 블럭 시작 번호

        // [이전] 버튼
        if (n == 1) {
            pagebar.append("<span style='color:#ccc; padding:5px;'>[이전]</span> ");
        } else {
            pagebar.append(String.format("<a href='view.do?seq=%s&page=%d' style='padding:5px;'>[이전]</a> ", seq, n - 1));
        }

        // 페이지 번호들 (1 2 3 4 5)
        while (!(loop > blockSize || n > totalPage)) {
            if (n == nowPage) {
                pagebar.append(String.format("<span style='color:#0d6efd; padding:5px;'>%d</span> ", n)); // 현재 페이지 파란색
            } else {
                pagebar.append(String.format("<a href='view.do?seq=%s&page=%d' style='padding:5px;'>%d</a> ", seq, n, n));
            }
            loop++;
            n++;
        }

        // [다음] 버튼
        if (n > totalPage) {
            pagebar.append("<span style='color:#ccc; padding:5px;'>[다음]</span>");
        } else {
            pagebar.append(String.format("<a href='view.do?seq=%s&page=%d' style='padding:5px;'>[다음]</a>", seq, n));
        }
        pagebar.append("</div>");

        // JSP로 데이터 넘기기
        req.setAttribute("dto", dto);
        req.setAttribute("hlist", hlist);
        req.setAttribute("pagebar", pagebar.toString()); // 🌟 만들어진 페이지 버튼 HTML을 넘김
        
        // ... (이후 forward 코드) ...
        
        req.getRequestDispatcher("/WEB-INF/views/view.jsp").forward(req, resp);
    }
}