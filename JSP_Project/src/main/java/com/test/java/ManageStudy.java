package com.test.java;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.test.java.model.StudyDAO;
import com.test.java.model.StudyDTO;

@WebServlet("/manageStudy.do")
public class ManageStudy extends HttpServlet {

	@Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        
        // 🌟 1. if문 날려버리고 무조건 9번으로 강제 덮어쓰기! (테스트 끝나면 지워야 해)
        HttpSession session = req.getSession();
        session.setAttribute("seq_user", "9"); 
        
        String seqUser = (String) session.getAttribute("seq_user");

        // 2. DB에서 내가 방장인 스터디 목록 가져오기
        StudyDAO dao = new StudyDAO();
        List<StudyDTO> studyList = dao.getManageStudyList(seqUser);
        

        // 3. JSP한테 데이터 넘겨주기
        req.setAttribute("studyList", studyList);

        // 4. JSP 화면 띄우기
        req.getRequestDispatcher("/WEB-INF/views/manageStudy.jsp").forward(req, resp);
    }
}