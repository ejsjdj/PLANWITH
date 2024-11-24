<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>

<style>
    body {
        margin: 0;
        padding: 0;
    }

   	.update-info-title {
		font-size: 1.3rem;
		margin-bottom: 2rem;
    }

    .update-info-form {
		width: 90%;
		max-width: 350px;
		margin: 4rem auto;
		margin-top: 8rem;
		padding: 3rem 5rem;
		background-color: #ffffff;
		border-radius: 10px;
		box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    }
    
	.update-info-form p {
		margin-top: 2px;
	}

    .update-info-form div {
    }
    
    .update-info-form .small-grey {
 		font-size: 0.75rem;
/*        color: #adb5bd; */
       	color: #999999;
/*        color: #868e90; */
        font-weight: 400;
        text-decoration: none;
    }
    
    .update-info-form .update-info-top {
    	display: flex;
    	justify-content: space-between;
    	align-items: center;
    }
    
    .update-info-back-link {
        display: block;
        text-align: center;
        margin: 20px auto;
        color: #4682b4;
        font-weight: bold;
        text-decoration: none;
        margin-bottom: 2rem;
    }
    
    .update-info-back-link img {
   	    width: 2rem;
    	display: flex;
    	align-items: center;
    }

    .update-info-back-link:hover {
        text-decoration: underline;
    }

	.update-info-form label {
	   width: 100%; 
	   display: block; 
	   text-align: left; 
	   transition-duration: 0.3s;
	}
	
	.update-info-form .input,
	.update-info-form .submit {
        width: calc(100%);
        padding: 10px;
        margin: 5px auto;
        border: 1px solid #d3d3d3;
        border-radius: 5px;
        font-size: 1rem;
        box-sizing: border-box;
	}
	
	.update-info-form .input {
		margin-top: 0px;
	}
	
	.update-info-form .input:focus,
	.update-info-form select:focus{
		border-color: #B1C9EF;
		outline: none;
	}
	
	.update-info-form select {
		width: 5rem;
	    height: 2rem;
	    border-radius: 5px;
	    border: 1px solid #d3d3d3;
	    margin-bottom: 1.5rem;
	}
	
	.update-info-form .submit {
        background-color: #628ECB;
        color: white;
        border: none;
        cursor: pointer;
        transition: background-color 0.3s;
	}
	
	.update-info-form .submit:hover {
        background-color: pink;
    }
</style>


<form class="update-info-form" method="POST">
	<div class="update-info-top">
		<h3 class="update-info-title">${login.nickname}님의 정보 수정</h3>
		<span><a class="update-info-back-link" href="${cpath}/member/info">
			<img src="${cpath }/resources/image/arrowBack.png">
		</a></span>	 
	</div>
    <div class="group">
        <label for="update-info-nickname" class="small-grey">닉네임</label>
        <p><input id="update-info-nickname" class="input" type="text" name="nickname" value="${login.nickname}" required></p>
    </div>
    <div class="group">
        <label for="update-info-email" class="small-grey">이메일</label>
        <p><input id="update-info-email" class="input" type="email" name="email" value="${login.email}" required></p>
    </div>
    <div class="group">
        <label for="update-info-address" class="small-grey">주소</label>
        <p><input id="update-info-address" class="input" type="text" name="address" placeholder="주소를 검색하세요" value="${login.address}" autocomplete="off" required></p>
    </div>
    <div class="group">
        <label for="update-info-gender" class="small-grey">성별</label>
        <select name="gender">
            <option value="M" ${login.gender == 'M' ? 'selected' : ''}>남성 </option>
            <option value="F" ${login.gender == 'F' ? 'selected' : ''}>여성</option>
            <option value="U" ${login.gender == 'U' || empty login.gender ? 'selected' : ''}>비공개</option>
        </select>
    </div>
    <button class="submit" type="submit">정보 수정</button>
</form>

<script>
    function onComplete(data) {
        document.querySelector('input[name="address"]').value = data.address
    }
    
    function execDaumPostcode() {
        const postCode = new daum.Postcode({
            oncomplete: onComplete
        })
        postCode.open()
    }
    document.querySelector('input[name="address"]').onclick = execDaumPostcode
</script>

<%@ include file="../footer.jsp"%>
