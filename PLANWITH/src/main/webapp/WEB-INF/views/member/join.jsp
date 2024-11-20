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
   
   function loadTerms() {
       // 하드코딩된 약관과 개인정보 처리방침 내용
       const termsSection = `
           <p><strong>[이용약관]</strong></p>
           <p>
               본 약관은 PLANWITH 서비스를 이용함에 있어 회사와 회원 간의 권리, 의무 및 책임사항을 규정합니다.
           </p>
           <ol>
               <li><strong>목적</strong>: 이 약관은 PLANWITH 서비스의 이용 조건 및 절차에 관한 사항을 규정합니다.</li>
               <li><strong>회원 가입</strong>: 회원 가입은 신청자가 약관에 동의하고, 회사가 이를 승인함으로써 체결됩니다.</li>
               <li><strong>서비스 이용</strong>: 회원은 서비스를 정상적인 용도로만 이용해야 하며, 불법적인 행위를 금합니다.</li>
               <li><strong>계정 관리</strong>: 회원은 자신의 계정을 안전하게 관리할 책임이 있으며, 계정 도용이나 공유로 인한 문제는 회원의 책임입니다.</li>
               <li><strong>계약 해지</strong>: 회원은 언제든지 계정을 해지할 수 있으며, 회사는 약관을 위반한 회원에 대해 서비스 제공을 중단할 수 있습니다.</li>
           </ol>
           <p>기타 상세한 내용은 회사의 별도 정책에 따릅니다.</p>

           <p><strong>[개인정보 처리방침]</strong></p>
           <p>
               PLANWITH는 회원의 개인정보를 소중히 여기며, 다음과 같은 방식으로 개인정보를 보호합니다.
           </p>
           <ol>
               <li><strong>수집하는 개인정보 항목</strong>: 이름, 이메일, 휴대전화 번호, 주소 등 회원가입 시 필요한 정보를 수집합니다.</li>
               <li><strong>개인정보의 이용 목적</strong>: 수집된 개인정보는 회원 관리, 서비스 제공, 고객 지원 및 법적 요구사항 준수를 위해 사용됩니다.</li>
               <li><strong>개인정보의 보관 및 파기</strong>: 회원 탈퇴 시 수집된 개인정보는 지체 없이 파기됩니다. 단, 법적 의무가 있는 경우 해당 기간 동안 보관됩니다.</li>
               <li><strong>개인정보의 제3자 제공</strong>: 회사는 회원의 동의 없이 개인정보를 제3자에게 제공하지 않습니다. 단, 법적 요구사항이 있는 경우 예외로 합니다.</li>
               <li><strong>회원의 권리</strong>: 회원은 자신의 개인정보를 열람, 수정 및 삭제할 권리가 있습니다. 이를 위해 고객센터를 통해 요청할 수 있습니다.</li>
           </ol>
           <p>회사는 개인정보 보호법 등 관련 법령을 준수하며, 개인정보 처리방침을 지속적으로 개선합니다.</p>
       `

       // 약관 내용을 HTML에 삽입
       document.getElementById('agreement-content').innerHTML = termsSection
   }
   
   // 아이디 중복체크
	async function idCheckHandler() {
// 		console.log('idcheck!')
		  const userid = joinForm.querySelector('input[name="userid"]').value
// 		  console.log('userid:',userid)
		  if(userid == '') {
		     return
		  }
		  const url = '${cpath}/members/idCheck?userid=' + userid
		  const result = await fetch(url).then(resp => resp.json())      
		  
		  swal(result.title, result.content, result.type)
		  
		  const userpw = document.querySelector('input[name="userpw"]')
		  if(result.success)   	userpw.focus()
		  else            		userid.select()
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
      loadTerms()
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