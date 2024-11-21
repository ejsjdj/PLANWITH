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

    h3.update-info-title {
        text-align: center;
        color: #4682b4;
        margin-top: 20px;
    }

    .update-info-form {
        width: 90%;
        max-width: 500px;
        margin: 0 auto;
        padding: 20px;
        background-color: #ffffff;
        border-radius: 10px;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    }

    .update-info-form div {
        margin-bottom: 15px;
    }

    .update-info-form label {
        display: block;
        font-weight: bold;
        margin-bottom: 5px;
        color: #333;
    }

    .update-info-form input[type="text"],
    .update-info-form input[type="email"],
    .update-info-form select {
        width: 100%;
        padding: 10px;
        font-size: 14px;
        border: 1px solid #ccc;
        border-radius: 5px;
        box-sizing: border-box;
    }

    .update-info-form button {
        display: block;
        width: 100%;
        padding: 10px;
        font-size: 16px;
        font-weight: bold;
        color: #ffffff;
        background-color: #4682b4;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        transition: background-color 0.3s ease;
    }

    .update-info-form button:hover {
        background-color: #315f7d;
    }

    .update-info-back-link {
        display: block;
        text-align: center;
        margin: 20px auto;
        color: #4682b4;
        font-weight: bold;
        text-decoration: none;
    }

    .update-info-back-link:hover {
        text-decoration: underline;
    }
</style>

<h3 class="update-info-title">기본 정보 수정</h3>

<form class="update-info-form" method="POST">
    <div>
        <label>닉네임</label>
        <input type="text" name="nickname" value="${login.nickname}" required>
    </div>
    <div>
        <label>이메일</label>
        <input type="email" name="email" value="${login.email}" required>
    </div>
    <div>
        <label>주소</label>
        <input type="text" name="address" placeholder="주소를 검색하세요" value="${login.address}" autocomplete="off" required>
    </div>
    <div>
        <label>성별</label>
        <select name="gender">
            <option value="M" ${login.gender == 'M' ? 'selected' : ''}>남성</option>
            <option value="F" ${login.gender == 'F' ? 'selected' : ''}>여성</option>
            <option value="U" ${login.gender == 'U' || empty login.gender ? 'selected' : ''}>비공개</option>
        </select>
    </div>
    <button type="submit">정보 수정</button>
</form>
<a class="update-info-back-link" href="${cpath}/member/info">돌아가기</a>

<script>
    function onComplete(data) {
        document.querySelector('input[name="address"]').value = data.address
    }
    
    function execDaumPostcode() {
        const postCode = new daum.Postcode({
            oncomplete: onComplete
        })
        postCode.open()
    }
    document.querySelector('input[name="address"]').onclick = execDaumPostcode
</script>

</body>
</html>
