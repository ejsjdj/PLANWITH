<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp"%>

<h2>비밀번호 확인</h2>

<form id="passwordForm" method="POST">
    <label for="password">비밀번호:</label> 
    <input type="password" name="password" id="password" placeholder="비밀번호를 입력하세요" required>
    <button type="submit">확인</button>
</form>

<a href="${cpath}/member/info">돌아가기</a>

<script>
    const result = "${result}"
    const message = "${message}"
      
    if (message ) {
        swal({
            title: result === "true" ? "성공" : "오류",
            text: message,
            icon: result === "true" ? "success" : "error",
            button: "확인"
        }).then(() => {
            if (result === "true") {
                window.location.href = "${cpath}/member/info"
            }
        })
    }
    const passwordForm = document.getElementById('passwordForm')
</script>
