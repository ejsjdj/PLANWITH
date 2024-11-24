<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>

<style>
    body {
        margin: 0;
        padding: 0;
    }

    .update-profile-title {
		font-size: 1.3rem;
		margin-bottom: 2rem;
    }
    
    .update-profile-form {
		width: 90%;
		max-width: 350px;
		margin: 4rem auto;
		margin-top: 8rem;
		padding: 3rem 5rem;
		background-color: #ffffff;
		border-radius: 10px;
		box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
		text-align: center;
    }
    
   	.update-profile-form p {
		margin-top: 2px;
	}

    .update-profile-form div {
    }
    
    .update-profile-form .small-grey {
 		font-size: 0.75rem;
/*        color: #adb5bd; */
       	color: #999999;
/*        color: #868e90; */
        font-weight: 400;
        text-decoration: none;
    }
    
    .update-profile-form .update-profile-top {
 	    display: flex;
    	justify-content: space-between;
    	align-items: center;
    }

    .update-profile-img {
        margin: 20px auto;
        border-radius: 50%;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    }

    .update-profile-form label {
        font-weight: bold;
        display: block;
        margin: 20px 0 10px;
        font-size: 1rem;
        color: #333;
    }

    .update-profile-back-link {
        display: block;
        margin-top: 20px;
        font-size: 0.9rem;
        color: #4682b4;
        text-decoration: none;
        font-weight: bold;
    }
    
    .update-profile-back-link img {
   	    width: 2rem;
    	display: flex;
    	align-items: center;
    	margin-bottom: 2rem;
    }

    .update-profile-back-link:hover {
        text-decoration: underline;
    }
    
    .update-profile-img {
        margin: 20px auto; /* 이미지 위아래 여백 */
        border-radius: 50%; /* 둥근 이미지 */
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2); /* 그림자 효과 */
        width: 150px; /* 고정된 너비 */
        height: 150px; /* 고정된 높이 */
        object-fit: cover; /* 이미지 비율 유지하며 잘림 */
        margin-bottom: 0;
    }
    
    #update-profile-upload {
    	margin-top: 1rem;
    	margin-bottom: 1.3rem;
    }
    
	.update-profile-form label {
	   width: 100%; 
	   display: block; 
	   text-align: left; 
	   transition-duration: 0.3s;
	}
	
	.update-profile-form .input,
	.update-profile-form .submit {
        width: calc(100%);
        padding: 10px;
        margin: 5px auto;
        border: 1px solid #d3d3d3;
        border-radius: 5px;
        font-size: 1rem;
        box-sizing: border-box;
	}
	
	.update-profile-form .input {
		margin-top: 0px;
	}
	
	.update-profile-form .input:focus,
	.update-profile-form select:focus{
		border-color: #B1C9EF;
		outline: none;
	}
	
	.update-profile-form .submit {
        background-color: #628ECB;
        color: white;
        border: none;
        cursor: pointer;
        transition: background-color 0.3s;
	}
	
	.update-profile-form .submit:hover {
        background-color: pink;
    }
    
</style>

<form class="update-profile-form" action="${cpath}/member/updateProfileImage" method="POST" enctype="multipart/form-data">

	<div class="update-profile-top">
	    <h3 class="update-profile-title">${login.nickname }님의 프로필 사진 수정</h3>
	    <span><a class="update-profile-back-link" href="${cpath}/member/info">
			<img src="${cpath }/resources/image/arrowBack.png">
	    </a></span>
    </div>
    
        <label for="update-profile-upload">새 프로필 이미지</label>
        <img class="update-profile-img" src="${cpath}/upload/${login.memberPhoto != null ? login.memberPhoto : 'default.png'}" alt="Current Profile Image" width="100">
        <div class="update-profile-updateDiv">
	        <input type="file" id="update-profile-upload" name="upload" accept="image/*" required>
	        <button type="submit" class="update-profile-button submit">사진 수정</button>
        </div>
</form>

<%@ include file="../footer.jsp"%>
