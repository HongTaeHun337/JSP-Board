package com.test.java;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.test.java.model.StudyDAO;

@WebServlet("/studyScheduleDelete.do")
public class StudyScheduleDelete extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        
        // 1. 주소창에서 넘어온 단서 2개 받기
        String seq_schedule = req.getParameter("seq_schedule"); // 지울 일정 번호
        String seq_study = req.getParameter("seq_study");       // 돌아갈 스터디 번호
        
        // 2. DAO 시켜서 싹둑 자르기 ✂️
        StudyDAO dao = new StudyDAO();
        int result = dao.deleteStudySchedule(seq_schedule);
        
        // 3. 결과 처리
        if (result > 0) {
            // 🌟 성공 시: 방금 보던 그 스터디의 일정 목록으로 새로고침! (목록에서 짠 하고 사라짐)
            resp.sendRedirect("studyScheduleManage.do?seq=" + seq_study);
        } else {
            // ❌ 실패 시: 에러 팝업
            resp.setContentType("text/html; charset=UTF-8");
            PrintWriter writer = resp.getWriter();
            writer.print("<script>alert('일정 삭제에 실패했습니다.'); history.back();</script>");
            writer.close();
        }
    }
}