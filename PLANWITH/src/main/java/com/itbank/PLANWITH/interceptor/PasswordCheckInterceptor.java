package com.itbank.PLANWITH.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

@Component
public class PasswordCheckInterceptor implements HandlerInterceptor {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
	        throws Exception {
	    String uri = request.getRequestURI();
	    String contextPath = request.getContextPath();
	    String relativeUri = uri.substring(contextPath.length());

	    // 인터셉터를 우회할 경로
	    if (relativeUri.equals("/member/checkPassword") || relativeUri.startsWith("/resources/")) {
	        return true;
	    }

	    HttpSession session = request.getSession(false);

	    if (session == null || session.getAttribute("login") == null) {
	        response.sendRedirect(contextPath + "/member/login");
	        return false;
	    }

	    // SNS 로그인 사용자인 경우 인터셉터 우회
	    Boolean snsLogin = (Boolean) session.getAttribute("snsLogin");
	    if (snsLogin != null && snsLogin) {
	        return true;
	    }

	    // 일반 로그인 사용자의 경우 비밀번호 확인 여부 검사
	    Boolean passwordCheck = (Boolean) session.getAttribute("passwordCheck");

	    if (passwordCheck == null || !passwordCheck) {
	        session.setAttribute("redirectAfterPasswordCheck", relativeUri);
	        response.sendRedirect(contextPath + "/member/checkPassword");
	        return false;
	    }

	    return true;
	}


}
