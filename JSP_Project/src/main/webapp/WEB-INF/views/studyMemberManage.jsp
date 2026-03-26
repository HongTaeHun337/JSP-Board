<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>스터디 멤버 관리 - STUDY 커뮤니티</title>
    <style>
        /* CSS는 네가 준 코드 그대로 100% 유지! (생략 없이 다 넣었어) */
        * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Pretendard', -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif; }
        body { background-color: #f4f7f6; color: #333; }
        .navbar { display: flex; justify-content: space-between; align-items: center; padding: 0 40px; height: 70px; background-color: #ffffff; box-shadow: 0 2px 5px rgba(0,0,0,0.05); position: sticky; top: 0; z-index: 100; }
        .logo { font-size: 24px; font-weight: 800; color: #007bff; text-decoration: none; }
        .nav-menu { display: flex; gap: 40px; }
        .nav-menu a { text-decoration: none; color: #555; font-weight: 600; font-size: 16px; }
        .nav-menu a:hover, .nav-menu a.active { color: #007bff; }
        .logout-btn { padding: 8px 16px; background-color: #f1f3f5; color: #495057; text-decoration: none; border-radius: 6px; font-weight: 600; font-size: 14px; }
        .container { display: flex; max-width: 1200px; margin: 40px auto; gap: 30px; padding: 0 20px; }
        .card { background-color: #ffffff; border-radius: 12px; padding: 30px; box-shadow: 0 4px 12px rgba(0,0,0,0.03); }
        .sidebar { width: 300px; flex-shrink: 0; align-self: flex-start; }
        .profile-img { width: 100px; height: 100px; background-color: #e9ecef; border-radius: 50%; margin: 0 auto 15px auto; display: flex; justify-content: center; align-items: center; color: #adb5bd; font-size: 16px; }
        .info-group { text-align: center; margin-bottom: 20px; padding-bottom: 20px; border-bottom: 1px solid #f1f3f5; }
        .info-value.nickname { font-size: 20px; font-weight: 800; color: #212529; margin-bottom: 5px; }
        .info-status { font-size: 14px; color: #868e96; }
        .side-menu-list { list-style: none; }
        .side-menu-item { display: block; padding: 14px 18px; color: #495057; text-decoration: none; font-weight: 700; border-radius: 8px; margin-bottom: 8px; transition: all 0.2s; display: flex; align-items: center; gap: 10px; }
        .side-menu-item:hover { background-color: #f8f9fa; }
        .side-menu-item.active { background-color: #f0f7ff; color: #007bff; }
        .menu-badge { display: inline-block; background-color: #dc3545; color: white; font-size: 11px; padding: 2px 6px; border-radius: 10px; margin-left: 5px; vertical-align: middle; }
        .main-content { flex: 1; display: block; }
        .header-section { margin-bottom: 30px; border-bottom: 2px solid #212529; padding-bottom: 15px; display: flex; justify-content: space-between; align-items: flex-end; }
        .form-title { font-size: 24px; font-weight: 800; color: #212529; }
        .study-name { font-size: 14px; color: #6c757d; font-weight: 600; }
        .section-title { font-size: 18px; font-weight: 700; color: #212529; margin-bottom: 15px; display: flex; align-items: center; gap: 10px; }
        .count-badge { background-color: #e3f2fd; color: #0d6efd; padding: 4px 10px; border-radius: 20px; font-size: 14px; }
        .count-badge.alert { background-color: #dc3545; color: #ffffff; }
        .member-list { display: flex; flex-direction: column; gap: 15px; margin-bottom: 40px; }
        .member-item { display: flex; justify-content: space-between; align-items: center; padding: 20px; border: 1px solid #e9ecef; border-radius: 8px; background-color: #ffffff; transition: border-color 0.2s; }
        .member-item:hover { border-color: #ced4da; }
        .member-info { display: flex; align-items: flex-start; gap: 15px; flex: 1; }
        .member-avatar { width: 50px; height: 50px; background-color: #f1f3f5; border-radius: 50%; display: flex; justify-content: center; align-items: center; font-size: 12px; color: #adb5bd; flex-shrink: 0; }
        .member-details { display: flex; flex-direction: column; gap: 5px; width: 100%; }
        .member-name { font-size: 16px; font-weight: 700; color: #212529; display: flex; align-items: center; gap: 8px; }
        .member-date { font-size: 13px; color: #868e96; font-weight: 400; }
        .member-message { font-size: 14px; color: #495057; background-color: #f8f9fa; padding: 12px 15px; border-radius: 6px; margin-top: 5px; border-left: 3px solid #0d6efd; line-height: 1.5; }
        .role-badge { padding: 3px 8px; border-radius: 4px; font-size: 12px; font-weight: 700; }
        .role-leader { background-color: #fff3cd; color: #856404; }
        .role-member { background-color: #e9ecef; color: #495057; }
        .action-group { display: flex; gap: 8px; flex-shrink: 0; margin-left: 20px; }
        .btn-sm { padding: 10px 16px; font-size: 14px; font-weight: 700; border-radius: 6px; cursor: pointer; transition: all 0.2s; }
        .btn-approve { background-color: #0d6efd; color: #ffffff; border: 1px solid #0d6efd; }
        .btn-approve:hover { background-color: #0b5ed7; }
        .btn-reject { background-color: #ffffff; color: #dc3545; border: 1px solid #dc3545; }
        .btn-reject:hover { background-color: #fff5f5; }
        .btn-kick { background-color: #ffffff; color: #6c757d; border: 1px solid #ced4da; }
        .btn-kick:hover { color: #dc3545; border-color: #dc3545; background-color: #fff5f5; }
        .empty-state { text-align: center; padding: 40px 20px; color: #adb5bd; font-size: 15px; background-color: #f8f9fa; border-radius: 8px; border: 1px dashed #ced4da; font-weight: 600; }
    </style>
</head>
<body>

    <header class="navbar">
        <a href="index.do" class="logo">STUDY</a>
        <nav class="nav-menu">
            <a href="#">커뮤니티</a>
            <a href="index.do">학습계획</a>
            <a href="studyList.do" class="active">스터디</a>
        </nav>
        <a href="logout.do" class="logout-btn">로그아웃</a>
    </header>

    <div class="container">
        
        <aside class="sidebar card">
            <div class="profile-img">사진</div>
            <div class="info-group">
                <div class="info-value nickname">${sessionScope.nickname != null ? sessionScope.nickname : '개발왕초보'}</div>
                <p class="info-status">오늘도 화이팅하세요!</p>
            </div>
            
            <ul class="side-menu-list">
                <li><a href="studyList.do" class="side-menu-item">🔍 스터디 찾기</a></li>
                <li><a href="myStudy.do" class="side-menu-item">📚 내 스터디</a></li>
                <li><a href="manageStudy.do" class="side-menu-item active">👑 내가 관리하는 스터디</a></li>
            </ul>
        </aside>

        <main class="main-content">
            <div class="card">
                
                <div class="header-section">
                    <h2 class="form-title">👥 스터디 멤버 관리</h2>
                    <span class="study-name">${studyInfo.title}</span> <%-- 🌟 상단에 스터디 제목 표시 --%>
                </div>

                <div class="section-title">
                    가입 신청 대기 
                    <%-- 대기자가 있으면 빨간 배지, 없으면 일반 배지 --%>
                    <span class="count-badge ${waitList.size() > 0 ? 'alert' : ''}" id="applicantCount">${waitList.size()}명</span>
                </div>
                
                <div class="member-list" id="applicantList">
                    
                    <%-- 🌟 대기 멤버가 없을 때 --%>
                    <c:if test="${empty waitList}">
                        <div class="empty-state">현재 대기 중인 가입 신청자가 없습니다.</div>
                    </c:if>

                    <%-- 🌟 대기 멤버 반복문 --%>
                    <c:forEach items="${waitList}" var="wait">
                        <div class="member-item applicant-row">
                            <div class="member-info">
                                <div class="member-avatar">사진</div>
                                <div class="member-details">
                                    <div class="member-name">${wait.userName} <span class="member-date">${wait.regdate} 신청</span></div>
                                    <div class="member-message">"열심히 하겠습니다!"</div> <%-- 임시 메시지 (ERD에 인사말 컬럼이 없어서 고정) --%>
                                </div>
                            </div>
                            <div class="action-group">
                                <%-- 🌟 승인/거절 시 서블릿(studyMemberAction.do)으로 seq_study_join 번호를 넘겨서 처리 --%>
                                <button type="button" class="btn-sm btn-approve" onclick="location.href='studyMemberAction.do?action=approve&joinSeq=${wait.seq_study_join}&studySeq=${studyInfo.seq_study}'">승인</button>
                                <button type="button" class="btn-sm btn-reject" onclick="location.href='studyMemberAction.do?action=reject&joinSeq=${wait.seq_study_join}&studySeq=${studyInfo.seq_study}'">거절</button>
                            </div>
                        </div>
                    </c:forEach>
                    
                </div>

                <div class="section-title">
                    현재 참여 멤버 
                    <%-- memberList.size() 를 쓰면 현재 리스트에 들어있는 진짜 멤버 수를 딱 세어줘! --%>
					<span class="count-badge" id="currentCount">${memberList.size()} / ${studyInfo.max_population} 명</span>
                </div>
                
                <div class="member-list" id="currentMemberList">
                    
                    <%-- 🌟 기존 멤버 반복문 (방장 포함) --%>
                    <c:forEach items="${memberList}" var="member">
                        <%-- 🌟 방장은 배경색 다르게 표시 (authority == 1) --%>
                        <div class="member-item member-row" style="${member.authority == '1' ? 'background-color: #f8f9fa;' : ''}">
                            <div class="member-info">
                                <div class="member-avatar">사진</div>
                                <div class="member-details">
                                    <div class="member-name">
                                        ${member.userName} 
                                        <%-- 권한에 따른 배지 --%>
                                        <c:choose>
                                            <c:when test="${member.authority == '1'}">
                                                <span class="role-badge role-leader">방장</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="role-badge role-member">스터디원</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                    <div class="member-date">${member.regdate} 가입</div>
                                </div>
                            </div>
                            <div class="action-group">
                                <%-- 🌟 방장은 자기 자신을 강퇴할 수 없음 --%>
                                <c:if test="${member.authority != '1'}">
                                    <button type="button" class="btn-sm btn-kick" onclick="if(confirm('정말 강제 퇴장시키겠습니까?')) location.href='studyMemberAction.do?action=kick&joinSeq=${member.seq_study_join}&studySeq=${studyInfo.seq_study}'">강퇴</button>
                                </c:if>
                            </div>
                        </div>
                    </c:forEach>

                </div>

            </div>
        </main>
    </div>

</body>
</html>