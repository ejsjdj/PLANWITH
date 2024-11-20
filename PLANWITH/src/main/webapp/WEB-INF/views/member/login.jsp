<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>

<style>
    body {
/*         background-color: #f0f8ff; */
        margin: 0;
        padding: 0;
    }
	
    .login-title {
        color: #4682b4;
        text-align: center;
        margin: 20px 0;
    }

    #loginForm {
        width: 90%;
        max-width: 350px;
        margin: 4rem auto;
        padding: 3rem 5rem;
        background-color: #ffffff;
        border-radius: 10px;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    }
    
	#loginForm label {
	    width: 100%; /* 이미 적용된 스타일 */
	    display: block; /* 줄 전체를 차지하도록 */
	    text-align: left; /* 텍스트 왼쪽 정렬 */
	}

    #loginForm input {
        margin-bottom: 15px;
    }
    
    #loginForm .group p {
        margin-top: 2px;
    }
    
    #loginForm .group label {
   	    transition-duration: 0.3s;
    }
    
    #loginForm .input,
    #loginForm .submit {
        width: calc(100%);
        padding: 10px;
        margin: 5px auto;
        border: 1px solid #d3d3d3;
        border-radius: 5px;
        font-size: 1rem;
        box-sizing: border-box;
    }
    
    #loginForm .input {
    	margin-top: 0px;
    }
    
    #loginForm .input:focus {
    	border-color: #B1C9EF;
    	outline: none;
    }
    
    #loginForm .group:nth-of-type(2) input,
    #loginForm .group:nth-of-type(2) p {
    	margin-bottom: 0;
    }

    #loginForm .submit {
        background-color: #628ECB;
        color: white;
        border: none;
        cursor: pointer;
        transition: background-color 0.3s;
    }

    #loginForm .submit:hover {
        background-color: pink;
    }
    
    #loginForm .right {
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
/*     	color: #adb5bd; */
    	color: #999999;
/*     	color: #868e90; */
	  	font-weight: 400;
	  	text-decoration: none;
	  	text-align: center;
    }
    
    .margin  {
    	margin: 1rem;
    }
    
    .a:hover {
    	text-decoration: underline;
    }
    
    .social-login {
        text-align: center;
        margin-top: 20px;
    	display: flex;
    	width: 440px;
    	margin: auto;
    	justify-content: center; 
    	width: 90%;
    	height: 5rem;
    	align-items: center;
    }

    .social-login img {
        width: 50px;
        margin: 10px 2rem;
        cursor: pointer;
        border-radius: 5px;
/*         box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1); */
/*         transition: transform 0.3s, box-shadow 0.3s; */
    }

    .social-login img:hover {
        transform: translateY(-2px);
/*         box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2); */
    }

    .join-link {
        text-align: center;
    }

    .join-link a {
        margin: 0 10px;
    }

</style>


<form id="loginForm" method="POST" action="${cpath}/member/login">

	<h3 class="login-title"><a href="${cpath }"><img src="${cpath }/resources/image/plan with.png" width="100px;"></a></h3>

	<div class="group">
	    <label for="login-userid" class="small-grey">아이디</label>
	    <p><input id="login-userid" class="input" type="text" name="userid" autocomplete="off" required autofocus></p>
	</div>
	<div class="group">
	    <label for="login-userpw" class="small-grey">비밀번호</label>
		<p><input id="login-userpw" class="input" type="password" name="userpw" required></p>
	</div>
	
    <div id="captcha"></div>
    <div class="right">
	    <a class="small-grey a" href="${cpath}/member/findUserId">아이디 찾기</a>
	    <a class="small-grey a" href="${cpath}/member/findPassword">비밀번호 찾기</a>
    </div>
    <p><input class="submit" type="submit" value="로그인"></p>
    
    <div id="underLoginForm">
	    <div class="join-link margin">
		    <span class="small-grey">아직 회원이 아니세요?</span><a class="small-point a" href="${cpath}/member/join">회원가입</a>
		</div>
		
		<p class="small-grey margin">SNS 간편 로그인</p>
	    <div class="social-login">
		    <p><img id="loginWithNaver" src="${cpath}/resources/naver/네이버축약형.png" alt="네이버 로그인 버튼"></p>
		    <p><img id="loginWithKakao" src="${cpath}/resources/kakao/카카오축약형.png" alt="카카오 로그인 버튼"></p>
		</div>
    </div>
	
</form>

<script>
	// 회원가입 폼을 제출하기 전 캡차를 확인하는 함수
	async function submitHandler(event) {
		event.preventDefault()
		const formData = new FormData()
		formData.append('user_captcha', loginForm.querySelector('input[name="captcha"]').value)
		const url = '${cpath}/members/captcha'
		const opt = {
			method: 'POST',
			body: formData
		}
		const result = await fetch(url, opt).then(resp => resp.json())
		if(result.result) {
			event.target.submit()
		}
		else {
			swal('캡차 검증 실패', '입력값을 다시 확인해주세요', 'error')
			loadCaptchaHandler()
		}
	}

	// 캡차 인증을 위한 캡차 이미지 불러오기 (ajax)
	async function loadCaptchaHandler() {
		const url = '${cpath}/members/captcha'
		const result = await fetch(url).then(resp => resp.json())
		let tag = '<fieldset><p>'
		tag += '<img src="${cpath}/upload/captcha/' + result.captchaImage + '" width="300">'
		tag += '<input type="button" name="reload" value="새로고침">'
		tag += '<p><input class="input" type="text" name="captcha" placeholder="그림에 나타난 글자를 입력하세요" required></p>'
		tag += '</fieldset>'
		document.getElementById('captcha').innerHTML = tag
		document.querySelector('input[name="reload"]').onclick = loadHandler
	}
	
	function loadHandler() {
		loadCaptchaHandler()
	}
	
	const message = "${message}"
    const context = "${context}"  // context 값 사용
    
    if (message !== '') {
        swal({
            title: context === "join" ? "회원가입 결과" : "로그인 결과",  // context 값에 따라 타이틀 설정
            text: message,
            icon: context === "join" ? "success" : "error",
            button: "확인"
        })
    }
		
	// 카카오로그인 클릭 시 카카오로그인창을 띄운다
	function loginWithKakaoHandler() {
		const url = '${kakaoLoginURL}'
		const name = '_blank'
		const options = 'menubar=no, toolbar=no, width=700, height=1000'
		window.open(url, name, options)
	}
	
	// 네이버로그인 클릭 시 네이버로그인창을 띄운다
	function loginWithNaverHandler() {
		const url = '${naverLoginURL}'
		const name = '_blank'
		const options = 'menubar=no, toolbar=no, width=700, height=1000'
		const popup = window.open(url, name, options)
		
		const timer = setTimeout(
					function() {
						if(popup.closed) {
							afterClosePopup()
						}
					}, 200)
	}
	const loginForm = document.getElementById('loginForm')
	document.getElementById('loginWithNaver').onclick = loginWithNaverHandler
	document.getElementById('loginWithKakao').onclick = loginWithKakaoHandler
	if(${result}) {
		loadHandler()
		loginForm.addEventListener('submit', submitHandler)
	}
</script>

<!-- 스타일 스크립트 -->
<script>
	document.querySelectorAll('#loginForm .group').forEach((group) => {
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

</body>
</html>