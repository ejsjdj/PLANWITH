<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>
	
	
<!-- 	임시 수정임다.     -->
	
	
	<style>
		.reply {
			border: 1px solid grey;
			display: flex;
			justify-content: space-between;
			align-items: center;
		}	
		.viewBody {
			width: 100%;
			height: 100%;
			display: flex;
			justify-content: center;
		}
		.viewBody > .mainTable {
			width: 1160px;
			padding: 20px;
		}
		.viewBody > .mainTable > .ifLogin {
			display: flex;
			justify-content: right;
		}
		.viewBody > .mainTable > .userInfo {
			width: 1120px;
			height: 50px;
			padding: 20px;
			border: 1px dashed red; 
			display: flex;
		}
		.viewBody > .mainTable > .userInfo > img {
			border-radius: 50%;
			width: 50px;
			height: 50px;
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
			width: 1120px;
			height: 300px;
			padding: 20px;
			border: 1px dashed orange;
		}
		.viewBody > .mainTable > .underInfo {
			width: 1120px;
			height: 30px;
			padding: 20px;
			border: 1px dashed yellow;
		}
		.viewBody > .mainTable > .replyList {
			width: 1120px;
			height: auto;
			padding: 20px;
			border: 1px dashed green;
		}
	</style>
	
	<div class="viewBody">
		<div class="mainTable">
			<h3>상세 보기</h3>
			
			<!-- 해당 글 작성자로 로그인한 경우 버튼활성화 -->
			<c:if test="${board.memberId == login.id}">
				<p class="ifLogin"> 
				    <span><a href="${cpath }/board/update/${board.id}"><button id="updateBtn">수정</button></a></span>
				    <span><a href="${cpath }/board/delete/${board.id}"><button id="deleteBtn">삭제</button></a></span>
				</p>
			</c:if>
			
		
			<div class="userInfo">
				<img src="${cpath }/upload/${board.memberPhoto != null ? board.memberPhoto : 'default.png' }" width="50">
				<div class="nickAndDate">
					<span class="nicknick">${board.nickname }</span>
					<span class="dadatete">${board.writeDate }</span>
				</div>
			</div>
			
			
			<div class="viewEveryThing">
				<div class="viewTitle">
					${board.title }
				</div>	
				<div class="viewContent">
					${board.content }
				</div>
				<div class="viewPhoto">
					<c:forEach var="photo" items="${boardPhotoList }">
						<img src="${cpath }/upload/${photo.storedFileName}" width="100">
					</c:forEach>
				</div>
			</div>
			
			
			<div class="underInfo">
				<div id="like">
					<c:if test="${board.like == 1}"> ❤️ </c:if>
					<c:if test="${board.like == 0}"> 🤍 </c:if>
				</div>
			</div>
			
			
			
			<div class="replyList">
				<c:forEach var="reply" items="${replyList }">
					<div class="reply ${reply.replyDepth == 0 ? 'parent' : '' }" 
					 style="margin-left: ${30 * reply.replyDepth}px;"
					 data-id="${reply.id }" data-depth="${reply.replyDepth }">
					 	<div>
							<p>${reply.id } | <span>${reply.nickname }</span> | ${reply.writeDate }</p>
							<p>${reply.content}</p>
					 	</div>
					</div>
				</c:forEach>
			</div>
		
			<div class="replyForm">
				<form id="replyForm" method="POST" action="${cpath }/board/${board.id}">
				    <p>
				    	<textarea name="content" placeholder="댓글 작성" required></textarea>
				    	<input type="submit" value="댓글 작성">
				    </p>
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
			const replyTo = event.target.children[0].querySelector('span').textContent
	    	const replyContent = replyForm.querySelector('textarea[name="content"]')
		       
	    	replyContent.placeholder = '@' + replyTo + ' '
	    	replyContent.focus()
	    	replyForm.querySelector('input[name="parentId"]').value = id
	    	replyForm.querySelector('input[name="replyDepth"]').value = 1	// replyDepth는 항상 1	
	    	
	    	replyForm.onsubmit = function(event) {
	    		replyContent.value = '@' + replyTo + ' ' + replyContent.value
		    	console.log(replyForm.querySelector('textarea[name="content"]').value)
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
	
	
</body>
</html>