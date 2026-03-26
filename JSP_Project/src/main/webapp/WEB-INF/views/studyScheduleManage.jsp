<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> <%-- 문자열 자르기 용도 --%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>스터디 일정 관리 - STUDY 커뮤니티</title>
    <style>
        /* CSS는 네가 준 코드 100% 그대로! */
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
        .header-section { margin-bottom: 30px; border-bottom: 2px solid #212529; padding-bottom: 15px; display: flex; justify-content: space-between; align-items: flex-end; }
        .form-title { font-size: 24px; font-weight: 800; color: #212529; }
        .study-name { font-size: 14px; color: #6c757d; font-weight: 600; }
        .schedule-form-wrapper { background-color: #f8f9fa; border: 1px solid #ced4da; border-radius: 8px; padding: 25px; margin-bottom: 40px; }
        .section-title { font-size: 18px; font-weight: 700; color: #212529; margin-bottom: 20px; display: flex; align-items: center; gap: 8px; }
        .form-row { display: flex; gap: 15px; margin-bottom: 15px; }
        .form-col { flex: 1; }
        .form-label { display: block; font-size: 13px; font-weight: 700; color: #495057; margin-bottom: 8px; }
        .form-control { width: 100%; padding: 10px 15px; font-size: 14px; border: 1px solid #ced4da; border-radius: 6px; outline: none; transition: border-color 0.2s; }
        .form-control:focus { border-color: #007bff; }
        .form-actions { display: flex; justify-content: flex-end; margin-top: 15px; }
        .btn-submit { padding: 10px 25px; background-color: #198754; color: #ffffff; border: none; border-radius: 6px; cursor: pointer; font-weight: 700; font-size: 15px; transition: background-color 0.2s; }
        .btn-submit:hover { background-color: #157347; }
        .schedule-list { display: flex; flex-direction: column; gap: 15px; }
        .schedule-item { display: flex; align-items: center; border: 1px solid #e9ecef; border-radius: 10px; background-color: #ffffff; overflow: hidden; transition: all 0.2s; }
        .schedule-item:hover { border-color: #ced4da; }
        .date-box { display: flex; flex-direction: column; justify-content: center; align-items: center; width: 80px; height: 90px; background-color: #f8f9fa; border-right: 1px solid #e9ecef; flex-shrink: 0; }
        .date-month { font-size: 12px; font-weight: 700; color: #6c757d; }
        .date-day { font-size: 24px; font-weight: 800; color: #212529; line-height: 1.1; }
        .info-box { padding: 15px 20px; flex: 1; display: flex; justify-content: space-between; align-items: center; }
        .info-main { display: flex; flex-direction: column; gap: 8px; }
        .schedule-title { font-size: 16px; font-weight: 700; color: #212529; }
        .schedule-details { font-size: 13px; color: #6c757d; display: flex; align-items: center; gap: 15px; }
        .detail-item { display: flex; align-items: center; gap: 4px; }
        .action-group { display: flex; gap: 8px; margin-left: 20px; flex-shrink: 0; }
        .btn-sm { padding: 8px 14px; font-size: 13px; font-weight: 600; border-radius: 4px; cursor: pointer; transition: all 0.2s; }
        .btn-edit { background-color: #ffffff; color: #0d6efd; border: 1px solid #0d6efd; }
        .btn-edit:hover { background-color: #f0f7ff; }
        .btn-delete { background-color: #ffffff; color: #dc3545; border: 1px solid #dc3545; }
        .btn-delete:hover { background-color: #fff5f5; }
        .attendance-status { font-size: 12px; font-weight: 700; color: #198754; background-color: #d1e7dd; padding: 4px 8px; border-radius: 4px; margin-right: 10px; }
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
                    <h2 class="form-title">📅 스터디 일정 관리</h2>
                    <span class="study-name">${studyInfo.title}</span>
                </div>

                <div class="schedule-form-wrapper">
                    <h3 class="section-title">➕ 새 일정 등록</h3>
                    <%-- 🌟 실제 서블릿(studyScheduleAdd.do)으로 전송하도록 변경 --%>
                    <form action="studyScheduleAdd.do" method="POST">
                        <input type="hidden" name="seq_study" value="${studyInfo.seq_study}">

                        <div class="form-row">
                            <div class="form-col" style="flex: 2;">
                                <label class="form-label">일정 제목 (모임명)</label>
                                <input type="text" name="title" class="form-control" placeholder="예: 2주차 온라인 정기 모임" required>
                            </div>
                            <div class="form-col">
                                <label class="form-label">날짜</label>
                                <input type="date" name="scheduleDate" class="form-control" required>
                            </div>
                            <div class="form-col">
                                <label class="form-label">시간</label>
                                <input type="time" name="scheduleTime" class="form-control" required>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="form-col">
                                <label class="form-label">장소 (또는 화상회의 링크)</label>
                                <input type="text" name="location" class="form-control" placeholder="예: 강남역 토즈, 디스코드 음성채널 링크 등">
                            </div>

                        </div>
                        <div class="form-row">
                            <div class="form-col">
                                <label class="form-label">일정 상세 설명 (학습 주제, 준비물 등)</label>
                                <textarea name="topic" class="form-control" rows="3" placeholder="예: 2주차 과제 코드 리뷰 진행합니다. 개인 노트북 꼭 지참해주세요!"></textarea>
                            </div>
                        </div>
                        <div class="form-actions">
                            <button type="submit" class="btn-submit">일정 등록하기</button>
                        </div>
                    </form>
                </div>

                <div class="schedule-list" id="scheduleListArea">
                    <h3 class="section-title" style="margin-bottom: 10px;">등록된 일정 목록</h3>
                    
                    <%-- 데이터가 없을 때 표시 --%>
                    <c:if test="${empty scheduleList}">
                        <div style="text-align: center; padding: 40px; color: #868e96; background-color: #f8f9fa; border-radius: 8px;">
                            등록된 일정이 없습니다. 새 일정을 추가해 보세요!
                        </div>
                    </c:if>

                    <%-- 반복문으로 일정 출력 --%>
                    <c:forEach items="${scheduleList}" var="schedule">
                        <div class="schedule-item">
                            <div class="date-box">
                                <%-- 🌟 서버에서 넘겨줄 때 달(month)과 일(day)을 분리해 두면 좋지만, 임시로 fn:substring으로 자르기! (예: 2026-03-25) --%>
                                <span class="date-month">${fn:substring(schedule.scheduleDate, 5, 7)}월</span>
                                <span class="date-day">${fn:substring(schedule.scheduleDate, 8, 10)}</span>
                            </div>
                            <div class="info-box">
                                <div class="info-main">
                                    <h3 class="schedule-title">${schedule.title}</h3>
                                    <div class="schedule-details">
                                        <span class="detail-item">⏰ ${schedule.scheduleTime}</span>
                                        <span class="detail-item">📍 ${empty schedule.location ? '장소 미정' : schedule.location}</span>
                                    </div>
                                </div>
                                <div style="display: flex; align-items: center;">
                                    <%-- 참석 인원은 추후 구현을 위해 임시로 텍스트 유지 --%>
                                    <span class="attendance-status">일정 등록됨</span>
                                    <div class="action-group">
                                        <button type="button" class="btn-sm btn-edit" onclick="location.href='studyScheduleEdit.do?seq_schedule=${schedule.seq_study_day}&seq_study=${studyInfo.seq_study}'">수정</button>
										<button type="button" class="btn-sm btn-delete" onclick="if(confirm('이 일정을 정말 삭제하시겠습니까?')) location.href='studyScheduleDelete.do?seq_schedule=${schedule.seq_study_day}&seq_study=${studyInfo.seq_study}'">삭제</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>

                </div>
            </div>
        </main>
    </div>

</body>
</html>