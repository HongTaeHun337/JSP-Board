package com.test.java;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.test.java.model.StudyDAO;
import com.test.java.model.StudyScheduleDTO;

@WebServlet("/studyScheduleEdit.do")
public class StudyScheduleEdit extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        
        // 1. 주소창에서 넘어온 번호 받기
        String seq_schedule = req.getParameter("seq_schedule");
        String seq_study = req.getParameter("seq_study"); // 나중에 되돌아갈 목적지용
        
        // 2. DAO 시켜서 기존 데이터 꺼내오기
        StudyDAO dao = new StudyDAO();
        StudyScheduleDTO dto = dao.getStudySchedule(seq_schedule);
        
        // 3. JSP에 데이터 쥐여주기
        req.setAttribute("dto", dto);
        req.setAttribute("seq_study", seq_study);
        
        // 4. 수정 전용 화면(JSP)으로 이동!
        req.getRequestDispatcher("/WEB-INF/views/studyScheduleEdit.jsp").forward(req, resp);
    }
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        
        req.setCharacterEncoding("UTF-8");

        // 1. 폼에서 넘어온 데이터 싹 받기
        String seq_schedule = req.getParameter("seq_schedule");
        String seq_study = req.getParameter("seq_study");
        String title = req.getParameter("title");
        String scheduleDate = req.getParameter("scheduleDate");
        String scheduleTime = req.getParameter("scheduleTime");
        String location = req.getParameter("location");
        String topic = req.getParameter("topic");

        // (NULL 방어막)
        if (topic == null || topic.trim().equals("")) {
            topic = "등록된 상세 설명이 없습니다.";
        }

        // 2. DTO에 다시 포장하기
        StudyScheduleDTO dto = new StudyScheduleDTO();
        dto.setSeq_study_day(seq_schedule); // 수정할 글 번호 필수!!
        dto.setTitle(title);
        dto.setScheduleDate(scheduleDate);
        dto.setScheduleTime(scheduleTime);
        dto.setDetail(location);
        dto.setTopic(topic);

        // 3. DAO 시켜서 DB 업데이트(덮어쓰기)
        StudyDAO dao = new StudyDAO();
        int result = dao.editStudySchedule(dto);

        // 4. 결과에 따른 이동
        if (result > 0) {
            // 성공하면 다시 그 스터디의 일정 목록으로 이동!
            resp.sendRedirect("studyScheduleManage.do?seq=" + seq_study);
        } else {
            resp.setContentType("text/html; charset=UTF-8");
            PrintWriter writer = resp.getWriter();
            writer.print("<script>alert('수정에 실패했습니다.'); history.back();</script>");
            writer.close();
        }
    }
}