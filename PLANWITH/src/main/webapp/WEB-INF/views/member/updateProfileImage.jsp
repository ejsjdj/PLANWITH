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

    .update-profile-container {
        max-width: 500px;
        margin: 30px auto;
        padding: 20px;
        background-color: #ffffff;
        border-radius: 10px;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        text-align: center;
    }

    .update-profile-title {
        color: #4682b4;
        margin-bottom: 20px;
        font-size: 1.5rem;
        font-weight: bold;
    }

    .update-profile-img {
        margin: 20px auto;
        border-radius: 50%;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    }

    .update-profile-form label {
        font-weight: bold;
        display: block;
        margin: 20px 0 10px;
        font-size: 1rem;
        color: #333;
    }

    .update-profile-form input[type="file"] {
        display: block;
        margin: 10px auto;
        font-size: 0.9rem;
    }

    .update-profile-button {
        background-color: #87cefa;
        color: #fff;
        border: none;
        border-radius: 5px;
        padding: 10px 20px;
        font-size: 1rem;
        cursor: pointer;
        transition: background-color 0.3s;
    }

    .update-profile-button:hover {
        background-color: #4682b4;
    }

    .update-profile-back-link {
        display: block;
        margin-top: 20px;
        font-size: 0.9rem;
        color: #4682b4;
        text-decoration: none;
        font-weight: bold;
    }

    .update-profile-back-link:hover {
        text-decoration: underline;
    }
        .update-profile-img {
        margin: 20px auto; /* 이미지 위아래 여백 */
        border-radius: 50%; /* 둥근 이미지 */
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2); /* 그림자 효과 */
        width: 150px; /* 고정된 너비 */
        height: 150px; /* 고정된 높이 */
        object-fit: cover; /* 이미지 비율 유지하며 잘림 */
    }

    .update-profile-form input[type="file"] {
        display: block; /* 가운데 정렬 */
        margin: 20px auto; /* 상하 여백 추가 */
        font-size: 0.9rem; /* 텍스트 크기 */
        padding: 10px; /* 안쪽 여백 */
        border: 1px solid #ccc; /* 테두리 */
        border-radius: 5px; /* 둥근 모서리 */
        width: 80%; /* 입력 필드 너비 */
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1); /* 그림자 효과 */
        cursor: pointer; /* 커서 변경 */
        transition: border-color 0.3s, box-shadow 0.3s; 
    }

    .update-profile-form input[type="file"]:hover {
        border-color: #4682b4; 
        box-shadow: 0 2px 6px rgba(0, 0, 0, 0.3); 
    }
    
    
</style>

<div class="update-profile-container">
    <h3 class="update-profile-title">프로필 사진 수정</h3>
    <form class="update-profile-form" action="${cpath}/member/updateProfileImage" method="POST" enctype="multipart/form-data">
        <label for="upload">새 프로필 이미지</label>
        <img class="update-profile-img" src="${cpath}/upload/${login.memberPhoto != null ? login.memberPhoto : 'default.png'}" alt="Current Profile Image" width="100">
        <input type="file" id="upload" name="upload" accept="image/*" required>
        <button type="submit" class="update-profile-button">사진 수정</button>
    </form>
    <a href="${cpath}/member/info" class="update-profile-back-link">돌아가기</a>
</div>

</body>
</html>
