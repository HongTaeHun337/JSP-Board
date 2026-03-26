package com.test.java;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.test.java.model.StudyDAO;
import com.test.java.model.StudyDTO;
import com.test.java.model.StudyMemberDTO;

@WebServlet("/studyEdit.do")
public class StudyEdit extends HttpServlet {

    // 🌟 화면 띄워주기
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String seq_study = req.getParameter("seq");
        
        StudyDAO dao = new StudyDAO();
        // 기존 정보 가져오기 (아까 쓰던 getStudy 메서드 재활용!)
        StudyDTO dto = dao.getStudy(seq_study);
        
        req.setAttribute("dto", dto);
        req.getRequestDispatcher("/WEB-INF/views/studyEdit.jsp").forward(req, resp);
    }

    // 🌟 수정한 거 DB에 덮어쓰기
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        // 1. 값 받기
        String seq_study = req.getParameter("seq_study");
        String title = req.getParameter("title");
        String studyType = req.getParameter("studyType");
        String max_population = req.getParameter("max_population");
        String location = req.getParameter("location");
        String content = req.getParameter("content");
        
        // 🌟 기술 스택은 배열로 넘어옴! (선택한 게 여러 개일 수 있으니까)
        String[] techArray = req.getParameterValues("techStacks[]");
        String tech = "";
        if (techArray != null) {
            tech = String.join(", ", techArray); // "Java, Spring Boot, MySQL" 이렇게 묶어줌!
        }

        // 2. 포장하기
        StudyDTO dto = new StudyDTO();
        dto.setSeq_study(seq_study);
        dto.setTitle(title);
        dto.setStudyType(studyType);
        dto.setMax_population(max_population);
        dto.setLocation(location);
        dto.setContent(content);
        dto.setTech(tech);

        // 3. 업데이트!
        StudyDAO dao = new StudyDAO();
        int result = dao.editStudyInfo(dto);

        if (result > 0) {
            // 성공하면 다시 관리 페이지 메인으로!
            resp.sendRedirect("manageStudy.do?seq=" + seq_study);
        } else {
            resp.setContentType("text/html; charset=UTF-8");
            PrintWriter writer = resp.getWriter();
            writer.print("<script>alert('수정에 실패했습니다.'); history.back();</script>");
            writer.close();
        }
    }
}