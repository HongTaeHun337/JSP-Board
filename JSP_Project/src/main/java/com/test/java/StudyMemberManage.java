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
import com.test.java.model.StudyMemberDTO;

@WebServlet("/studyMemberManage.do")
public class StudyMemberManage extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        
        // 1. 주소창에서 넘어온 스터디 번호 받기 (예: ?seq=2)
        String seq_study = req.getParameter("seq");

        StudyDAO dao = new StudyDAO();

        // 2. 화면에 뿌려줄 3가지 데이터 야무지게 가져오기!
        // ① 스터디 기본 정보
        StudyDTO studyInfo = dao.getStudy(seq_study);
        
        // ② 가입 대기 멤버 (status = '0')
        List<StudyMemberDTO> waitList = dao.getStudyMemberList(seq_study, "0");
        
        // ③ 현재 참여 멤버 (status = '1')
        List<StudyMemberDTO> memberList = dao.getStudyMemberList(seq_study, "1");

        // 3. JSP한테 데이터 넘겨주기 (JSP에서 쓰기로 약속한 이름 그대로!)
        req.setAttribute("studyInfo", studyInfo);
        req.setAttribute("waitList", waitList);
        req.setAttribute("memberList", memberList);

        // 4. JSP 화면 띄우기 (폴더 경로 한 번 더 확인!)
        req.getRequestDispatcher("/WEB-INF/views/studyMemberManage.jsp").forward(req, resp);
    }
}