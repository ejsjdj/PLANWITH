<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>

<script>
	
	// 부모 창이 열려 있는지 확인하고, 로그인 성공 후 부모 창을 새로고침하면서 팝업 닫기
    if (window.opener && !window.opener.closed) {
        // 부모 창의 세션 정보를 업데이트
        window.opener.location.href = '${cpath}/team/teamList'  
        // 부모 창을 메인 페이지로 리다이렉트하여 로그인 상태 반영

        // 일정 지연 시간 후 팝업 닫기
        setTimeout(() => {
            window.close()
        }, 200)
    } else {
        // 부모 창이 없을 경우 (예외 처리)
        location.href = '${cpath}/' // 현재 창에서 메인 페이지로 이동
    }
	
</script>



 
</body>
</html>