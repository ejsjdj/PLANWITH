<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>

<script>
	if (window.opener && !window.opener.closed) {
	    window.opener.location.href = '${cpath}/team/viewTeams'  
	    setTimeout(() => {
	        window.close()
	    }, 200)    
	} else {	    
	    location.href = '${cpath}/' 
	}
</script>  

</body>
</html>


