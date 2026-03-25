



<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>내 학습 계획 목록 - OOO 커뮤니티</title>
    <style>
        /* 1. 기본 스타일 */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Pretendard', -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
        }

        body {
            background-color: #f4f7f6;
            color: #333;
        }

        /* 2. 상단 네비게이션 바 */
        .navbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0 40px;
            height: 70px;
            background-color: #ffffff;
            box-shadow: 0 2px 5px rgba(0,0,0,0.05);
            position: sticky;
            top: 0;
            z-index: 100;
        }

        .logo {
            font-size: 24px;
            font-weight: 800;
            color: #007bff;
            text-decoration: none;
        }

        .nav-menu {
            display: flex;
            gap: 40px;
        }

        .nav-menu a {
            text-decoration: none;
            color: #555;
            font-weight: 600;
            font-size: 16px;
        }

        .nav-menu a:hover, .nav-menu a.active {
            color: #007bff;
        }

        .logout-btn {
            padding: 8px 16px;
            background-color: #f1f3f5;
            color: #495057;
            text-decoration: none;
            border-radius: 6px;
            font-weight: 600;
            font-size: 14px;
        }

        /* 3. 전체 레이아웃 */
        .container {
            display: flex;
            max-width: 1200px;
            margin: 40px auto;
            gap: 30px;
            padding: 0 20px;
        }

        .card {
            background-color: #ffffff;
            border-radius: 12px;
            padding: 30px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.03);
        }

        /* 4. 좌측 사이드바 (단순화) */
        .sidebar {
            width: 300px;
            flex-shrink: 0;
            align-self: flex-start;
        }

        .profile-img {
            width: 100px;
            height: 100px;
            background-color: #e9ecef;
            border-radius: 50%;
            margin: 0 auto 15px auto;
            display: flex;
            justify-content: center;
            align-items: center;
            color: #adb5bd;
            font-size: 16px;
        }

        .info-group {
            text-align: center;
        }

        .info-value.nickname {
            font-size: 20px;
            font-weight: 700;
            color: #212529;
            margin-bottom: 20px;
        }

        /* 5. 우측 학습 계획 목록 영역 */
        .main-content {
            flex: 1;
            display: block;
        }

        .list-header {
            margin-bottom: 25px;
            border-bottom: 2px solid #f8f9fa;
            padding-bottom: 15px;
        }

        .list-title {
            font-size: 22px;
            font-weight: 700;
            color: #212529;
        }

        /* 학습 계획 리스트 아이템 스타일 */
        .plan-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 20px;
            border: 1px solid #f1f3f5;
            border-radius: 8px;
            margin-bottom: 15px;
            transition: all 0.2s;
            text-decoration: none;
            color: inherit;
        }

        .plan-item:hover {
            border-color: #007bff;
            box-shadow: 0 4px 10px rgba(0,123,255,0.05);
            transform: translateY(-2px);
        }

        .plan-info {
            display: flex;
            flex-direction: column;
            gap: 8px;
        }

        .plan-title {
            font-size: 18px;
            font-weight: 700;
            color: #212529;
        }

        .plan-date {
            font-size: 14px;
            color: #868e96;
        }

        /* 유형 배지 (기간형 vs 목표형) */
        .badge-group {
            display: flex;
            gap: 8px;
        }

        .badge {
            padding: 4px 8px;
            border-radius: 4px;
            font-size: 12px;
            font-weight: 600;
        }

        .badge-time {
            background-color: #e3f2fd;
            color: #0d6efd;
        }

        .badge-goal {
            background-color: #f8d7da;
            color: #dc3545;
        }

        .badge-status {
            background-color: #d1e7dd;
            color: #198754;
        }

        /* 💡 추가된 부분: 목록 하단 꽉 차는 생성 버튼 */
        .create-btn-wrapper {
            margin-top: 30px;
        }

        .btn-create-large {
            display: block;
            width: 100%;
            padding: 18px;
            font-size: 16px;
            font-weight: 700;
            color: #007bff;
            background-color: #f8f9fa;
            border: 2px dashed #007bff;
            border-radius: 8px;
            text-align: center;
            text-decoration: none;
            transition: all 0.2s;
        }

        .btn-create-large:hover {
            background-color: #007bff;
            color: #ffffff;
            border-style: solid;
        }
    </style>
</head>
<body>

    <header class="navbar">
        <a href="/" class="logo">JAVA</a>
        <nav class="nav-menu">
            <a href="#">커뮤니티</a>
            <a href="#" class="active">학습계획</a>
            <a href="#">스터디</a>
        </nav>
        <a href="#" class="logout-btn">로그아웃</a>
    </header>

    <div class="container">
        
        <aside class="sidebar card">
            <div class="profile-img">사진</div>
            <div class="info-group">
                <div class="info-value nickname">${todo.name}</div>
                <p style="font-size: 14px; color: #6c757d;">오늘도 화이팅하세요!</p>
            </div>
        </aside>

        <main class="main-content">
            <div class="card">
                
                <div class="list-header">
                    <h2 class="list-title">나의 학습 계획</h2>
                </div>

                <div class="plan-list">
                    
                    <c:forEach items="${todolist}" var="todo">
                        <a href="view.do?seq=${todo.seq_plan}" class="plan-item">
                            <div class="plan-info">
                                <div class="badge-group">
                                    
                                    <c:choose>
                                        <c:when test="${todo.endtype == '1'}"> 
                                            <span class="badge badge-time">🗓️ 기간형</span>
                                        </c:when>
                                        <c:when test="${todo.endtype == '0'}">
                                            <span class="badge badge-goal">🎯 목표형</span>
                                        </c:when>
                                    </c:choose>
                                    
                                    <span class="badge badge-status">${todo.status}</span>
                                </div>
                                
                                <h3 class="plan-title">${todo.title}</h3>
                                
                                <p class="plan-date">
                                    <c:choose>
                                        <c:when test="${todo.endtype == '1'}">
                                            ${todo.startdate} ~ ${todo.enddate} <strong style="color: #dc3545;">(D-${todo.dday})</strong>
                                        </c:when>
									<c:when test="${todo.endtype == '0'}">
									        시작일: ${todo.startdate} 
									        <strong style="color: #007bff;">
									            <c:choose>
									                <%-- 🌟 음수일 때: 시작까지 남은 기간 표시 --%>
									                <c:when test="${todo.progressDays < 0}">
									                    (${todo.progressDays * -1}일 전입니다)
									                </c:when>
									                
									                <%-- 🌟 0이거나 양수일 때: 도전 중 표시 --%>
									                <c:otherwise>
									                    (${todo.progressDays}일째 도전 중)
									                </c:otherwise>
									            </c:choose>
									        </strong>
									    </c:when>
                                    </c:choose>
                                </p>
                            </div>
                            <div style="color: #adb5bd;">&gt;</div>
                        </a>
                    </c:forEach>
                    
                </div>

                <div class="create-btn-wrapper">
                    <a href="create.do" class="btn-create-large">
                        + 새 학습 계획 생성하기
                    </a>
                </div>

            </div>
        </main>
    </div>

</body>
</html>

