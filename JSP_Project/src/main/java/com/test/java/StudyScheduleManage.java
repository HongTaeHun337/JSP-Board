package com.test.java;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.test.java.model.StudyDAO;
import com.test.java.model.StudyDTO;
import com.test.java.model.StudyScheduleDTO;

@WebServlet("/studyScheduleManage.do")
public class StudyScheduleManage extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        
        // 1. 주소창에서 넘어온 스터디 번호 받기 (예: ?seq=2)
        String seq_study = req.getParameter("seq");
        
        System.out.println("넘어온 스터디 번호: " + seq_study);

        StudyDAO dao = new StudyDAO();

        // 2. 화면에 뿌려줄 데이터 2가지 가져오기
        // ① 스터디 기본 정보 (상단에 제목 출력용)
        StudyDTO studyInfo = dao.getStudy(seq_study);
        
        if (studyInfo == null) {
            System.out.println("에러: 스터디 정보를 찾을 수 없습니다. (seq=" + seq_study + ")");
            // 정보가 없으면 목록으로 돌려보내기
            resp.sendRedirect("manageStudy.do");
            return;
        }
        
        // ② 이 스터디의 일정 목록 전부 다 가져오기!
        List<StudyScheduleDTO> scheduleList = dao.getStudyScheduleList(seq_study);
        
        

        // 3. JSP한테 데이터 쥐여주기
        req.setAttribute("studyInfo", studyInfo);
        req.setAttribute("scheduleList", scheduleList);
        
        
        
        

        // 4. 일정 관리 JSP 화면으로 슝~ 🚀
        req.getRequestDispatcher("/WEB-INF/views/studyScheduleManage.jsp").forward(req, resp);
    }
}