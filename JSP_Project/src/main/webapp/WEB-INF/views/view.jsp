<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>${dto.title} - 상세조회</title>
    <style>
        /* 기본 스타일 (index, create와 동일) */
        * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Pretendard', sans-serif; }
        body { background-color: #f4f7f6; color: #333; }
        a { text-decoration: none; }

        /* 네비게이션 & 레이아웃 (공통) */
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

        /* 🌟 상세조회 전용 스타일 (기획서 반영) */
        .main-content { flex: 1; }
        
        /* 1, 2. 해더 영역 */
        .view-header { border-bottom: 2px solid #f1f3f5; padding-bottom: 20px; margin-bottom: 25px; }
        .badge-group { display: flex; gap: 8px; margin-bottom: 15px; }
        .badge { padding: 4px 8px; border-radius: 4px; font-size: 12px; font-weight: 600; }
        .badge-time { background-color: #e3f2fd; color: #0d6efd; }
        .badge-goal { background-color: #f8d7da; color: #dc3545; }
        .badge-status { background-color: #d1e7dd; color: #198754; }
        .plan-title { font-size: 24px; font-weight: 800; color: #212529; }

        /* 3. 인포박스 영역 */
        .info-box { background-color: #f8f9fa; border-radius: 8px; padding: 20px; margin-bottom: 25px; display: flex; flex-direction: column; gap: 10px; font-size: 14px; }
        .info-row { display: flex; }
        .info-label { width: 80px; color: #868e96; font-weight: 600; }
        .info-value { color: #212529; font-weight: 500; }
        .dday-tag { color: #0d6efd; font-weight: 700; margin-left: 10px; }

        /* 4. 나의 다짐 영역 */
        .section-title { font-size: 14px; font-weight: 700; color: #495057; margin-bottom: 10px; }
        .detail-content { border: 1px solid #ced4da; border-radius: 8px; padding: 20px; font-size: 14px; line-height: 1.6; color: #495057; min-height: 100px; margin-bottom: 30px; }

        /* 5. 달성률 & 기록 영역 (뼈대만 작업) */
        .progress-section { border: 1px solid #ced4da; border-radius: 8px; padding: 25px; margin-bottom: 30px; }
        .progress-header { text-align: center; margin-bottom: 20px; }
        .progress-text { font-size: 16px; font-weight: 700; color: #212529; }
        .progress-percent { font-size: 20px; color: #0d6efd; }
        .progress-desc { font-size: 13px; color: #868e96; margin-top: 5px; }
        
        /* 임시 프로그레스바 */
        .progress-bar-bg { width: 100%; height: 10px; background-color: #e9ecef; border-radius: 5px; overflow: hidden; margin-bottom: 30px; }
        .progress-bar-fill { width: 45%; height: 100%; background-color: #0d6efd; }

        /* 학습 기록 입력 & 리스트 (디자인 뼈대) */
        .record-title { font-size: 14px; font-weight: 700; color: #495057; margin-bottom: 10px; display: flex; align-items: center; gap: 5px; }
        .record-input-group { display: flex; gap: 10px; margin-bottom: 15px; }
        .record-date { width: 130px; padding: 10px; border: 1px solid #ced4da; border-radius: 4px; font-size: 13px; }
        .record-text { flex: 1; padding: 10px; border: 1px solid #ced4da; border-radius: 4px; font-size: 13px; }
        .btn-record { padding: 10px 20px; background-color: #0d6efd; color: white; border: none; border-radius: 4px; font-weight: 600; cursor: pointer; font-size: 13px; }
        
        .record-list { display: flex; flex-direction: column; gap: 8px; }
        .record-item { background-color: #f8f9fa; border-radius: 4px; padding: 12px 15px; display: flex; justify-content: space-between; font-size: 13px; }
        .record-item-date { color: #868e96; font-weight: 600; margin-right: 15px; }
        .record-item-text { color: #212529; flex: 1; }
        .record-item-delete { color: #adb5bd; cursor: pointer; }

        /* 하단 버튼 영역 */
        .btn-group { display: flex; justify-content: space-between; margin-top: 40px; }
        .btn { padding: 10px 20px; border-radius: 4px; font-size: 14px; font-weight: 600; cursor: pointer; border: none; }
        .btn-list { background-color: #f8f9fa; color: #495057; border: 1px solid #ced4da; }
        .right-btns { display: flex; gap: 10px; }
        .btn-edit { background-color: #ffffff; color: #0d6efd; border: 1px solid #0d6efd; }
        .btn-delete { background-color: #ffffff; color: #dc3545; border: 1px solid #dc3545; }

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
                <div class="info-value nickname">개발왕초보</div> <p style="font-size: 14px; color: #6c757d;">오늘도 화이팅하세요!</p>
            </div>
        </aside>

        <main class="main-content card">
            
            <div class="view-header">
                <div class="badge-group">
                    <c:choose>
                        <c:when test="${dto.endtype == '1'}">
                            <span class="badge badge-time">🗓️ 기간형</span>
                        </c:when>
                        <c:otherwise>
                            <span class="badge badge-goal">🎯 목표형</span>
                        </c:otherwise>
                    </c:choose>
                    <span class="badge badge-status">${dto.status}</span> </div>
                <h1 class="plan-title">${dto.title}</h1>
            </div>

            <div class="info-box">
		    <div class="info-row">
		        <span class="info-label">학습 기간</span>
		        <span class="info-value">
		            <c:choose>
		                <%-- 🗓️ 기간형일 때: 시작일 ~ 종료일 (디데이) --%>
		                <c:when test="${dto.endtype == '1'}">
		                    ${dto.startdate} ~ ${dto.enddate} 
		                    
		                    <%-- 🌟 디데이 로직  여기 들어감! --%>
		                    <c:choose>
		                        <c:when test="${dto.dday == 0}">
		                            <span class="dday-tag">(D-Day ✨)</span>
		                        </c:when>
		                        <c:when test="${dto.dday > 0}">
		                            <span class="dday-tag">(D-${dto.dday})</span>
		                        </c:when>
		                        <c:otherwise>
		                            <span class="dday-tag">(종료됨)</span>
		                        </c:otherwise>
		                    </c:choose>
		                </c:when>
		                
		                <%-- 🎯 목표형일 때: 시작일 (진행일) --%>
		                <c:otherwise>
		                    ${dto.startdate} 부터 
		                    <span class="dday-tag">
		                        <c:choose>
		                            <c:when test="${dto.progressDays < 0}">
		                                (${dto.progressDays * -1}일 전입니다)
		                            </c:when>
		                            <c:otherwise>
		                                (${dto.progressDays}일째 도전 중)
		                            </c:otherwise>
		                        </c:choose>
		                    </span>
		                </c:otherwise>
		            </c:choose>
		        </span>
		    </div>

    <%-- 🌟 등록일 출력 부분 --%>
    <div class="info-row">
        <span class="info-label">등록일</span>
        <span class="info-value">${dto.regdate}</span> 
	    </div>
	
	    <c:if test="${not empty dto.goal}">
	        <div class="info-row">
	            <span class="info-label">최종 목표</span>
	            <span class="info-value">${dto.goal}</span>
	        </div>
	    </c:if>
	</div>

    <div class="form-group">
		<h3 class="section-title">나의 다짐</h3>
        <div class="detail-content">
        	${dto.detail}
		</div>
	</div>
            <div class="progress-section">
		<c:if test ="${dto.endtype == '1' }">
           
   			 <div class="progress-header">
        <%-- 1. 퍼센트 수치 동적 적용 --%>
        <div class="progress-text">현재 달성률 <span class="progress-percent">${dto.percent}%</span></div>
        
        <%-- 2. 설명 문구 동적 적용 --%>
        <div class="progress-desc">
           <div class="progress-desc">오늘까지 전체 기간의 ${dto.percent}%가 지났습니다.</div>
        </div>
    </div>
    
    <%-- 3. 프로그레스바 게이지 동적 적용 --%>
    <div class="progress-bar-bg">
        <div class="progress-bar-fill" style="width: ${dto.percent}%; transition: width 0.5s ease-in-out;"></div>
    </div>
    </c:if>

    <div class="record-area">
        <h3 class="record-title">✍️ 학습 기록 남기기</h3>
        

        
        <form action="historyAdd.do" method="POST">
            <input type="hidden" name="seq_plan" value="${dto.seq_plan}">
            <div class="record-input-group">
                <input type="date" name="studydate" class="record-date" required>
                <input type="text" name="detail" class="record-text" placeholder="어떤 학습을 진행했나요?" required>
                <button type="submit" class="btn-record">등록</button>
            </div>
        </form>
		
		        <div class="record-list">
                    <c:choose>
                        <c:when test="${not empty hlist}">
                            <c:forEach items="${hlist}" var="history">
                                <div class="record-item">
                                    <span class="record-item-date">${history.studydate}</span>
                                    <span class="record-item-text">${history.detail}</span>
                                    <span class="record-item-delete" onclick="location.href='historyDel.do?seq=${history.seq_plan_history}&pseq=${dto.seq_plan}'">삭제</span>
                                </div>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <div class="record-item" style="justify-content: center; color: #adb5bd;">
                                아직 기록된 학습 내용이 없습니다. 첫 기록을 남겨보세요!
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
                
                <%-- 🌟 여기에 페이징 바 출력! --%>
                ${pagebar}

            </div>
		    </div>
		</div>	

    <div class="btn-group">
		<button type="button" class="btn btn-list" onclick="location.href='index.do'">목록으로</button>
			<div class="right-btns">
				<%-- 🌟 2. 수정 버튼: 본인(세션 seq_user == 작성자 dto.seq_user)일 때만 --%>
               	<c:if test="${sessionScope.seq_user == dto.seq_user}">
              		<button type="button" class="btn btn-edit" onclick="location.href='edit.do?seq=${dto.seq_plan}'">수정</button>
               	</c:if>

            	<%-- 🌟 3. 삭제 버튼: 본인이거나 관리자일 때 --%>
             	<c:if test="${sessionScope.seq_user == dto.seq_user or sessionScope.authority == '0'}">
                  	<button type="button" class="btn btn-delete" onclick="if(confirm('정말 삭제하시겠습니까?')) location.href='delete.do?seq=${dto.seq_plan}'">삭제</button>
           		</c:if>
			</div>
	</div>

        </main>
    </div>

</body>
</html>