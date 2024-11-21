<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>
	
	<style>
		.reply {
			border: 1px solid grey;
			display: flex;
			justify-content: space-between;
			align-items: center;
		}
		
	</style>
	
	
	<h3>상세 보기</h3>
	
	<!-- 해당 글 작성자로 로그인한 경우 버튼활성화 -->
	<c:if test="${board.memberId == login.id}">
	    <span><a href="${cpath }/board/update/${board.id}"><button>수정</button></a></span>
	    <span><a href="${cpath }/board/delete/${board.id}"><button>삭제</button></a></span>
	</c:if>

	<p>
		${board.id } | ${board.title } | ${board.writeDate } | 
		<img src="${cpath }/upload/${board.memberPhoto != null ? board.memberPhoto : 'default.png' }" width="50">
		<span>${board.nickname }</span>
	</p>	
	<hr>	
	<div>
		<c:forEach var="photo" items="${boardPhotoList }">
			<img src="${cpath }/upload/${photo.storedFileName}" width="100">
		</c:forEach>
	</div>
	<div>${board.content }</div>
	<hr>

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

	<script>
		function clickHandler(event) {
		    let target = this
		    while (!target.classList.contains('parent')) {
		        target = target.previousElementSibling
		    }
		    
		    const id = +target.dataset.id
			const replyTo = event.target.children[0].querySelector('span').textContent
			console.log(replyTo)
	    	const replyContent = replyForm.querySelector('textarea[name="content"]')
		    
		    // replyDepth는 항상 1
		    
	    	event.target.appendChild(replyForm);
	    	replyContent.placeholder = '@' + replyTo + ' '
	    	replyContent.focus()
	    	replyForm.querySelector('input[name="parentId"]').value = id
	    	replyForm.querySelector('input[name="replyDepth"]').value = 1
	    	
	    	replyForm.onsubmit = function(event) {
	    		replyContent.value = '@' + replyTo + ' ' + replyContent.value
		    	console.log(replyForm.querySelector('textarea[name="content"]').value)
	    	}    	
		}
		
		const replyForm = document.getElementById('replyForm')
		const addReplyDiv = document.querySelectorAll('.reply')
		
		addReplyDiv.forEach(reply => reply.addEventListener('click', clickHandler))
	</script>
</body>
</html>