<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>

<style>
    body {
        margin: 0;
        padding: 0;
    }

    .update-password-title {
        font-size: 1.3rem;
		margin-bottom: 2rem;
    }

    .update-password-form {
		width: 90%;
		max-width: 350px;
		margin: 4rem auto;
		margin-top: 8rem;
		padding: 3rem 5rem;
		background-color: #ffffff;
		border-radius: 10px;
		box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    }
   	
   	.update-password-form p {
		margin-top: 2px;
	}

    .update-password-form div {
    }
    
    .update-password-form .small-grey {
 		font-size: 0.75rem;
/*        color: #adb5bd; */
       	color: #999999;
/*        color: #868e90; */
        font-weight: 400;
        text-decoration: none;
    }
    
    .update-password-form .update-password-top {
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
    
    .update-password-back-link img {
   	    width: 2rem;
    	display: flex;
    	align-items: center;
    }

    .update-password-back-link:hover {
        text-decoration: underline;
    }

	.update-password-form label {
	   width: 100%; 
	   display: block; 
	   text-align: left; 
	   transition-duration: 0.3s;
	}
	
	.update-password-form .input,
	.update-password-form .submit {
        width: calc(100%);
        padding: 10px;
        margin: 5px auto;
        border: 1px solid #d3d3d3;
        border-radius: 5px;
        font-size: 1rem;
        box-sizing: border-box;
	}
	
	.update-password-form .input {
		margin-top: 0px;
	}
	
	.update-password-form .input:focus,
	.update-password-form select:focus{
		border-color: #B1C9EF;
		outline: none;
	}
	
	.update-password-form select {
		width: 5rem;
	    height: 2rem;
	    border-radius: 5px;
	    border: 1px solid #d3d3d3;
	    margin-bottom: 1.5rem;
	}
	
	.update-password-form .submit {
        background-color: #628ECB;
        color: white;
        border: none;
        cursor: pointer;
        transition: background-color 0.3s;
        margin-top: 1.5rem;
	}
	
	.update-password-form .submit:hover {
        background-color: pink;
    }
    
</style>


<form class="update-password-form" action="${cpath}/member/updatePassword" method="POST">
	<div class="update-password-top">
		<h3 class="update-password-title">비밀번호 수정</h3>
		<span><a class="update-password-back-link" href="${cpath}/member/info">
			<img src="${cpath }/resources/image/arrowBack.png">
		</a></span>
	</div>
    <div class="group">
        <label for="updateCurrentPassword" class="small-grey">현재 비밀번호</label>
        <p><input id="updateCurrentPassword" class="input" type="password" name="currentPassword" required></p>
    </div>
    <div class="group">
        <label for="updateNewPassword" class="small-grey">새 비밀번호</label>
        <p><input id="updateNewPassword" class="input" type="password" name="newPassword" required></p>
    </div>
    <button class="submit" type="submit">비밀번호 수정</button>
</form>

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
