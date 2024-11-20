<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>

<style>
    body {
        font-family: Arial, sans-serif;
        background-color: #f0f8ff;
        margin: 0;
        padding: 0;
    }

    h3.find-password-title {
        color: #4682b4;
        text-align: center;
        margin-top: 20px;
        margin-bottom: 20px;
    }

    .find-password-form {
        width: 90%;
        max-width: 500px;
        margin: 0 auto;
        padding: 20px;
        background-color: #ffffff;
        border-radius: 10px;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    }

    .find-password-form p {
        margin-bottom: 15px;
    }

    .find-password-form input[type="text"],
    .find-password-form input[type="email"],
    .find-password-form input[type="submit"] {
        width: calc(100% - 20px);
        padding: 10px;
        margin: 5px 0;
        border: 1px solid #d3d3d3;
        border-radius: 5px;
        font-size: 14px;
    }

    .find-password-form input[type="submit"] {
        background-color: lightskyblue;
        color: white;
        border: none;
        cursor: pointer;
        font-weight: bold;
        transition: background-color 0.3s;
    }

    .find-password-form input[type="submit"]:hover {
        background-color: #87cefa;
    }

    #captcha fieldset {
        border: 1px solid #d3d3d3;
        padding: 10px;
        border-radius: 5px;
        text-align: center;
    }

    #captcha img {
        display: block;
        margin: 0 auto 10px;
    }

    #captcha input[type="button"] {
        padding: 5px 10px;
        background-color: #87cefa;
        color: white;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        font-size: 14px;
        transition: background-color 0.3s;
    }

    #captcha input[type="button"]:hover {
        background-color: lightskyblue;
    }
</style>

<h3 class="find-password-title">패스워드 재설정</h3>

<form id="findPasswordForm" class="find-password-form">
    <p>
        <input type="text" name="userid" placeholder="사용자아이디를 입력하세요" autocomplete="off" required autofocus>
    </p>
    <p>
        <input type="email" name="email" placeholder="회원가입 시 설정한 이메일을 입력하세요" autocomplete="off" required>
    </p>
    <div id="captcha"></div>
    <p>
        <input type="submit" value="재발급">
    </p>
</form>

<script>
    async function checkCaptcha() {
        const url = '${cpath}/members/captcha'
        const formData = new FormData(findPasswordForm)
        const opt = {
            method: 'POST',
            body: formData
        }
        const result = await fetch(url, opt).then(resp => resp.json())
        if (result.result == false) {
            swal('캡차 검증 실패', '입력값을 다시 확인해주세요', 'error')
            loadCaptchaHandler()
        }
        return result.result
    }

    async function resetPasswordHandler(event) {
        event.preventDefault()
        const captchaResult = await checkCaptcha()
        if (!captchaResult) {
            return
        }

        const url = '${cpath}/members/findPassword'
        const opt = {
            method: 'POST',
            body: new FormData(event.target)
        }
        const result = await fetch(url, opt).then(resp => resp.json())

        if (result.success) {
            swal({
                title: '비밀번호 재설정',
                text: '이메일로 변경된 비밀번호를 전송했습니다',
                type: 'success',
                confirmButtonText: '확인',
                closeOnConfirm: true
            }, function(isConfirm) {
                if (isConfirm) {
                    location.href = '${cpath}/member/login'
                }
            })
        } else {
            swal('비밀번호 재설정', '일치하는 계정 혹은 이메일을 찾을 수 없습니다', 'error')
        }
    }

    async function loadCaptchaHandler() {
        const url = '${cpath}/members/captcha'
        const result = await fetch(url).then(resp => resp.json())
        let tag = '<fieldset><p>'
        tag += '<img src="${cpath}/upload/captcha/' + result.captchaImage + '" width="300">'
        tag += '<input type="button" name="reload" value="새로고침">'
        tag += '</p>'
        tag += '<input type="text" name="user_captcha" placeholder="그림에 나타난 글자를 입력하세요" required>'
        tag += '</fieldset>'
        document.getElementById('captcha').innerHTML = tag
        document.querySelector('input[name="reload"]').onclick = loadHandler
    }

    function loadHandler() {
        loadCaptchaHandler()
    }

    const findPasswordForm = document.getElementById('findPasswordForm')
    findPasswordForm.addEventListener('submit', resetPasswordHandler)
    window.addEventListener('DOMContentLoaded', loadHandler)
</script>
