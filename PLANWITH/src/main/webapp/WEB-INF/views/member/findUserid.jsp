<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>

<style>
    body {
        font-family: Arial, sans-serif;
/*         background-color: #f8faff; */
        margin: 0;
        padding: 0;
    }

    .findUserid-title {
       	font-size: 1.3rem;
        margin-bottom: 2rem;
    }
    
    #findUseridForm {
        width: 90%;
        max-width: 350px;
        margin: 4rem auto;
        margin-top: 8rem;
        padding: 3rem 5rem;
        background-color: #ffffff;
        border-radius: 10px;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    }
    
    #findUseridForm div{
        margin-bottom: 15px;
    }
    
    #findUseridForm .group label {
       width: 100%; /* 이미 적용된 스타일 */
       display: block; /* 줄 전체를 차지하도록 */
       text-align: left; /* 텍스트 왼쪽 정렬 */
   }
   
   #findUseridForm .group:nth-of-type(1) p,
   #findUseridForm .group:nth-last-of-type(1) p {   /* 아이디 그룹 */
      display: flex;
      align-items: center;
      justify-content: space-between;
   }
   
   #findUseridForm .group:nth-of-type(1) p span, 
   #findUseridForm .group:nth-last-of-type(1) p span{
       display: inline-flex;
       justify-content: space-between;
   }

   #findUseridForm .group:nth-of-type(1) p span:nth-of-type(1),
   #findUseridForm .group:nth-last-of-type(1) p span:nth-of-type(1)
    {
       display: block;
       width: 100%; 
       margin-right: 0.8rem;
   }

   #findUseridForm #requestCodeButton {
		font-size: 0.8rem; 
      	margin-top: 0;
      	width: 6rem;
    	padding: 0.6rem;
   }
   
   #findUseridForm .submit {
       padding: 0.62rem 0.8rem;
       margin-top: 0px;
   }

    #findUseridForm input {       
       margin-bottom: 15px; 
    } 
    
    #findUseridForm .group p {
        margin-top: 2px;
    }
    
    #findUseridForm .group label {
          transition-duration: 0.3s;
    }
    
    #findUseridForm .input,
    #findUseridForm .submit {
        width: calc(100%);
        padding: 10px;
        margin: 5px auto;
        border: 1px solid #d3d3d3;
        border-radius: 5px;
        font-size: 1rem;
        box-sizing: border-box;
    }
    
    #findUseridForm .input {
       margin-top: 0px;
    }
    
    #findUseridForm .input:focus {
       border-color: #B1C9EF;
       outline: none;
    }
    
    #findUseridForm fieldset img {
       width: 100%;
    }
    
    .flex {
       display: flex;
       align-items: center;
       margin-bottom: 0;
    }
    
   #findUseridForm .flex .group {
       display: flex;
       align-items: center;
       margin-bottom: 0;
       font-size: 0.85rem;
        font-weight: 400;
        text-decoration: none;
        text-align: center;
   }
   
   #findUseridForm .flex .group input {
      margin: auto 0.5rem;
   }
    
   #findUseridForm .flex .group:nth-of-type(1) input {
      margin-left: 0;
   }
    
    #findUseridForm .submit {
        background-color: #628ECB;
        color: white;
        border: none;
        cursor: pointer;
        transition: background-color 0.3s;
    }

    #findUseridForm .submit:hover {
        background-color: pink;
    }
    
    #findUseridForm .right {
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


<form id="findUseridForm" class="findUserid-form" method="POST">
<h3 class="findUserid-title">아이디 찾기</h3>
    <div class="group">
        <label for="findUserid-sendCode" class="small-grey">이메일</label>
        <p>
        	<span>
		        <input id="findUserid-sendCode" class="input" type="email" name="email" required>
        	</span>
        	<span>
		    	<button class="submit" type="button" id="requestCodeButton">인증번호 요청</button>
        	</span>
        </p>
    </div>

    <div class="group">
        <label for="findUserid-verificationCode" class="small-grey">인증번호</label>
        <p><input id="findUserid-verificationCode" class="input" 
        type="text" name="userInputCode" maxlength="10" required></p>
    </div>
    <button class="submit" type="submit">아이디 찾기</button>
</form>

<div id="findUserid-result"></div>

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
    document.getElementById('findUseridForm').addEventListener('submit', findUserId)
</script>

<!-- 스타일 스크립트 -->
<script>
	document.querySelectorAll('#findUseridForm .group').forEach((group) => {
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
