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

@WebServlet("/studyScheduleAdd.do")
public class StudyScheduleAdd extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        
        // 1. POST 방식 한글 깨짐 방지 (필수!)
        req.setCharacterEncoding("UTF-8");

        // 2. JSP 폼에서 넘어온 5가지 데이터 쏙쏙 뽑기
        String seq_study = req.getParameter("seq_study");
        String title = req.getParameter("title");
        String scheduleDate = req.getParameter("scheduleDate"); // "2026-03-25"
        String scheduleTime = req.getParameter("scheduleTime"); // "20:00"
        String location = req.getParameter("location");         // 장소
        String topic = req.getParameter("topic");

        if (topic == null || topic.trim().equals("")) {
            topic = "등록된 상세 설명이 없습니다.";
        }
        
        // 3. DTO 상자에 예쁘게 담기
        StudyScheduleDTO dto = new StudyScheduleDTO();
        dto.setSeq_study(seq_study);
        dto.setTitle(title);
        dto.setScheduleDate(scheduleDate);
        dto.setScheduleTime(scheduleTime);
        dto.setDetail(location); // 장소를 detail 변수에 쏙!
        dto.setTopic(topic);

        // 4. DAO 시켜서 DB에 저장!
        StudyDAO dao = new StudyDAO();
        int result = dao.addStudySchedule(dto);

        // 5. 결과에 따라 화면 이동
        if (result > 0) {
            // 🌟 성공 시: 방금 일정을 추가한 그 스터디의 일정 관리 페이지로 새로고침(이동)!
            resp.sendRedirect("studyScheduleManage.do?seq=" + seq_study);
        } else {
            // ❌ 실패 시: 팝업 띄우고 뒤로 가기
            resp.setContentType("text/html; charset=UTF-8");
            PrintWriter writer = resp.getWriter();
            writer.print("<script>alert('일정 등록에 실패했습니다. 입력값을 확인해주세요.'); history.back();</script>");
            writer.close();
        }
    }
}