<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>스터디 정보 수정 - STUDY 관리</title>
    <style>
        /* 1. 네가 준 예쁜 CSS 그대로 다 살렸어! */
        * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Pretendard', -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif; }
        body { background-color: #f4f7f6; color: #333; }

        .navbar { display: flex; justify-content: space-between; align-items: center; padding: 0 40px; height: 70px; background-color: #ffffff; border-bottom: 1px solid #e9ecef; position: sticky; top: 0; z-index: 100; }
        .logo { font-size: 24px; font-weight: 900; color: #007bff; text-decoration: none; }
        .nav-menu { display: flex; gap: 40px; }
        .nav-menu a { text-decoration: none; color: #555; font-weight: 700; font-size: 16px; }
        .nav-menu a.active { color: #007bff; }
        .logout-btn { padding: 8px 16px; background-color: #f1f3f5; color: #495057; text-decoration: none; border-radius: 6px; font-weight: 600; font-size: 14px; }

        .container { display: flex; max-width: 1200px; margin: 40px auto; gap: 30px; padding: 0 20px; }
        .sidebar { width: 280px; flex-shrink: 0; align-self: flex-start; background-color: #ffffff; border-radius: 12px; padding: 30px 20px; box-shadow: 0 4px 12px rgba(0,0,0,0.03); border: 1px solid #e9ecef; }
        .profile-img { width: 100px; height: 100px; background-color: #e9ecef; border-radius: 50%; margin: 0 auto 15px auto; display: flex; justify-content: center; align-items: center; color: #adb5bd; font-size: 14px; }
        .info-group { text-align: center; margin-bottom: 20px; padding-bottom: 20px; border-bottom: 1px solid #f1f3f5; }
        .info-value.nickname { font-size: 20px; font-weight: 800; color: #212529; margin-bottom: 4px; }
        .info-status { font-size: 13px; color: #adb5bd; }
        .side-menu-list { list-style: none; }
        .side-menu-item { display: block; padding: 12px 15px; color: #495057; text-decoration: none; font-weight: 700; border-radius: 8px; margin-bottom: 5px; transition: all 0.2s; }
        .side-menu-item:hover { background-color: #f8f9fa; }
        .side-menu-item.active { background-color: #f0f7ff; color: #007bff; }

        .main-content { flex: 1; background-color: #ffffff; border-radius: 12px; padding: 40px; box-shadow: 0 4px 12px rgba(0,0,0,0.03); border: 1px solid #e9ecef; }
        .form-header { display: flex; justify-content: space-between; align-items: flex-end; margin-bottom: 30px; border-bottom: 2px solid #212529; padding-bottom: 15px; }
        .form-title { font-size: 24px; font-weight: 800; color: #212529; display: flex; align-items: center; gap: 8px; }
        .btn-back { padding: 8px 16px; font-size: 14px; font-weight: 600; color: #495057; background-color: #f8f9fa; border: 1px solid #ced4da; border-radius: 6px; text-decoration: none; transition: all 0.2s; }

        .form-group { margin-bottom: 25px; }
        .form-row { display: flex; gap: 20px; }
        .form-col { flex: 1; }
        .form-label { display: block; font-size: 15px; font-weight: 700; margin-bottom: 10px; color: #212529; }
        .required { color: #dc3545; margin-left: 3px; }
        .form-control { width: 100%; padding: 12px 15px; font-size: 15px; border: 1px solid #ced4da; border-radius: 6px; outline: none; transition: border-color 0.2s; }
        .form-control:focus { border-color: #007bff; box-shadow: 0 0 0 3px rgba(0, 123, 255, 0.1); }

        .type-selector { display: flex; background-color: #f1f3f5; border-radius: 8px; padding: 5px; max-width: 300px; }
        .type-label { flex: 1; text-align: center; padding: 10px 0; font-weight: 600; color: #6c757d; border-radius: 6px; cursor: pointer; transition: all 0.2s; font-size: 14px; }
        .type-selector input[type="radio"] { display: none; }
        .type-selector input[type="radio"]:checked + .type-label { background-color: #ffffff; color: #007bff; box-shadow: 0 2px 5px rgba(0,0,0,0.1); }

        #techStackContainer { display: flex; flex-direction: column; gap: 10px; }
        .tech-stack-row { display: flex; align-items: center; gap: 10px; max-width: 400px; }
        .tech-select { flex: 1; cursor: pointer; appearance: auto; }
        .btn-icon { width: 44px; height: 44px; border-radius: 6px; border: none; font-size: 20px; font-weight: bold; cursor: pointer; display: flex; justify-content: center; align-items: center; transition: background-color 0.2s; }
        .btn-add { background-color: #e3f2fd; color: #0d6efd; }
        .btn-remove { background-color: #f8d7da; color: #dc3545; }

        .editor-container { border: 1px solid #ced4da; border-radius: 6px; overflow: hidden; }
        .editor-content { width: 100%; min-height: 300px; padding: 15px; font-size: 15px; border: none; resize: vertical; outline: none; line-height: 1.6; }

        .form-actions { margin-top: 40px; display: flex; justify-content: flex-end; gap: 15px; padding-top: 20px; border-top: 1px solid #e9ecef; }
        .btn-action { padding: 12px 30px; font-size: 15px; font-weight: 700; border-radius: 6px; cursor: pointer; text-decoration: none; transition: all 0.2s; }
        .btn-cancel { background-color: #ffffff; color: #495057; border: 1px solid #ced4da; }
        .btn-submit { background-color: #007bff; color: #ffffff; border: none; }
        .hidden { display: none; }
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
        <aside class="sidebar">
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

        <%-- 상단 네비게이션 & 사이드바 생략 (디자인 유지) --%>

<main class="main-content">
    <div class="form-header">
        <h2 class="form-title">✏️ 스터디 정보 수정</h2>
        <span style="font-size: 14px; color: #007bff; font-weight: 600;">현재 참여 인원: ${dto.population}명</span>
    </div>

    <form action="studyEdit.do" method="POST" id="editStudyForm">
        
        <%-- 1. PK값 (Hidden): 이거 없으면 DB에서 누굴 수정할지 몰라! --%>
        <input type="hidden" name="seq_study" value="${dto.seq_study}">

        <div class="form-group">
            <label class="form-label">스터디 제목 <span class="required">*</span></label>
            <%-- DB의 title 출력 --%>
            <input type="text" name="title" class="form-control" value="${dto.title}" required>
        </div>

        <div class="form-row form-group">
            <div class="form-col">
                <label class="form-label">진행 방식 <span class="required">*</span></label>
                <div class="type-selector">
                    <%-- DB의 studyType에 따라 체크 처리 --%>
                    <input type="radio" id="typeOnline" name="studyType" value="ONLINE" ${dto.studyType == '0' ? 'checked' : ''}>
                    <label for="typeOnline" class="type-label">💻 온라인</label>

                    <input type="radio" id="typeOffline" name="studyType" value="OFFLINE" ${dto.studyType == '1' ? 'checked' : ''}>
                    <label for="typeOffline" class="type-label">🏢 오프라인</label>
                </div>
            </div>

            <div class="form-col">
                <label class="form-label">최대 모집 인원 <span class="required">*</span></label>
                <select name="max_population" class="form-control" style="appearance: auto; max-width: 150px;" required>
                    <%-- 2명부터 10명까지 돌리면서 DB의 max_population과 같으면 selected --%>
                    <c:forEach var="i" begin="${dto.population}" end="20">
                        <option value="${i}" ${dto.max_population == i ? 'selected' : ''}>${i}명</option>
                    </c:forEach>
                    
                </select>
                <p>population 확인: ${dto.population}</p>
                <p style="font-size: 12px; color: #dc3545; margin-top: 5px;">* 현재 참여 인원(${dto.now_count}명)보다 적게 설정할 수 없습니다.</p>
            </div>
        </div>

        <%-- 2. 장소 (Offline일 때만 보이게 초기 세팅) --%>
        <div id="locationField" class="form-group ${dto.studyType == 'ONLINE' ? 'hidden' : ''}">
            <label class="form-label">모임 장소 <span class="required">*</span></label>
            <input type="text" name="location" class="form-control" value="${dto.location}">
        </div>

        <%-- 3. 상세 설명 (textarea는 태그 사이에 값을 넣어야 함!) --%>
        <div class="form-group">
            <label class="form-label">스터디 상세 설명 <span class="required">*</span></label>
            <div class="editor-container">
                <%-- DB의 content(또는 detail) 출력 --%>
                <textarea name="content" class="editor-content" required>${dto.content}</textarea>
            </div>
        </div>

        <div class="form-actions">
            <button type="button" class="btn-action btn-cancel" onclick="history.back()">취소</button>
            <button type="submit" class="btn-action btn-submit">수정 완료</button>
        </div>
    </form>
</main>
    </div>

    <script>
        // 🌟 오프라인 장소 토글 스크립트
        const radioOnline = document.getElementById('typeOnline');
        const radioOffline = document.getElementById('typeOffline');
        const locationField = document.getElementById('locationField');

        function toggleLocation() {
            if (radioOffline.checked) locationField.classList.remove('hidden');
            else locationField.classList.add('hidden');
        }
        
        // 초기 로드 시 상태 확인
        window.onload = toggleLocation;
        radioOnline.addEventListener('change', toggleLocation);
        radioOffline.addEventListener('change', toggleLocation);

        // 🌟 기술 스택 동적 추가
        function addTechStack() {
            const container = document.getElementById('techStackContainer');
            const newRow = document.createElement('div');
            newRow.className = 'tech-stack-row';
            newRow.style.marginTop = '10px';
            newRow.innerHTML = `
                <select class="form-control tech-select" name="techStacks[]">
                    <option value="Java">Java</option>
                    <option value="Spring Boot">Spring Boot</option>
                    <option value="JPA">JPA</option>
                    <option value="MySQL">MySQL</option>
                </select>
                <button type="button" class="btn-icon btn-remove" onclick="this.parentElement.remove()">-</button>
            `;
            container.appendChild(newRow);
        }

        // 🌟 폼 전송 확인
        document.getElementById('editStudyForm').onsubmit = function() {
            return confirm("스터디 정보를 이대로 수정할까?");
        };
    </script>
</body>
</html>