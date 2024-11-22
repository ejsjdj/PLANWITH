<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>
	
	<style>
		#item {
			border: 2px solid black;
			display: flex;
			justify-content: space-between;
			align-items: center;
		}
		#item > div {
			flex: 1;
		}
	</style>
	
	
	<h3>자유 게시판</h3>
	
	<a id="insert" href="${cpath }/board/insert">작성</a>
	
	<c:forEach var="board" items="${list }">
	<div id="item">
		<div>
			<a href="${cpath }/board/view/${board.id }">${board.title }</a>
		</div>
		<div>
			<p>${board.nickname }</p>
			<p>${board.writeDate }</p>
		</div>
	</div>
	</c:forEach>	
	
</body>
</html>