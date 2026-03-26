<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>내가 관리하는 스터디 - STUDY 커뮤니티</title>
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
        
        .main-content { flex: 1; display: block; }
        .board-header { display: flex; justify-content: space-between; align-items: flex-end; margin-bottom: 25px; border-bottom: 2px solid #212529; padding-bottom: 15px; }
        .board-title { font-size: 24px; font-weight: 800; color: #212529; }
        .board-desc { font-size: 14px; color: #6c757d; font-weight: 600; }
        
        .my-study-list { display: flex; flex-direction: column; gap: 20px; }
        .my-study-item { display: flex; justify-content: space-between; align-items: center; padding: 25px; border: 1px solid #e9ecef; border-radius: 8px; background-color: #ffffff; transition: all 0.2s; }
        .my-study-item:hover { border-color: #007bff; box-shadow: 0 4px 12px rgba(0,123,255,0.08); }
        .study-info { display: flex; flex-direction: column; gap: 10px; flex: 1; }
        .badges { display: flex; gap: 8px; }
        .badge { padding: 4px 10px; font-size: 12px; font-weight: 800; border-radius: 4px; }
        .badge-recruiting { background-color: #e3f2fd; color: #0d6efd; }
        .badge-active { background-color: #d1e7dd; color: #198754; }
        .badge-alert { background-color: #dc3545; color: #ffffff; }
        .study-title { font-size: 20px; font-weight: 800; color: #212529; text-decoration: none; line-height: 1.4; }
        .study-title:hover { color: #007bff; text-decoration: underline; }
        .study-meta { display: flex; gap: 15px; font-size: 14px; color: #868e96; margin-top: 5px; }
        .meta-item { display: flex; align-items: center; gap: 5px; }
        
        .study-actions { display: flex; flex-direction: column; gap: 8px; margin-left: 20px; flex-shrink: 0; width: 140px; }
        .btn { padding: 10px 0; font-size: 14px; font-weight: 700; border-radius: 6px; text-align: center; text-decoration: none; cursor: pointer; transition: all 0.2s; width: 100%; display: inline-block; box-sizing: border-box; }
        .btn-manage { background-color: #FFFFFF; color: #212529; border: 1px solid #212529; }
        .btn-manage:hover { background-color: #212529; color: #ffffff; }
        .btn-edit { background-color: #ffffff; color: #0d6efd; border: 1px solid #0d6efd; }
        .btn-edit:hover { background-color: #f0f7ff; }
        .btn-schedule { background-color: #ffffff; color: #198754; border: 1px solid #198754; }
        .btn-schedule:hover { background-color: #d1e7dd; }
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
                <%-- 세션에서 닉네임 가져오기 --%>
                <div class="info-value nickname">${sessionScope.nickname != null ? sessionScope.nickname : '개발왕초보'}</div>
                <p class="info-status">오늘도 화이팅하세요!</p>
            </div>
            
            <ul class="side-menu-list">
                <li><a href="studyList.do" class="side-menu-item">🔍 스터디 찾기</a></li>
                <li><a href="myStudy.do" class="side-menu-item">📚 내 스터디</a></li>
                <li>
                    <a href="manageStudy.do" class="side-menu-item active">
                        👑 내가 관리하는 스터디
                    </a>
                </li>
            </ul>
        </aside>

        <main class="main-content">
            <div class="card">
                
                <div class="board-header">
                    <h2 class="board-title">👑 내가 관리하는 스터디</h2>
                    <span class="board-desc">방장으로 운영 중인 스터디 목록입니다.</span>
                </div>

                <div class="my-study-list">
                    
                    <%-- 🌟 서버에서 넘겨준 studyList가 비어있을 때 --%>
                    <c:if test="${empty studyList}">
                        <div style="text-align: center; padding: 50px 0; color: #868e96; font-weight: 600;">
                            아직 방장으로 개설한 스터디가 없습니다.<br>
                            새로운 스터디를 만들어 보세요!
                        </div>
                    </c:if>

                    <%-- 🌟 DB에서 가져온 내가 만든 스터디 목록 반복 출력 --%>
                    <c:forEach items="${studyList}" var="study">
                        <div class="my-study-item">
                            <div class="study-info">
                                <div class="badges">
                                    <%-- ERD의 status(진행/종료)에 따라 뱃지 색상 변경 --%>
                                    <c:choose>
                                        <c:when test="${study.status == '0'}">
                                            <span class="badge badge-recruiting">모집중</span>
                                        </c:when>
                                        <c:when test="${study.status == '1'}">
                                            <span class="badge badge-active">진행중</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge badge-alert">종료됨</span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                
                                <%-- 제목 클릭 시 해당 스터디 상세 보기로 이동 --%>
                                <a href="studyDetail.do?seq=${study.seq_study}" class="study-title">${study.title}</a>
                                
                                <div class="study-meta">
                                    <%-- 현재인원 / 최대인원 표시 --%>
                                    <span class="meta-item">
                                        👥 인원: ${study.population} / ${study.max_population} 명
                                        <c:if test="${study.population >= study.max_population}">
                                            <span style="color:#dc3545; font-size:12px;">(마감)</span>
                                        </c:if>
                                    </span>
                                    <span class="meta-item">🗓️ 개설일: ${study.regdate}</span>
                                </div>
                            </div>
                            
                            <%-- 관리용 액션 버튼들 (글 번호를 쿼리스트링으로 쏴줌) --%>
                            <div class="study-actions">
                                <a href="studyMemberManage.do?seq=${study.seq_study}" class="btn btn-manage">👥 멤버 관리</a>
                                <a href="studyScheduleManage.do?seq=${study.seq_study}" class="btn btn-schedule">📅 일정 관리</a>
                                <a href="studyEdit.do?seq=${study.seq_study}" class="btn btn-edit">✏️ 정보 수정</a>
                            </div>
                        </div>
                    </c:forEach>

                </div>

            </div>
        </main>
    </div>

</body>
</html>