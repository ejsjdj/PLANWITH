<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp"%>

<style>
h3 {
    display: flex;
    justify-content: center;
}

.bodyBox {
    width: 100%;
    display: flex;
    justify-content: center;
    height: auto;
}

.bodyBox > .inlineBox {
    width: 960px;
    padding: 20px;
    margin: 0 auto;
    height: 100%;
}

.bodyBox > .inlineBox > .items {
    display: flex;
    flex-flow: column;
    width: 100%;
}

.bodyBox > .inlineBox > .items > .item {
    width: 930px;
    margin-bottom: 20px;
    padding: 15px;
    border: 1px solid #ccc;
    border-radius: 8px;
    background-color: #f9f9f9;
}

.bodyBox > .inlineBox > .items > .item:hover {
	border: 1px solid #DEF5EE;
    background-color: #DEF5EE;
	cursor: pointer;
}

.bodyBox > .inlineBox > .items > .item > .title {
    font-weight: bold;
    font-size: 18px;
    color: #0073e6;
}

.bodyBox > .inlineBox > .items > .item > .meta {
    display: flex;
    justify-content: space-between;
    font-size: 12px;
    color: #888;
}

.bodyBox > .inlineBox > .items > .item > .content {
    margin-top: 10px;
    font-size: 14px;
    color: #555;
    line-height: 1.5;
}

#insert {
    display: block;
    text-align: right;
    margin-bottom: 20px;
    font-size: 14px;
    color: #0073e6;
    text-decoration: none;
}
</style>

<div class="bodyBox">
    <div class="inlineBox">
        <h3>자유 게시판</h3>

        <a id="insert" href="${cpath }/board/insert">작성</a>

        <div class="items" id="postContainer">
            <!-- 서버에서 전달된 list를 사용하여 게시글 목록을 출력 -->
            <c:forEach var="board" items="${list}">
                <div class="item" data-id="${board.id }">
                    <!-- 게시글 제목 -->
                    <div class="title">
                        ${board.title }
                    </div>
                    <!-- 게시글 작성자 및 작성일 -->
                    <div class="meta">
                        <span>${board.nickname }</span> <span>${board.writeDate }</span>
                    </div>
                    <!-- 게시글 내용 -->
                    <div class="content">
                        <c:if test="${board.content.length() > 100}">
                            ${board.content.substring(0, 100)}...
                        </c:if>
                        <c:if test="${board.content.length() <= 100}">
                            ${board.content}
                        </c:if>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</div>

<script>
	const itemAll = document.querySelectorAll('.item')
	
	itemAll.forEach(item => item.addEventListener('click', function(event) {
		const id = event.currentTarget.dataset.id
		console.log('id : ' + id)
		location.href = '${cpath}/board/view/' + id
	}))
</script>


</body>
</html>
