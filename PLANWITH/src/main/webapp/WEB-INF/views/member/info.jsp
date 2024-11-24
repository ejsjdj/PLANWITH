<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>

<style>
    body {
        margin: 0;
        padding: 0;
    }
    
    .middle-grey {
		font-size: 0.85rem;
		color: #999999;
		font-weight: 400;
		text-decoration: none;
		text-align: center;
	}
	
	.info-card .black {
		color: #495057;
		font-size: 0.95rem;
	}

    .info-title {
        font-size: 1.3rem;
   		margin-bottom: 2rem;
    }

    .info-card {
       width: 55rem;
	   max-width: 55rem;
	   margin: 4rem auto;
	   margin-top: 8rem;
	   padding: 3rem 5rem;
	   background-color: #ffffff;
	   border-radius: 10px;
	   box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    }
    
    .info-card-flex {
    	display: flex;
    }
    
    .info-card-flex .left,
    .info-card-flex .right {
    	flex: 1;
    }
	
	.info-card-flex .right {
		display: flex;
		align-items: center;
	}
    /* 회원 정보 섹션 */
    .info-profile-card {
        margin-bottom: 20px;
    }

    .info-profile-card img.info-profile-image {
        display: block;
        margin: 30px auto;
        width: 150px;
        height: 150px;
        border-radius: 50%;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
    }

    .info-item {
        display: flex; 
        justify-content: center; 
        align-items: center; 
        margin-bottom: 2rem;
        font-size: 1rem;
    }
    
    .info-card .info-name {
    	margin-bottom: 0;
    }
    
    .info-label {
        font-weight: 600;
        width: 40%; 
        text-align: center; 
        font-size: 1.3rem;
    }
    
/*     .info-card .input { */
/*     	width: calc(100%); */
/* 		padding: 10px; */
/* 		margin: 5px auto; */
/* 		border: 1px solid #d3d3d3; */
/* 		border-radius: 5px; */
/* 		font-size: 1rem; */
/* 		box-sizing: border-box; */
/*     } */

    .info-value {
        text-align: right; /* 값 오른쪽 정렬 */
        width: 60%; /* 값 고정 너비 */
        color: #333;
    }

     .info-button-group { 
         width: 90%; 
        max-width: 300px; 
        margin: 20px auto; 
         text-align: center; 
         justify-content: center;
         align-items: center;
		
     } 

    .info-delete-button:hover {
        background-color: #e04141; 
    }
    
    .info-button-group .submit {
 		width: 70%;
		padding: 15px;
		margin: 10px auto;
		border: 1px solid #d3d3d3;
		border-radius: 2rem;
		font-size: 0.9rem;
		box-sizing: border-box;
/* 	   	background-color: #6495ED;	 */
/* 	   	background-color: #0099FF; */
/* 	   	background-color: #628ECB; */
	/*    background-color: #033495; */
	/*    background-color: #4267a9; */
		background-color: white;
		color: black;
		border: none;
		cursor: pointer;
		transition: background-color 0.3s;
		font-weight: 400;
		box-shadow: 0 14px 28px rgba(0, 0, 0, 0.04), 0 10px 10px rgba(0, 0, 0, 0.04);
    }
    
     .info-delete-button {
        background-color: #f1f1f1 !important;
    }
    
    .info-button-group .submit:hover {
    	background-color: #f0f0f0;
    }
    
</style>


<div class="info-card info-profile-card">
	<h3 class="info-title">회원정보</h3>
	<div class="info-card-flex">
		<div class="left">
		    <div>
		        <img class="info-profile-image" src="${cpath}/upload/${login.memberPhoto != null ? login.memberPhoto : 'default.png'}" alt="프로필 이미지">
		    </div>
		    <div class="info-item info-name">
		        <span class="info-label">${login.nickname}</span>
		    </div>
		    <div class="info-item">
		        <span class="middle-grey">${login.email}</span>
		    </div>
		    <div class="info-item">
		        <span class="middle-grey black">
		            <c:if test="${login.gender == 'M'}">남성</c:if>
		            <c:if test="${login.gender == 'F'}">여성</c:if>
		            <c:if test="${login.gender == 'U' || empty login.gender}">비공개</c:if>
		        </span>
		    </div>
		    <div class="info-item">
		        <span class="middle-grey black">${login.address}</span>
		    </div>	
	    </div>
	    
	    <div class="right" >
		    <div class="info-button-group">
			    <a href="${cpath}/member/updateInfo">
			        <button class="submit">기본 정보 수정</button>
			    </a>
			    <a href="${cpath}/member/updateProfileImage">
			        <button class="submit">프로필 사진 수정</button>
			    </a>
			    <c:if test="${login.snsType == null}">
			        <a href="${cpath}/member/updatePassword">
			            <button class="submit">비밀번호 수정</button>
			        </a>
			    </c:if>
				<form id="infoDeleteForm" action="${cpath}/member/delete" method="POST">
					    <button type="submit" class="info-delete-button submit">회원 탈퇴</button>
				</form>
			</div>
	    </div>
    </div>
</div>




<script>
    document.addEventListener('DOMContentLoaded', function () {
        const deleteForm = document.getElementById('infoDeleteForm')
        if (deleteForm) {
            deleteForm.addEventListener('submit', function (event) {
                event.preventDefault()
                const confirmed = confirm('정말로 탈퇴하시겠습니까?')
                if (confirmed) {
                    deleteForm.submit()
                }
            })
        }
    })
</script>

<%@ include file="../footer.jsp"%>