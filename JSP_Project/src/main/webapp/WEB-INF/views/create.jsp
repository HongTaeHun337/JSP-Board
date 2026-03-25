<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>새 학습계획 생성 - STUDY 커뮤니티</title>
    <style>
        /* 기본 스타일 (index랑 동일) */
        * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Pretendard', sans-serif; }
        body { background-color: #f4f7f6; color: #333; }
        a { text-decoration: none; }

        /* 상단 네비게이션 & 전체 레이아웃 (index랑 동일) */
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
        
        /* 🌟 입력 폼 전용 스타일 (기획서 반영) */
        .main-content { flex: 1; }
        .form-header { font-size: 20px; font-weight: 700; margin-bottom: 30px; padding-bottom: 15px; border-bottom: 1px solid #f1f3f5; }
        
        .form-group { margin-bottom: 25px; }
        .form-group label { display: block; font-size: 14px; font-weight: 700; color: #495057; margin-bottom: 10px; }
        
        /* 토글 라디오 버튼 스타일 */
        .type-toggle { display: inline-flex; background-color: #f1f3f5; border-radius: 8px; padding: 4px; }
        .type-toggle input[type="radio"] { display: none; }
        .type-toggle label.toggle-btn { padding: 10px 24px; border-radius: 6px; cursor: pointer; color: #868e96; font-size: 14px; font-weight: 600; transition: all 0.2s; }
        .type-toggle input[type="radio"]:checked + label.toggle-btn { background-color: #ffffff; color: #212529; box-shadow: 0 2px 5px rgba(0,0,0,0.05); }

        /* 인풋창 스타일 */
        input[type="text"], input[type="date"], textarea { width: 100%; padding: 12px 15px; border: 1px solid #ced4da; border-radius: 8px; font-size: 14px; outline: none; transition: border-color 0.2s; }
        input[type="text"]:focus, input[type="date"]:focus, textarea:focus { border-color: #007bff; }
        input::placeholder, textarea::placeholder { color: #adb5bd; }
        textarea { height: 120px; resize: none; }
        
        /* 날짜 입력 영역 (가로 배치) */
        .date-group { display: flex; align-items: center; gap: 10px; max-width: 400px; }
        .date-separator { color: #868e96; font-weight: bold; }

        /* 하단 버튼 영역 */
        .btn-group { display: flex; gap: 10px; margin-top: 40px; }
        .btn { padding: 12px 30px; border-radius: 6px; font-size: 15px; font-weight: 700; cursor: pointer; text-align: center; border: none; }
        .btn-cancel { background-color: #ffffff; color: #495057; border: 1px solid #ced4da; }
        .btn-cancel:hover { background-color: #f8f9fa; }
        .btn-submit { background-color: #007bff; color: white; }
        .btn-submit:hover { background-color: #0056b3; }

    </style>
</head>
<body>

    <header class="navbar">
        <a href="/" class="logo">STUDY</a>
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
                <div class="info-value nickname">${userInfo.nickname}</div>
                <p style="font-size: 14px; color: #6c757d;">오늘도 화이팅하세요!</p>
            </div>
        </aside>

        <main class="main-content card">
            <h2 class="form-header">새 학습계획 만들기</h2>

            <form action="create.do" method="POST">
                
                <div class="form-group">
                    <label>계획 유형을 선택해주세요</label>
                    <div class="type-toggle">
                        <input type="radio" id="type_period" name="endtype" value="1" checked onchange="toggleForm(true)">
                        <label for="type_period" class="toggle-btn">🗓️ 기간형</label>
                        
                        <input type="radio" id="type_goal" name="endtype" value="0" onchange="toggleForm(false)">
                        <label for="type_goal" class="toggle-btn">🎯 목표형</label>
                    </div>
                </div>

                <div class="form-group">
                    <label>학습계획명</label>
                    <input type="text" name="title" placeholder="예: 자바 스프링 완전 정복" required>
                </div>

                <div class="form-group" id="goalGroup" style="display: none;">
                    <label>최종 달성 목표</label>
                    <input type="text" name="goal" id="goalInput" placeholder="예: 정보처리기사 실기 합격, 책 1권 완독">
                </div>

                <div class="form-group">
                    <label id="dateLabel">학습기간</label>
                    <div class="date-group">
                        <input type="date" name="startdate" required>
                        <span class="date-separator" id="dateSeparator">~</span>
                        <input type="date" name="enddate" id="endDateInput">
                    </div>
                    <p id="goalDesc" style="display: none; font-size: 13px; color: #868e96; margin-top: 8px;">언제부터 시작할지만 정해두고, 최종 목표 달성 여부에 집중합니다.</p>
                </div>

                <div class="form-group">
                    <label>상세설명 / 다짐</label>
                    <textarea name="detail" placeholder="이번 학습을 통해 얻고 싶은 것이나 각오를 적어주세요."></textarea>
                </div>

                <input type="hidden" name="topic" value="기본주제">
                <div class="btn-group">
                    <button type="button" class="btn btn-cancel" onclick="location.href='index.do'">취소</button>
                    <button type="submit" class="btn btn-submit">생성하기</button>
                </div>
            </form>
        </main>
    </div>

    <script>
        // 기간형/목표형 클릭할 때마다 화면 요소를 껐다 켰다 해주는 마법의 스크립트!
        function toggleForm(isPeriod) {
            const endDateInput = document.getElementById('endDateInput');
            const separator = document.getElementById('dateSeparator');
            
            // 새로 추가된 요소들
            const goalGroup = document.getElementById('goalGroup');
            const goalInput = document.getElementById('goalInput');
            const dateLabel = document.getElementById('dateLabel');
            const goalDesc = document.getElementById('goalDesc');
            
            if (isPeriod) {
                // 🗓️ 기간형일 때 (원상복구)
                endDateInput.style.display = 'block';
                separator.style.display = 'block';
                endDateInput.required = true;
                
                goalGroup.style.display = 'none';   // 목표칸 숨기기
                goalInput.required = false;         // 필수 입력 해제
                
                dateLabel.innerText = '학습기간';     // 라벨 원상복구
                goalDesc.style.display = 'none';    // 설명글 숨기기
            } else {
                // 🎯 목표형일 때
                endDateInput.style.display = 'none';
                separator.style.display = 'none';
                endDateInput.value = '';            // 날짜 지워주기
                endDateInput.required = false;
                
                goalGroup.style.display = 'block';  // 목표칸 보여주기!
                goalInput.required = true;          // 목표형이니까 무조건 입력하게 만들기!
                
                dateLabel.innerText = '시작일';       // 라벨 변경
                goalDesc.style.display = 'block';   // 설명글 보여주기!
            }
        }
    </script>
</body>
</html>