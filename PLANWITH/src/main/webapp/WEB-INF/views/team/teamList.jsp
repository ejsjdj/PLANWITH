<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>
<style>
	body {
	
	}
	.container {
		width: 1200px;
		margin: 0 auto;
		margin-top: 5rem;
		padding: 20px;
		box-sizing: border-box;
		height: 100%;
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
	
	.a {
		text-decoration: none;
		color: black;
	}
	
	.a:hover {
		text-decoration: underline;
	}
	
   	.teamListBody {
      	height: 100%;
   	}
   	.teamListBody > .teamBoxes {
      	width: auto;
/*       height: 100%; */
      	margin: 25px;
	      position: relative;
	      justify-content: center;
	      flex-flow: wrap;
	      display: flex;
	}
   	.teamListBody > .teamBoxes > .teamBox,
   	.teamListBody > .teamBoxes > .createBox {
		font-size: 1rem;
		width: 25rem;
		height: 6rem;
		padding: 25px;
		display: grid;
		justify-content: center;
		align-content: center;
		margin: 25px;
		border: 0.2px solid #f1f3f5;
/*         background-color: #ffffff; */
        background-color: #ffffff;
        border-radius: 1rem;
/*         box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1); */
  		box-shadow: 0 14px 28px rgba(0, 0, 0, 0.03), 0 10px 10px rgba(0, 0, 0, 0.03)
	}
   
   	.teamListBody > .teamBoxes > .teamBox {
   		cursor: pointer;
	}
   
   	.teamListBody > .teamBoxes > .teamBox:hover {
   		background-color: #ecf1fe;
   	}
   
   	.teamListBody #createButton {
   		width: 70%;
        padding: 10px;
        margin: 5px auto;
        margin-top: 8px;
        border: 1px solid #d3d3d3;
        border-radius: 3rem;
        font-size: 0.8rem;
        box-sizing: border-box;
   		background-color: #033495;
/*    		background-color: #628ECB; */
   		background: linear-gradient(70deg, #172d9d, #561689); 
        color: white;
        border: none;
        cursor: pointer;
        transition: background-color 0.3s;
   	}
   
   	.createAndJoinTeamModal {
      	width: 500px;
		height: 18rem;
		position: absolute;
	}
   
    .createAndJoinTeamModal .group label {
		width: 100%; 
		display: block; 
		text-align: left; 
		transition-duration: 0.3s;
    }
   	
    .createAndJoinTeamModal .group input {
    	margin-bottom: 15px;
    }
    
    .createAndJoinTeamModal .input:focus {
		border-color: #B1C9EF;
		outline: none;
	}
    
    .createAndJoinTeamModal .input,
    .createAndJoinTeamModal .submit {
		width: 100%;
        padding: 10px;
        margin: 5px auto;
        border: 1px solid #d3d3d3;
        border-radius: 5px;
        font-size: 1rem;
        box-sizing: border-box;
    }
    
    .createAndJoinTeamModal .submit {
        background: linear-gradient(70deg, #172d9d, #561689); 
        color: white;
        border: none;
        cursor: pointer;
        transition: background-color 0.3s;
        border-radius: 2rem;
    }
	
	.createAndJoinTeamModal .left .input {
		margin-bottom: 0px;
	}
	
	.createAndJoinTeamModal .left .submit {
		width: 10rem;
	}
	
	.createAndJoinTeamModal .right .submit {
		width: 10rem;
	}	
	
    .createAndJoinTeamModal .submit:hover {
        background: pink;
    }
    
    .createAndJoinTeamModal .group p {
    	margin-top: 2px;
	}
	   
   	.modalOverlay {
		display: none;
		position: fixed;
		top: 0;
		left: 0;
		width: 100%;
		height: 100%;
		background: rgba(0, 0, 0, 0.4);
		z-index: 10;
   	}
   	/* 모달 스타일 */
   	.createAndJoinTeamModal {
		display: none; /* 기본적으로 숨김 */
		position: fixed;
		top: 50%;
		left: 50%;
		transform: translate(-50%, -50%);
		width: 500px;
		padding: 20px;
		background: white;
		border-radius: 10px;
		box-shadow: 0 4px 10px rgba(0, 0, 0, 0.3);
		z-index: 11;
		display: flex;
		flex-direction: column;
		gap: 20px;
   	}
   	.createAndJoinTeamModal > span {
		display: flex;
		justify-content: center;
		font-size: 20px;
		font-weight: bold;
   	}
   	.inTheBox {
		width: 100%;
		height: 80%;
		display: flex;
	}
    .createAndJoinTeamModal > .inTheBox > .left,
    .createAndJoinTeamModal > .inTheBox > .right {
		flex: 1; 
		text-align: center;
		padding: 5px;
	}

    .createAndJoinTeamModal > .inTheBox > .left {
        border-right: 1px solid #ddd;
    }
    .createAndJoinTeamModal {
        display: flex;
        justify-content: space-between;
        gap: 20px;
    }
    .createAndJoinTeamModal > .inTheBox > .left,
    .createAndJoinTeamModal > .inTheBox > .right {
        width: calc(50% - 10px); 
        height: 100%;
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
    }
    
    .createAndJoinTeamModal > .inTheBox > .left {
       
    }
    
    .createAndJoinTeamModal > .inTheBox > .right {
       
    }
    
    .createAndJoinTeamModal > .close {
		width: 100%;
		text-align: center;
    }

    .modal-close-button {
        display: inline-block;
        margin-top: 10px;
        padding: 10px 20px;
        background-color: #628ECB; 
        color: white;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        text-align: center;
    }
    
    .teamBox {
    	display: flex;
    	text-align: left;
    
    }
    
    .teamBox .box-top {
    
    }
    
    .teamBox .box-top {
    	display: flex;
    	align-items: center;
    	justify-content: space-between;
    }
    
    .teamBox .box-top span:nth-last-of-type(1) {
    	align-items: flex-end;
    	font-size: 0.7rem;
    }
    
    .text-gap {
    	margin-right: 1.5rem;
  	}
  	
    .teamBox .box-bottom {
    
    }
    
    .teamBox .box-top img {
    	width: 0.6rem;
    	opacity: 0.3;
    	margin: auto;
    }
    
</style>
<div class="modalOverlay"></div>
<div class="teamListBody container">
	<div class="teamBoxes">
	
	   	<div class="createBox">
	   		<c:if test="${teamList == null }">
	        	<span>지금 바로 일정을 추가해보세요</span>
	   		</c:if>
	   		<c:if test="${teamList != null }">
	        	<span>새로운 일정을 추가해보세요</span>
	   		</c:if>
	        <button id="createButton">일정 추가하기</button>
	    </div>
	    
	   	<c:forEach var="team" items="${teamList }">
	        <div class="teamBox" >
	        	<div class="box-top">
	            	<a class="a full-link text-gap" href="${cpath }/team/view/${team.id}" >${team.name }</a>
	            	<span>		            	
	            		<img src="${cpath }/resources/image/사람 수 아이콘.png" >
		            	<span class="small-grey">
		            		${team.howmanyMembers }
		            	</span>
		            </span>
	        	</div>
	            
	            <div class="box-bottom">
		            <c:if test="${team.startTime != null }">
			            <p>${team.startTime } ~ ${team.endTime }</p>
			            <p>${team.firstPlaceName }</p>
		            </c:if>
		            <c:if test="${team.startTime == null }">
		            	<p class="small-grey">아직 장소를 정하지 않았습니다.</p>
		            </c:if>
	            </div>
	    	</div>
		</c:forEach>
		
	</div>
</div>
   
   
<div class="createAndJoinTeamModal">
	<span>새로운 일정</span>
   	<div class="inTheBox">
      	<div class="left">
	    	<form action="${cpath}/team/joinTeam" method="POST">
	    		<div class="group">
	    			<label for="createTeam-inviteCode" class="small-grey">초대 코드 입력</label>
			        <p><input class="input" type="text" name="inviteCode" required></p>
	    		</div>
		       <button class="submit" type="submit">입장하기</button>
	        </form>
      	</div>
	<div class="right">
		<form action="${cpath}/team/create">
        	<button class="submit" type="submit">새로 만들게요</button>
        </form>
	</div>
 	</div>
  	<!-- 닫기 버튼 추가 -->
   	<div class="close">
       	<button class="modal-close-button">닫기</button>
   	</div>
</div>

<div class="sideBar"> 
   	<div class="profile"></div>
   	<div class="friendList"></div>
   	<div class="requestToAddFriend"></div>
</div>

<!-- 스타일 스크립트 -->
<script>
	document.addEventListener("DOMContentLoaded", function () {
	    const teamBoxes = document.querySelectorAll(".teamBox")
	
	    teamBoxes.forEach((box) => {
	        box.addEventListener("click", function () {
	            const link = box.querySelector("a")
	            if (link) {
	                window.location.href = link.href // a 태그의 href 링크로 이동
	            }
	        })
	    })
	
	    const modal = document.querySelector(".createAndJoinTeamModal")
	    const modalOverlay = document.querySelector(".modalOverlay")
	    const createButton = document.querySelector("#createButton")
	    const closeButton = document.querySelector(".modal-close-button")
	
	    // 페이지 로드 시 모달과 오버레이 숨기기
	    modal.style.display = "none"
	    modalOverlay.style.display = "none"
	
	    // "일정 추가하기" 버튼 클릭 시 모달과 오버레이 표시
	    createButton.addEventListener("click", function () {
	        modal.style.display = "flex"
	        modalOverlay.style.display = "block"
	    })
	
	    // 닫기 버튼 클릭 시 모달과 오버레이 숨기기
	    closeButton.addEventListener("click", function () {
	        modal.style.display = "none"
	        modalOverlay.style.display = "none"
	    })
	
	    // 오버레이 클릭 시 모달과 오버레이 숨기기
	    modalOverlay.addEventListener("click", function (event) {
	        if (event.target === modalOverlay) {
	            modal.style.display = "none"
	            modalOverlay.style.display = "none";
	        }
	    })
	})
</script>

</body>
</html>