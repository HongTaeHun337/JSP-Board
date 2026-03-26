<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>스터디 일정 수정 - STUDY 커뮤니티</title>
    <style>
        /* 🌟 원래 있던 CSS 그대로 100% 복구! */
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
        .schedule-form-wrapper { background-color: #f8f9fa; border: 1px solid #ced4da; border-radius: 8px; padding: 25px; margin-bottom: 40px; }
        .form-row { display: flex; gap: 15px; margin-bottom: 15px; }
        .form-col { flex: 1; }
        .form-label { display: block; font-size: 13px; font-weight: 700; color: #495057; margin-bottom: 8px; }
        .form-control { width: 100%; padding: 10px 15px; font-size: 14px; border: 1px solid #ced4da; border-radius: 6px; outline: none; transition: border-color 0.2s; }
        .form-control:focus { border-color: #007bff; }
        
        /* 버튼 영역만 살짝 수정용으로 다듬었어 */
        .form-actions { display: flex; justify-content: flex-end; margin-top: 20px; gap: 10px; }
        .btn { padding: 10px 25px; border: none; border-radius: 6px; cursor: pointer; font-weight: 700; font-size: 15px; transition: background-color 0.2s; }
        .btn-submit { background-color: #0d6efd; color: #ffffff; }
        .btn-submit:hover { background-color: #0b5ed7; }
        .btn-cancel { background-color: #6c757d; color: #ffffff; }
        .btn-cancel:hover { background-color: #5c636a; }
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
                    <h2 class="form-title">✏️ 스터디 일정 수정</h2>
                </div>

                <div class="schedule-form-wrapper">
                    <form action="studyScheduleEdit.do" method="POST">
                        <input type="hidden" name="seq_schedule" value="${dto.seq_study_day}">
                        <input type="hidden" name="seq_study" value="${seq_study}">

                        <div class="form-row">
                            <div class="form-col" style="flex: 2;">
                                <label class="form-label">일정 제목 (모임명)</label>
                                <input type="text" name="title" class="form-control" value="${dto.title}" required>
                            </div>
                            <div class="form-col">
                                <label class="form-label">날짜</label>
                                <input type="date" name="scheduleDate" class="form-control" value="${dto.scheduleDate}" required>
                            </div>
                            <div class="form-col">
                                <label class="form-label">시간</label>
                                <input type="time" name="scheduleTime" class="form-control" value="${dto.scheduleTime}" required>
                            </div>
                        </div>
                        
                        <div class="form-row">
                            <div class="form-col">
                                <label class="form-label">장소 (또는 화상회의 링크)</label>
                                <input type="text" name="location" class="form-control" value="${dto.detail}">
                            </div>
                        </div>
                        
                        <div class="form-row">
                            <div class="form-col">
                                <label class="form-label">일정 상세 설명 (학습 주제, 준비물 등)</label>
                                <textarea name="topic" class="form-control" rows="4">${dto.topic}</textarea>
                            </div>
                        </div>
                        
                        <div class="form-actions">
                            <button type="button" class="btn btn-cancel" onclick="history.back();">취소</button>
                            <button type="submit" class="btn btn-submit">수정 완료</button>
                        </div>
                    </form>
                </div>

            </div>
        </main>
    </div>

</body>
</html>