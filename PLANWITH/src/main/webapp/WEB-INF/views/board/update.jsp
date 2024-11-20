<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>

<h3>게시글 수정</h3>

<form method="POST">

    <p><input type="text" id="title" name="title" value="${board.title}"></p>
    <!-- 사진리스트, 삭제버튼 누르면 ajax로 전부삭제, 추가누르면 disable 풀리고 추가만 가능 -->
    
    <p><input type="file" name="files" multiple value="사진추가"></p>
    <textarea name="content">${board.content}</textarea>
    <p><input type="text" id="tag" name="tag" value="${board.tag}"></p>
    <p><input type="submit">수정하기</p>
</form>
</body>
</html>
