<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>

<style>
    body {
        font-family: Arial, sans-serif;
        background-color: #f0f8ff;
        margin: 0;
        padding: 0;
    }

    h3.info-title {
        color: #4682b4;
        text-align: center;
        margin: 20px 0;
    }

    .info-card {
        width: 90%;
        max-width: 500px;
        margin: 0 auto;
        padding: 20px;
        background-color: #ffffff;
        border-radius: 10px;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    }

    /* 회원 정보 섹션 */
    .info-profile-card {
        margin-bottom: 20px;
    }

    .info-profile-card img.info-profile-image {
        display: block;
        margin: 10px auto;
        width: 150px;
        height: 150px;
        border-radius: 50%;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
    }

    .info-item {
        display: flex; /* 라벨과 값을 수평 정렬 */
        justify-content: space-between; /* 라벨 왼쪽, 값 오른쪽 정렬 */
        align-items: center; /* 세로 중앙 정렬 */
        margin-bottom: 15px;
        font-size: 1rem;
    }

    .info-label {
        font-weight: bold;
        width: 40%; /* 라벨 고정 너비 */
        text-align: left; /* 라벨 왼쪽 정렬 */
    }

    .info-value {
        text-align: right; /* 값 오른쪽 정렬 */
        width: 60%; /* 값 고정 너비 */
        color: #333;
    }

    /* 버튼 그룹 스타일 */
    .info-button-group {
        width: 90%;
        max-width: 500px;
        margin: 20px auto;
        text-align: center;
    }

    .info-button-group a {
        display: block;
        margin: 10px auto;
        text-decoration: none;
    }

    .info-button-group button {
        width: calc(100% - 20px);
        max-width: 300px;
        height: 50px;
        margin: 10px auto;
        border: none;
        border-radius: 5px;
        font-size: 14px;
        background-color: #87cefa;
        color: white;
        font-weight: bold;
        cursor: pointer;
        transition: background-color 0.3s;
    }

    .info-button-group button:hover {
        background-color: #4682b4;
    }

    /* 회원 탈퇴 버튼만 토마토색 */
    .info-delete-button {
        width: calc(100% - 20px);
        max-width: 300px;
        height: 50px;
        margin: 10px auto;
        border: none;
        border-radius: 5px;
        font-size: 14px;
       	background-color: tomato !important;
        color: white;
        font-weight: bold;
        cursor: pointer;
        transition: background-color 0.3s;
    }

    .info-delete-button:hover {
        background-color: #e04141; 
    }

    /* 링크 스타일 */
    .info-button-group a {
        color: #4682b4;
        font-weight: bold;
    }

    .info-button-group a:hover {
        text-decoration: underline;
    }
</style>

<h3 class="info-title">회원정보</h3>

<div class="info-card info-profile-card">
    <div>
        <p class="info-label">프로필 이미지</p>
        <img class="info-profile-image" src="${cpath}/upload/${login.memberPhoto != null ? login.memberPhoto : 'default.png'}" alt="프로필 이미지">
    </div>
    <div class="info-item">
        <span class="info-label">닉네임</span>
        <span class="info-value">${login.nickname}</span>
    </div>
    <div class="info-item">
        <span class="info-label">이메일</span>
        <span class="info-value">${login.email}</span>
    </div>
    <div class="info-item">
        <span class="info-label">주소</span>
        <span class="info-value">${login.address}</span>
    </div>
    <div class="info-item">
        <span class="info-label">성별</span>
        <span class="info-value">
            <c:if test="${login.gender == 'M'}">남성</c:if>
            <c:if test="${login.gender == 'F'}">여성</c:if>
            <c:if test="${login.gender == 'U' || empty login.gender}">비공개</c:if>
        </span>
    </div>
</div>

<div class="info-button-group">
    <a href="${cpath}/member/updateInfo">
        <button>기본 정보 수정</button>
    </a>
    <a href="${cpath}/member/updateProfileImage">
        <button>프로필 사진 수정</button>
    </a>
    <c:if test="${login.snsType == null}">
        <a href="${cpath}/member/updatePassword">
            <button>비밀번호 수정</button>
        </a>
    </c:if>
</div>

<form id="infoDeleteForm" action="${cpath}/member/delete" method="POST">
	<div class="info-button-group">
	    <button type="submit" class="info-delete-button">회원 탈퇴</button>
	</div>
</form>


<script>
    document.addEventListener('DOMContentLoaded', function () {
        const deleteForm = document.getElementById('infoDeleteForm')
        if (deleteForm) {
            deleteForm.addEventListener('submit', function (event) {
                event.preventDefault()
                const confirmed = confirm('정말로 탈퇴하시겠습니까?')
                if (confirmed) {
                    deleteForm.submit()
                }
            })
        }
    })
</script>

</body>
</html>
