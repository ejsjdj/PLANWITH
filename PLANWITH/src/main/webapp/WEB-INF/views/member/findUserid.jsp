<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>

<style>
    body {
        font-family: Arial, sans-serif;
        background-color: #f8faff;
        margin: 0;
        padding: 0;
    }

    h3.find-userid-title {
        text-align: center;
        color: #4682b4;
        margin-top: 20px;
    }

    .find-userid-form {
        width: 90%;
        max-width: 500px;
        margin: 0 auto;
        padding: 20px;
        background-color: #ffffff;
        border-radius: 10px;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    }

    .find-userid-form div {
        margin-bottom: 15px;
    }

    .find-userid-form label {
        display: block;
        font-weight: bold;
        margin-bottom: 5px;
        color: #333;
    }

    .find-userid-form input[type="email"],
    .find-userid-form input[type="text"] {
        width: 100%;
        padding: 10px;
        font-size: 14px;
        border: 1px solid #ccc;
        border-radius: 5px;
        box-sizing: border-box;
    }

    .find-userid-form button {
        display: block;
        width: 100%;
        padding: 10px;
        font-size: 16px;
        font-weight: bold;
        color: #ffffff;
        background-color: lightskyblue; /* 버튼 색상 변경 */
        border: none;
        border-radius: 5px;
        cursor: pointer;
        transition: background-color 0.3s ease;
        margin-top: 10px;
    }

    .find-userid-form button:hover {
        background-color: #87cefa; /* 호버 색상 변경 */
    }

    #find-userid-result {
        width: 90%;
        max-width: 500px;
        margin: 20px auto;
        padding: 10px;
        text-align: center;
        color: #4682b4;
        font-weight: bold;
    }
</style>

<h3 class="find-userid-title">아이디 찾기</h3>

<form id="findUserIdForm" class="find-userid-form" method="POST">
    <div>
        <label for="sendCode">이메일</label>
        <input type="email" name="email" required placeholder="이메일을 입력하세요">
    </div>
    <button type="button" id="requestCodeButton">인증번호 요청</button>

    <div>
        <label for="verificationCode">인증번호</label>
        <input type="text" name="userInputCode" required placeholder="인증번호 입력">
    </div>
    <button type="submit">아이디 찾기</button>
</form>

<div id="find-userid-result"></div>

<script>
    // 인증번호 요청
    async function requestVerificationCode() {
        const email = document.querySelector('input[name="email"]').value
        if (!email) {
            swal("오류", "이메일을 입력해 주세요", "error")
            return
        }
        
        const formData = new FormData()
        formData.append("email", email)
        
        const result = await fetch('${cpath}/members/sendVerificationCode', {
            method: 'POST',
            body: formData
        }).then(resp => resp.json())
        
        swal("알림", result.message, result.success ? "success" : "error")
    }

    // 아이디 찾기
    async function findUserId(event) {
        event.preventDefault()

        const formData = new FormData(event.target)

        const result = await fetch('${cpath}/members/findUserid', {
            method: 'POST',
            body: formData
        }).then(resp => resp.json())

        if (result.success) {
            swal(result.title, result.message, result.icon).then(() => {
                window.location.href = '${cpath}/member/login'
            })
        } else {
            swal(result.title, result.message, result.icon)
        }
    }

    document.getElementById('requestCodeButton').addEventListener('click', requestVerificationCode)
    document.getElementById('findUserIdForm').addEventListener('submit', findUserId)
</script>
