<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp"%>

<style>
	body {
		margin: 0;
		padding: 0;
	}
	
	.checkPassword-title {
		font-size: 1.3rem;
		margin-bottom: 2rem;
	}
	
    #passwordForm {
		width: 90%;
		max-width: 350px;
		margin: 4rem auto;
		margin-top: 8rem;
		padding: 3rem 5rem;
		background-color: #ffffff;
		border-radius: 10px;
		box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    }
   	
   	#passwordForm p {
		margin-top: 2px;
	}

    #passwordForm div {
    }
    
    #passwordForm .small-grey {
 		font-size: 0.75rem;
/*        color: #adb5bd; */
       	color: #999999;
/*        color: #868e90; */
        font-weight: 400;
        text-decoration: none;
    }
    
    #passwordForm .check-password-top {
    	display: flex;
    	justify-content: space-between;
    	align-items: center;
    }
    
    .update-password-back-link {
        display: block;
        text-align: center;
        margin: 20px auto;
        color: #4682b4;
        font-weight: bold;
        text-decoration: none;
        margin-bottom: 2rem;
    }
    
    .check-password-back-link img {
   	    width: 2rem;
    	display: flex;
    	align-items: center;
    }

    .check-password-back-link:hover {
        text-decoration: underline;
    }

	#passwordForm label {
	   width: 100%; 
	   display: block; 
	   text-align: left; 
	   transition-duration: 0.3s;
	}
	
	#passwordForm .input,
	#passwordForm .submit {
        width: calc(100%);
        padding: 10px;
        margin: 5px auto;
        border: 1px solid #d3d3d3;
        border-radius: 5px;
        font-size: 1rem;
        box-sizing: border-box;
	}
	
	#passwordForm .input {
		margin-top: 0px;
	}
	
	#passwordForm .input:focus,
	#passwordForm select:focus{
		border-color: #B1C9EF;
		outline: none;
	}
	
	#passwordForm select {
		width: 5rem;
	    height: 2rem;
	    border-radius: 5px;
	    border: 1px solid #d3d3d3;
	    margin-bottom: 1.5rem;
	}
	
	#passwordForm .submit {
        background-color: #628ECB;
        color: white;
        border: none;
        cursor: pointer;
        transition: background-color 0.3s;
        margin-top: 1.5rem;
	}
	
	#passwordForm .submit:hover {
        background-color: pink;
    }
	
</style>


<form id="passwordForm" method="POST">
	<div class="check-password-top">
		<h3 class="checkPassword-title">비밀번호 확인</h3>
		<span><a class="check-password-back-link" href="${cpath}/member/info">
			<img src="${cpath }/resources/image/arrowBack.png">	
		</a></span>
	</div>
	<div class="group">
	    <label for="checkPassword" class="small-grey">비밀번호를 입력하세요</label>
	    <input id="checkPassword" class="input" type="password" name="password" required>
	</div>
    <button class="submit" type="submit">확인</button>
</form>


<script>
    const result = "${result}"
    const message = "${message}"
      
    if (message ) {
        swal({
            title: result === "true" ? "성공" : "오류",
            text: message,
            icon: result === "true" ? "success" : "error",
            button: "확인"
        }).then(() => {
            if (result === "true") {
                window.location.href = "${cpath}/member/info"
            }
        })
    }
    const passwordForm = document.getElementById('passwordForm')
</script>
