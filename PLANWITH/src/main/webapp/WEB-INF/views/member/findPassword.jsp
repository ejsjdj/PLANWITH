<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>

<style>
    body {
        margin: 0;
        padding: 0;
    }

    .findPassword-title {
       font-size: 1.3rem;
        margin-bottom: 2rem;
    }
    
   	#findPasswordForm {
        width: 90%;
        max-width: 350px;
        margin: 4rem auto;
        margin-top: 8rem;
        padding: 3rem 5rem;
        background-color: #ffffff;
        border-radius: 10px;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    }
    
    #findPasswordForm div{
        margin-bottom: 15px;
    }
    
    #findPasswordForm .group label {
       width: 100%; /* 이미 적용된 스타일 */
       display: block; /* 줄 전체를 차지하도록 */
       text-align: left; /* 텍스트 왼쪽 정렬 */
   }
   
   #findPasswordForm .group:nth-last-of-type(1) p {  
      display: flex;
      align-items: center;
      justify-content: space-between;
   }
   
   #findPasswordForm .group:nth-last-of-type(1) p span{
       display: inline-flex;
       justify-content: space-between;
   }

   #findPasswordForm .group:nth-last-of-type(1) p span:nth-of-type(1)
    {
       display: block;
       width: 100%; 
       margin-right: 0.8rem;
   }

   #findPasswordForm .group:nth-last-of-type(1) .submit {
      margin-top: 0;
   }
   
   #findPasswordForm #reloadBtn {
       font-size: 0.8rem; 
       padding: 0.62rem 0.8rem;
       margin-top: 0px;
   }

    #findPasswordForm input {       
       margin-bottom: 15px; 
    } 
    
    #findPasswordForm .group p {
        margin-top: 2px;
    }
    
    #findPasswordForm .group label {
          transition-duration: 0.3s;
    }
    
    #findPasswordForm .input,
    #findPasswordForm .submit {
        width: calc(100%);
        padding: 10px;
        margin: 5px auto;
        border: 1px solid #d3d3d3;
        border-radius: 5px;
        font-size: 1rem;
        box-sizing: border-box;
    }
    
    #findPasswordForm .input {
       margin-top: 0px;
    }
    
    #findPasswordForm .input:focus {
       border-color: #B1C9EF;
       outline: none;
    }

    #findPasswordForm fieldset {
    	border-radius: 5px;
    	border: 1px solid #d3d3d3;
    }
    
    #findPasswordForm fieldset img {
       width: 100%;
    }
    
    .flex {
       display: flex;
       align-items: center;
       margin-bottom: 0;
    }
    
   #findPasswordForm .flex .group {
       display: flex;
       align-items: center;
       margin-bottom: 0;
       font-size: 0.85rem;
        font-weight: 400;
        text-decoration: none;
        text-align: center;
   }
   
   #findPasswordForm .flex .group input {
      margin: auto 0.5rem;
   }
    
   #findPasswordForm .flex .group:nth-of-type(1) input {
      margin-left: 0;
   }
    
    #findPasswordForm .submit {
        background-color: #628ECB;
        color: white;
        border: none;
        cursor: pointer;
        transition: background-color 0.3s;
    }

    #findPasswordForm .submit:hover {
        background-color: pink;
    }
    
    #findPasswordForm .right {
       text-align: right;   
    }

    .small-point {
       font-size: 0.75rem;
       color: #081F5C;
        font-weight: 500;
        text-decoration: none;
    }
    
    .small-grey {
       font-size: 0.75rem;
/*        color: #adb5bd; */
       color: #999999;
/*        color: #868e90; */
        font-weight: 400;
        text-decoration: none;
        text-align: center;
    }
    
    .margin  {
       margin: 1rem;
    }
    
    a:hover {
        text-decoration: underline;
    }
    
</style>
   

<form id="findPasswordForm" class="find-password-form">
   <h3 class="findPassword-title">비밀번호 재설정</h3>
   <div class="group">
       <label for="findPassword-userid" class="small-grey">사용자 아이디를 입력해주세요</label>
       <p><input id="findPassword-userid" class="input" type="text" name="userid" autocomplete="off" required autofocus></p>
   </div>
   <div class="group">
       <label for="findPassword-email" class="small-grey">설정한 이메일을 입력해주세요</label>
       <p><input id="findPassword-email" class="input" type="email" name="email"  autocomplete="off" required></p>
   </div>
    <div id="captcha"></div>
    <p>
        <input class="submit" type="submit" value="재발급">
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
      tag += '<div class="group">'
      tag += '<label for="findPassword-captcha" class="small-grey">그림에 나타난 글자를 입력하세요</label>'
      tag += '<p><span><input id="findPassword-captcha" class="input" type="text" name="captcha" required></span>'
      tag += '<span><input id="reloadBtn" class="submit" type="button" name="reload" value="새로고침"></span></p>'
      tag += '</div>'
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

<!-- 스타일 스크립트 -->
<script>
	document.querySelectorAll('#findPasswordForm .group').forEach((group) => {
	    const input = group.querySelector('.input')
	    const label = group.querySelector('.small-grey')
	
	    input.addEventListener('focus', () => {
	        label.style.color = '#B1C9EF'
	    })
		// blur는 focus가 벗어나면 발생하는 이벤트
	    input.addEventListener('blur', () => {	
	        label.style.color = ''
	    })
	})
</script>
