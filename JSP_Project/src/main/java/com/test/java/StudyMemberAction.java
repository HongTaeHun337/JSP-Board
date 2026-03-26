package com.test.java;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.test.java.model.StudyDAO;

@WebServlet("/studyMemberAction.do")
public class StudyMemberAction extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        
        // 1. JSP에서 넘겨준 3가지 단서 받기
        String action = req.getParameter("action");     // 명령 종류: approve(승인), reject(거절), kick(강퇴)
        String joinSeq = req.getParameter("joinSeq");   // 누구를? (조인 테이블 고유번호)
        String studySeq = req.getParameter("studySeq"); // 어떤 스터디? (돌아갈 목적지)
        
        StudyDAO dao = new StudyDAO();
        int result = 0;
        
        // 2. 명령(action)에 따라 DAO한테 다른 심부름 시키기
        if (action.equals("approve")) {
            // 승인이면 업데이트!
            result = dao.approveMember(joinSeq);
            
        } else if (action.equals("reject") || action.equals("kick")) {
            // 거절이거나 강퇴면 삭제! (기능이 똑같아서 묶었어)
            result = dao.removeMember(joinSeq);
        }
        
        // 3. 결과에 따른 화면 이동
        if (result > 0) {
            // 🌟 성공 시: 처리가 끝난 뒤 원래 보던 그 스터디의 멤버 관리 페이지로 싹~ 새로고침
            resp.sendRedirect("studyMemberManage.do?seq=" + studySeq);
        } else {
            // 실패 시: 경고창 띄우고 뒤로 가기
            resp.setContentType("text/html; charset=UTF-8");
            PrintWriter writer = resp.getWriter();
            writer.print("<script>alert('멤버 처리에 실패했습니다. 다시 시도해주세요.'); history.back();</script>");
            writer.close();
        }
    }
}