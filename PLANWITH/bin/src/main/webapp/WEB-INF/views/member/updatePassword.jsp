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

    h3.update-password-title {
        text-align: center;
        color: #4682b4;
        margin-top: 20px;
    }

    .update-password-form {
        width: 90%;
        max-width: 500px;
        margin: 0 auto;
        padding: 20px;
        background-color: #ffffff;
        border-radius: 10px;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    }

    .update-password-form div {
        margin-bottom: 15px;
    }

    .update-password-form label {
        display: block;
        font-weight: bold;
        margin-bottom: 5px;
        color: #333;
    }

    .update-password-form input[type="password"] {
        width: 100%;
        padding: 10px;
        font-size: 14px;
        border: 1px solid #ccc;
        border-radius: 5px;
        box-sizing: border-box;
    }

    .update-password-form button {
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

    .update-password-form button:hover {
        background-color: #315f7d;
    }

    .update-password-back-link {
        display: block;
        text-align: center;
        margin: 20px auto;
        color: #4682b4;
        font-weight: bold;
        text-decoration: none;
    }

    .update-password-back-link:hover {
        text-decoration: underline;
    }
</style>

<h3 class="update-password-title">비밀번호 수정</h3>

<form class="update-password-form" action="${cpath}/member/updatePassword" method="POST">
    <div>
        <label>현재 비밀번호</label>
        <input type="password" name="currentPassword" required>
    </div>
    <div>
        <label>새 비밀번호</label>
        <input type="password" name="newPassword" required>
    </div>
    <button type="submit">비밀번호 수정</button>
</form>
<a class="update-password-back-link" href="${cpath}/member/info">돌아가기</a>

<c:if test="${not empty result && not empty message}">
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const result = "${result}"
            const message = "${message}"

            if (result === "true") {
                swal({
                    title: "변경 성공",
                    text: message,
                    icon: "success",
                    button: "확인"
                }).then(function() {
                    location.href = "${cpath}/member/info"
                })
            } else if (result === "false") {
                swal({
                    title: "변경 실패",
                    text: message,
                    icon: "error",
                    button: "확인"
                })
            }
        })
    </script>
</c:if>
</body>
</html>
