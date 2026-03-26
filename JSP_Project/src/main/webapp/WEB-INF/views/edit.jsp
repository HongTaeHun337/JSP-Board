<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>학습계획 수정 - STUDY 커뮤니티</title>
    <style>
        /* create.jsp와 100% 동일한 스타일 적용! */
        * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Pretendard', sans-serif; }
        body { background-color: #f4f7f6; color: #333; }
        a { text-decoration: none; }

        .navbar { display: flex; justify-content: space-between; align-items: center; padding: 0 40px; height: 70px; background-color: #ffffff; box-shadow: 0 2px 5px rgba(0,0,0,0.05); position: sticky; top: 0; z-index: 100; }
        .logo { font-size: 24px; font-weight: 800; color: #007bff; }
        .nav-menu { display: flex; gap: 40px; }
        .nav-menu a { color: #555; font-weight: 600; font-size: 16px; }
        .nav-menu a.active { color: #007bff; }
        .logout-btn { padding: 8px 16px; background-color: #f1f3f5; color: #495057; border-radius: 6px; font-weight: 600; font-size: 14px; }
        .container { display: flex; max-width: 1200px; margin: 40px auto; gap: 30px; padding: 0 20px; }
        .card { background-color: #ffffff; border-radius: 12px; padding: 30px; box-shadow: 0 4px 12px rgba(0,0,0,0.03); }
        .sidebar { width: 300px; flex-shrink: 0; align-self: flex-start; }
        .profile-img { width: 100px; height: 100px; background-color: #e9ecef; border-radius: 50%; margin: 0 auto 15px auto; display: flex; justify-content: center; align-items: center; color: #adb5bd; font-size: 16px; }
        .info-group { text-align: center; }
        .info-value.nickname { font-size: 20px; font-weight: 700; color: #212529; margin-bottom: 20px; }
        
        .main-content { flex: 1; }
        .form-header { font-size: 20px; font-weight: 700; margin-bottom: 30px; padding-bottom: 15px; border-bottom: 1px solid #f1f3f5; }
        
        .form-group { margin-bottom: 25px; }
        .form-group label { display: block; font-size: 14px; font-weight: 700; color: #495057; margin-bottom: 10px; }
        
        .type-toggle { display: inline-flex; background-color: #f1f3f5; border-radius: 8px; padding: 4px; }
        .type-toggle input[type="radio"] { display: none; }
        .type-toggle label.toggle-btn { padding: 10px 24px; border-radius: 6px; cursor: pointer; color: #868e96; font-size: 14px; font-weight: 600; transition: all 0.2s; }
        .type-toggle input[type="radio"]:checked + label.toggle-btn { background-color: #ffffff; color: #212529; box-shadow: 0 2px 5px rgba(0,0,0,0.05); }

        input[type="text"], input[type="date"], textarea { width: 100%; padding: 12px 15px; border: 1px solid #ced4da; border-radius: 8px; font-size: 14px; outline: none; transition: border-color 0.2s; color: #333; }
        input[type="text"]:focus, input[type="date"]:focus, textarea:focus { border-color: #007bff; }
        input::placeholder, textarea::placeholder { color: #adb5bd; }
        textarea { height: 120px; resize: none; line-height: 1.5; }
        
        .date-group { display: flex; align-items: center; gap: 10px; max-width: 400px; }
        .date-separator { color: #868e96; font-weight: bold; }

        .btn-group { display: flex; gap: 10px; margin-top: 40px; }
        .btn { padding: 12px 30px; border-radius: 6px; font-size: 15px; font-weight: 700; cursor: pointer; text-align: center; border: none; }
        .btn-cancel { background-color: #ffffff; color: #495057; border: 1px solid #ced4da; }
        .btn-cancel:hover { background-color: #f8f9fa; }
        .btn-submit { background-color: #007bff; color: white; }
        .btn-submit:hover { background-color: #0056b3; }
        
        /* 추가: 경고 문구 스타일 */
        .warning-text { font-size: 12px; color: #dc3545; margin-top: 8px; font-weight: 500; }
    </style>
</head>
<body>

    <header class="navbar">
        <a href="index.do" class="logo">STUDY</a>
        <nav class="nav-menu">
            <a href="#">커뮤니티</a>
            <a href="index.do" class="active">학습계획</a>
            <a href="#">스터디</a>
        </nav>
        <a href="#" class="logout-btn">로그아웃</a>
    </header>

    <div class="container">
        
        <aside class="sidebar card">
            <div class="profile-img">사진</div>
            <div class="info-group">
                <div class="info-value nickname">개발왕초보</div>
                <p style="font-size: 14px; color: #6c757d;">오늘도 화이팅하세요!</p>
            </div>
        </aside>

        <main class="main-content card">
            <h2 class="form-header">학습계획 수정</h2>

            <%-- 🌟 action을 edit.do로 변경! --%>
            <form action="edit.do" method="POST">
                
                <%-- 🌟 아주 중요! 수정할 글 번호를 숨겨서 보냄 --%>
                <input type="hidden" name="seq_plan" value="${dto.seq_plan}">
                
                <div class="form-group">
                    <label>계획 유형을 선택해주세요</label>
                    <div class="type-toggle">
                        <%-- DB값에 맞춰서 checked 처리 & 수정 못하게 onclick="return false;" 추가 --%>
                        <input type="radio" id="type_period" name="endtype" value="1" ${dto.endtype == '1' ? 'checked' : ''} onclick="return false;">
                        <label for="type_period" class="toggle-btn" style="cursor: default;">🗓️ 기간형</label>
                        
                        <input type="radio" id="type_goal" name="endtype" value="0" ${dto.endtype == '0' ? 'checked' : ''} onclick="return false;">
                        <label for="type_goal" class="toggle-btn" style="cursor: default;">🎯 목표형</label>
                    </div>
                    <p class="warning-text">* 학습이 시작된 계획의 유형은 변경할 수 없습니다.</p>
                </div>

                <div class="form-group">
                    <label>학습계획명</label>
                    <%-- 기존 데이터 세팅 --%>
                    <input type="text" name="title" value="${dto.title}" required>
                </div>

                <div class="form-group" id="goalGroup" style="display: none;">
                    <label>최종 달성 목표</label>
                    <%-- 기존 데이터 세팅 --%>
                    <input type="text" name="goal" id="goalInput" value="${dto.goal}">
                </div>

                <div class="form-group">
                    <label id="dateLabel">학습기간</label>
                    <div class="date-group">
                        <%-- 기존 데이터 세팅 --%>
                        <input type="date" name="startdate" value="${dto.startdate}" required>
                        <span class="date-separator" id="dateSeparator">~</span>
                        <input type="date" name="enddate" id="endDateInput" value="${dto.enddate}">
                    </div>
                    <p id="goalDesc" style="display: none; font-size: 13px; color: #868e96; margin-top: 8px;">언제부터 시작할지만 정해두고, 최종 목표 달성 여부에 집중합니다.</p>
                </div>

                <div class="form-group">
                    <label>상세설명 / 다짐</label>
                    <%-- 🌟 textarea는 태그 사이에 값을 넣어야 함 --%>
                    <textarea name="detail" required>${dto.detail}</textarea>
                </div>

                <div class="btn-group">
                    <button type="button" class="btn btn-cancel" onclick="location.href='view.do?seq=${dto.seq_plan}'">취소</button>
                    <button type="submit" class="btn btn-submit">수정 내용 저장</button>
                </div>
            </form>
        </main>
    </div>

    <script>
        // 화면을 제어하는 함수 (create.jsp와 동일)
        function toggleForm(isPeriod) {
            const endDateInput = document.getElementById('endDateInput');
            const separator = document.getElementById('dateSeparator');
            const goalGroup = document.getElementById('goalGroup');
            const goalInput = document.getElementById('goalInput');
            const dateLabel = document.getElementById('dateLabel');
            const goalDesc = document.getElementById('goalDesc');
            
            if (isPeriod) {
                // 🗓️ 기간형일 때
                endDateInput.style.display = 'block';
                separator.style.display = 'block';
                endDateInput.required = true;
                
                goalGroup.style.display = 'none';   
                goalInput.required = false;         
                
                dateLabel.innerText = '학습기간';     
                goalDesc.style.display = 'none';    
            } else {
                // 🎯 목표형일 때
                endDateInput.style.display = 'none';
                separator.style.display = 'none';
                endDateInput.required = false;
                
                goalGroup.style.display = 'block';  
                goalInput.required = true;          
                
                dateLabel.innerText = '시작일';       
                goalDesc.style.display = 'block';   
            }
        }

        // 🌟 여기가 핵심 꿀팁! 🌟
        // 페이지가 처음 열리자마자, DB에 저장된 유형(기간형/목표형)에 맞게 폼 모양을 세팅해 줘!
        window.onload = function() {
            // dto.endtype이 '1'이면 true(기간형), 아니면 false(목표형)를 toggleForm에 넘김
            toggleForm(${dto.endtype == '1'});
        };
    </script>
</body>
</html>