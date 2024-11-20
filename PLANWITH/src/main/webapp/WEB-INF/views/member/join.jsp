<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>

<style>
    body {
        margin: 0;
        padding: 0;
    }
    .join-title {
       font-size: 1.3rem;
        margin-bottom: 2rem;
    }
    #joinForm {
        width: 90%;
        max-width: 350px;
        margin: 4rem auto;
        padding: 3rem 5rem;
        background-color: #ffffff;
        border-radius: 10px;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    }
    #joinForm div{
        margin-bottom: 15px;
    }
    
    #joinForm .group label {
       width: 100%; /* 이미 적용된 스타일 */
       display: block; /* 줄 전체를 차지하도록 */
       text-align: left; /* 텍스트 왼쪽 정렬 */
   }
   
   #joinForm .group:nth-of-type(1) p,
   #joinForm .group:nth-last-of-type(1) p {   /* 아이디 그룹 */
      display: flex;
      align-items: center;
      justify-content: space-between;
   }
   
   #joinForm .group:nth-of-type(1) p span, 
   #joinForm .group:nth-last-of-type(1) p span {
       display: inline-flex;
       justify-content: space-between;
   }

   #joinForm .group:nth-of-type(1) p span:nth-of-type(1),
   #joinForm .group:nth-last-of-type(1) p span:nth-of-type(1) {
       display: block;
       width: 100%; 
       margin-right: 0.8rem;
   }

   #joinForm .group:nth-of-type(1) .submit,
   #joinForm .group:nth-last-of-type(1) .submit {
      margin-top: 0;
   }
   
   #joinForm #idCheck, 
   #joinForm #reloadBtn {
       font-size: 0.8rem; 
       padding: 0.62rem 0.8rem;
       margin-top: 0px;
   }

    #joinForm input {       
       margin-bottom: 15px; 
    } 
    
    #joinForm .group p {
        margin-top: 2px;
    }
    
    #joinForm .group label {
          transition-duration: 0.3s;
    }
    
    #joinForm .input,
    #joinForm .submit {
        width: calc(100%);
        padding: 10px;
        margin: 5px auto;
        border: 1px solid #d3d3d3;
        border-radius: 5px;
        font-size: 1rem;
        box-sizing: border-box;
    }
    
    #joinForm .input {
       margin-top: 0px;
    }
    
    #joinForm .input:focus {
       border-color: #B1C9EF;
       outline: none;
    }
    
    #joinForm fieldset img {
       width: 100%;
    }
    
    .flex {
       display: flex;
       align-items: center;
       margin-bottom: 0;
    }
    
   #joinForm .flex .group {
       display: flex;
       align-items: center;
       margin-bottom: 0;
       font-size: 0.85rem;
        font-weight: 400;
        text-decoration: none;
        text-align: center;
   }
   
   #joinForm .flex .group input {
      margin: auto 0.5rem;
   }
    
   #joinForm .flex .group:nth-of-type(1) input {
      margin-left: 0;
   }
    
    #joinForm .submit {
        background-color: #628ECB;
        color: white;
        border: none;
        cursor: pointer;
        transition: background-color 0.3s;
    }

    #joinForm .submit:hover {
        background-color: pink;
    }
    
    #joinForm .right {
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
    
    #agreement-content {
        border: 1px solid #d3d3d3;
        padding: 10px;
        max-height: 150px;
        overflow-y: auto;
        margin-bottom: 15px;
        font-size: 0.8rem;
        color: #495057;
    }
        
    #agreement-check {
          font-size: 0.85rem;
        font-weight: 400;
    }
    
    #agreement-check * {
       display: flex;
       align-items: center;
    }
    
    #agreement-check input  {
       margin: auto 0.5rem;
       margin-left: 0;
    }

</style>

<form id="joinForm" method="POST" action="${cpath}/member/join">
   <h3 class="join-title">회원가입</h3>
   
   <div class="group">
      <label for="join-userid" class="small-grey">아이디</label>
      <p>
         <span>
            <input id="join-userid" class="input" type="text" name="userid" autocomplete="off" required autofocus>
         </span>
         <span>   
            <input id="idCheck" class="submit" type="button" value="확인">   
         </span>
      </p>
   </div>
   
   <div class="group">
      <label for="join-userpw" class="small-grey">비밀번호</label>
      <p><input id="join-userpw" class="input" type="password" name="userpw" maxlength="20" required></p>
   </div>
   
   <div class="group">
      <label for="join-nickname" class="small-grey">닉네임</label>
   <p><input id="join-nickname" class="input" type="text" name="nickname" required></p>
   </div>
   
   <div class="group">
      <label for="join-email" class="small-grey">이메일</label>
   <p><input id="join-email" class="input" type="email" name="email" required></p>
   </div>
   
   <div class="group">
      <label for="join-address" class="small-grey">주소</label>
   <p><input id="join-address" class="input" type="text" name="address" autocomplete="off" required></p>
   </div>
   
   <div class="flex">
      <div class="group">
         <input  id="genderM" type="radio" name="gender" value="M">
         <label for="genderM">남성</label>
      </div>
      
      <div class="group">
         <input id="genderF" type="radio" name="gender" value="F">
         <label for="genderF">여성</label>
      </div>
      
      <div class="group">
         <input id="genderU" type="radio" name="gender" value="U">
         <label for="genderU">비공개</label>
      </div>
   </div>
	<!-- 동의서란 추가 -->
    <div id="agreement-section">
