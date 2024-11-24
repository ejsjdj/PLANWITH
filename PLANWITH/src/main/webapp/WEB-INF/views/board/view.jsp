<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>
	
	
<!-- 	임시 수정임다.     -->
	
	
	<style>
		.reply {
			display: flex;
			justify-content: left;
			flex-flow: column;
			padding: 10px;
		}	
		.reply > .replyUser {
			display: flex;
		}
		.reply > .replyUser > img {
			border-radius: 50%;
			width: 45px;
			height: 45px;
		}
		.reply > .replyUser > .reNickAndDate {
			display: flex;
			flex-flow: column;
		}
		.reply > .replyUser > .reNickAndDate > .namename {
			font-size: 18px;	
			font-weight: 400;
		}
		.reply > .replyUser > .reNickAndDate > .writewrite {
			font-size: 12px;
			color: darkgrey;
		}
		.reply > .comment {
			margin: 10px 45px;
		}
		.viewBody {
			width: 100%;
			height: auto;
			display: flex;
			justify-content: center;
			flex-flow: column;
			margin-top: 90px;
		}
		.viewBody > .mainTable {
			width: 800px;
	   		height: auto;
	   		padding: 50px;
	   		margin: 0 auto;
	   		background-color: #ffffff;
	    	border-radius: 10px;
	    	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.4);
	    	margin-bottom: 80px;
		}
		.viewBody > .mainTable > h3 {
			display: flex;
			justify-content: center;
			font-size: 22px;
		}
		.viewBody > .mainTable > .ifLogin {
			display: flex;
			justify-content: right;
		}
		.viewBody > .mainTable > .userInfo {
			width: 700px;
			height: 50px;
			padding: 20px;
			display: flex;
			margin: 0 auto;
			padding-top: 0;
		}
		.viewBody > .mainTable > .userInfo > img {
			border-radius: 50%;
			width: 50px;
			height: 50px;
			margin-left: 20px; 
		}
		.viewBody > .mainTable > .userInfo > .nickAndDate {
			display: flex;
			flex-flow: column;
			margin-left: 10px;
		}
		.viewBody > .mainTable > .userInfo > .nickAndDate > .nicknick {
			font-size: 18px;	
			font-weight: 400;
		}
		.viewBody > .mainTable > .userInfo > .nickAndDate > .dadatete {
			font-size: 12px;
			color: darkgrey;
		}
		.viewBody > .mainTable > .viewEveryThing {
			width: 680px;
			height: auto;
			padding: 30px;
			margin: 0 auto;
		}
		.viewBody > .mainTable > .underInfo {
			width: 700px;
			height: auto;
			padding: 20px;
			margin: 0 auto;
		}
		.viewBody > .mainTable > .replyList {
			width: 700px;
			height: auto;
			padding: 20px;
			margin: 0 auto;
		}
		.viewBody > .mainTable > .replyList > span {
			margin: 10px;
	   		font-size: 22px;
	   		color: #7a7a7a;
		}
		.viewBody > .mainTable > .viewTitle {
			width: 680px;
			height: 50px;
			padding: 20px;
			display: flex;
			margin: 0 auto;
			font-size: 22px;
			font-weight: 500;
			padding-bottom: 0;
		}
		.viewBody > .mainTable > .viewEveryThing > .viewContent {
			font-size: 18px;
		}
		.viewBody > .mainTable > .viewEveryThing > .viewPhoto {
			display: flex;
			flex-flow: wrap;
			justify-content: space-between;
			height: auto;
		}
		.viewBody > .mainTable > .viewEveryThing > .viewPhoto > img {
			width: 200px;
			border-radius: 15px;
			margin-bottom: 10px;
		}
		.viewBody > .mainTable > .underInfo > .viewTag {
			width: auto;
	   		background-color: #f2f2f2;
	    	border-radius: 10px;
	    	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
	    	padding: 5px;
		}
		.UANDD {
			display: flex;
			justify-content: center;
		}
		.UANDD > .ifLogin {
			width: 800px;
			display: flex;
			justify-content: right;
			padding: 5px 50px;
		}
		.writeReply {
			display: flex;
			flex-flow: column;
			width: 700px;
			padding: 20px;
			margin: 0 auto;
		}
		.writeReply > span {
			margin-left: 10px;
	   		font-size: 14px;
	   		color: #7a7a7a;
		}
		#replyContent {
			width: 680px;
	   		height: 100px;
	   		padding: 5px 10px;
	   		border: 1px solid #dadada;
	   		border-radius: 10px;
	   		font-size: 16px;
	    	font-family: auto;
	    	resize: none;
		}
		#replySubmit {
			background: linear-gradient(70deg, #172d9d, #561689);
	   		color: white;
	   		width: 700px;
	   		height: 40px;
	   		border-radius: 10px;
	   		font-size: 18px;
	   		border: 0;
	   		transition: background 0.4s ease;
		}
		#updateBtn, #deleteBtn {
	    	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.3);
	    	border: 0;
			border-radius: 10px;
			background-color: #f5f6f7;
			margin-left: 10px;
			width: 70px;
			height: 35px;
		}
		#updateBtn:hover {
			background-color: #64c864;
			color: white;
		}
		#deleteBtn:hover {
			background-color: #ff6a84;
			color: white;
		}
 	</style>
	

	<div class="viewBody">
		<c:if test="${board.memberId == login.id}">
			
			<div class="UANDD">
				<p class="ifLogin"> 
				    <span><a href="${cpath }/board/update/${board.id}"><button id="updateBtn">수정</button></a></span>
				    <span><a href="${cpath }/board/delete/${board.id}"><button id="deleteBtn">삭제</button></a></span>
				</p>
			</div>
		</c:if>
		<div class="mainTable">
			<h3>상세 보기</h3>
			
			<hr style="margin: 0; border: 1px solid #f5f6f7;">
			
			<!-- 해당 글 작성자로 로그인한 경우 버튼활성화 -->
			
			<div class="viewTitle">
				${board.title }
			</div>	
		
			<div class="userInfo">
				<img src="${cpath }/upload/${board.memberPhoto != null ? board.memberPhoto : 'default.png' }" width="50">
				<div class="nickAndDate">
					<span class="nicknick">${board.nickname }</span>
					<span class="dadatete">${board.writeDate }</span>
				</div>
			</div>
			<hr style="margin: 0; border: 1px solid #f5f6f7;">
			
			<div class="viewEveryThing">
				<div class="viewContent">
					${board.content }
				</div>
				<div class="viewPhoto">
					<c:forEach var="photo" items="${boardPhotoList }">
						<img src="${cpath }/upload/${photo.storedFileName}">
					</c:forEach>
				</div>
			</div>
			
			
			<div class="underInfo">
				<div id="like">
					<c:if test="${board.like == 1}"> ❤️ </c:if>
					<c:if test="${board.like == 0}"> 🤍 </c:if>
				</div>
				<div class="viewTag">
					${board.tag }
				</div>
			</div>
			
			<hr style="margin: 0; border: 1px solid #eaeaea;">
			
			
			<div class="replyList">
				<span>댓글</span>
				<hr style="margin-top: 25px; border: 1px solid #eaeaea;">
				<c:forEach var="reply" items="${replyList }">
					<div class="reply ${reply.replyDepth == 0 ? 'parent' : '' }" 
					 style="margin-left: ${30 * reply.replyDepth}px;"
					 data-id="${reply.id }" data-depth="${reply.replyDepth }">
					 	<div class="replyUser">
						 	<img src="${cpath }/upload/${reply.memberPhoto != null ? reply.memberPhoto : 'default.png' }" width="50">
						 	<div class="reNickAndDate">
								<span class="namename">${reply.nickname }</span>
								<span class="writewrite">${reply.writeDate }</span>
						 	</div>
					 	</div>
					 	<div class="comment">
							${reply.content}
					 	</div>
					</div>
					<hr style="margin: 0; border: 1px solid #f5f6f7;">
				</c:forEach>
			</div>
		
			
			<div class="replyForm">
				<form id="replyForm" method="POST" action="${cpath }/board/${board.id}">
				    <div class="writeReply">
				    	<span>댓글 작성</span>
				    	<textarea id="replyContent" name="content" required></textarea>
				    	<input id="replySubmit" type="submit" value="댓글 작성">
				    </div>
				    <p><input type="hidden" name="parentId" value="0"></p>
				    <p><input type="hidden" name="replyDepth" value="0"></p>
				</form>
			</div>
				
		</div>
	</div>

	<script>
		// 댓글 
		function clickHandler(event) {
		    let target = this			
		    while (!target.classList.contains('parent')) {
		        target = target.previousElementSibling
		    }
		    
		    const id = +target.dataset.id
			const replyTo = this.children[0].querySelector('span').textContent
	    	const replyContent = replyForm.querySelector('textarea[name="content"]')
	    	const parentIdInput = replyForm.querySelector('input[name="parentId"]')
	    	const replyDepthInput = replyForm.querySelector('input[name="replyDepth"]')
	   		console.log('replydepthinput.value', replyDepthInput.value)
		    
	    	const currentDepth = replyDepthInput.value
	    	console.log('currentDepth', currentDepth)
	    	
	    	if(currentDepth == 1 && parentIdInput.value == id) {	// 답글이라면
	    		replyContent.placeholder = '댓글 작성'
    			replyContent.value = ''
   				parentIdInput.value = 0
				replyDepthInput.value = 0
	    	}
	    	else {													// 답글상태가 아니였다면(그냥 댓글이였다면)
	    		replyContent.placeholder = '@' + replyTo + ' '
		    	replyContent.focus()
		    	parentIdInput.value = id
		    	replyDepthInput.value = 1	// replyDepth는 항상 1	
	    	}
		    
	    	replyForm.onsubmit = function(event) {
	    		const currentDepth = replyDepthInput.value
	    		if (currentDepth == 1) {	// 답글상태라면
	    			replyContent.value = '@' + replyTo + ' ' + replyContent.value
	    		}
	    	} 	
		}
				
		const replyForm = document.getElementById('replyForm')
		const addReplyDiv = document.querySelectorAll('.reply')
		
		addReplyDiv.forEach(reply => reply.addEventListener('click', clickHandler))
	</script>
	
	<script>
		// 좋아요
		async function likeHandler() {
			const url = '${cpath}/boards/likeBoard/${board.id}'
			const result = await fetch(url).then(resp => resp.json())
			console.log(result)
			
			if(result.deleteLike) {
				like.innerText = '🤍'
			} else {
				like.innerText = '❤️'
			}	
		}
		
		const like = document.getElementById('like')
		like.addEventListener('click', likeHandler)
	</script>

<%@ include file="../footer.jsp"%>