<!--         <div id="agreement-content"></div> -->
		<textarea id="agreement-content" readonly>${agreement}</textarea>
        <label>
            <input type="checkbox" name="termsCheck" id="termsCheck" value="true" required>
            위의 약관과 개인정보 처리방침에 동의합니다.
        </label>
    </div>
	
   <div id="captcha"></div>
   <p><input class="submit" type="submit" value="가입신청"></p>
</form>

<script>

   const message = "${message}"
   const result = "${result}"
   
   if (message !== '') {
       swal({
           title: "회원가입 결과",
           text: message,
           icon: result === 'true' ? "success" : "error",
           button: "확인"
       })
   }

   // 주소검색
   function onComplete(data) {
      joinForm.querySelector('input[name="address"]').value = data.address
   }
   
   function execDaumPostcode() {
      const postCode = new daum.Postcode({
           oncomplete: onComplete
       })
       postCode.open()
   }
   
   // 동의서 체크박스 검증 추가
   async function submitHandler(event) {
       event.preventDefault()

       // 동의서 체크 여부 확인
       const termsCheck = document.getElementById('termsCheck')
       if (!termsCheck.checked) {
           swal('회원가입 동의', '이용약관 및 개인정보 처리방침에 동의해주세요.', 'warning')
           return
       }

       // 캡차 검증 로직 유지
       const formData = new FormData()
       formData.append('user_captcha', joinForm.querySelector('input[name="captcha"]').value)
       const url = '${cpath}/members/captcha'
       const opt = {
           method: 'POST',
           body: formData,
       }
       const result = await fetch(url, opt).then((resp) => resp.json())

       if (result.result) {
           event.target.submit()
       } else {
           swal('캡차 검증 실패', '입력값을 다시 확인해주세요', 'error')
           loadCaptchaHandler()
       }
   }
    
   // 아이디 중복체크
   async function idCheckHandler() {
      const userid = joinForm.querySelector('input[name="userid"]').value
      if(userid == '') {
         return
      }
      const url = '${cpath}/members/idCheck?userid=' + userid
      const result = await fetch(url).then(resp => resp.json())      
      
      swal(result.title, result.content, result.type)
      
      const userpw = document.querySelector('input[name="userpw"]')
      if(result.success)   userpw.focus()
      else            userid.select()
   }   
   
    // 캡차 인증을 위한 캡차 이미지 불러오기 (ajax)
   async function loadCaptchaHandler() {
      const url = '${cpath}/members/captcha'
      const result = await fetch(url).then(resp => resp.json())
      let tag = '<fieldset><p>'
      tag += '<img src="${cpath}/upload/captcha/' + result.captchaImage + '" width="300">'
      tag += '<div class="group">'
      tag += '<label for="join-captcha" class="small-grey">그림에 나타난 글자를 입력하세요</label>'
      tag += '<p><span><input id="join-captcha" class="input" type="text" name="captcha" required></span>'
      tag += '<span><input id="reloadBtn" class="submit" type="button" name="reload" value="새로고침"></span></p>'
      tag += '</div>'
      tag += '</fieldset>'
      document.getElementById('captcha').innerHTML = tag
      document.querySelector('input[name="reload"]').onclick = loadHandler
   }
   
   // 처음 문서가 실행될 때 실행되는 함수, 캡차를 작동시킨다
   function loadHandler() {
      loadCaptchaHandler()
   }
   
   const joinForm = document.getElementById('joinForm')
   window.addEventListener('DOMContentLoaded', loadHandler)
   document.getElementById('idCheck').onclick = idCheckHandler
   document.querySelector('input[name="address"]').onclick = execDaumPostcode
   joinForm.onsubmit = submitHandler
</script>

<!-- 스타일 스크립트 -->
<script>
   document.querySelectorAll('#joinForm .group .input').forEach(function(input) {
       var label = document.querySelector('label[for="' + input.id + '"]')
   
       if (label) {
           input.addEventListener('focus', function() {
               label.style.color = '#B1C9EF'
           })
   
           input.addEventListener('blur', function() {
               label.style.color = ''
           })
       }
   })

</script>
</body>
</html>