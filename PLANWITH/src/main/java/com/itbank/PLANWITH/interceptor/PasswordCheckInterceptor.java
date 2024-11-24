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
        // 요청 URI 및 컨텍스트 경로 가져오기
        String uri = request.getRequestURI(); // 요청된 전체 URI
        String contextPath = request.getContextPath(); // 애플리케이션의 컨텍스트 경로
        String relativeUri = uri.substring(contextPath.length()); // 컨텍스트 경로를 제외한 상대 URI

        // 인터셉터를 우회할 경로
        if (relativeUri.equals("/member/checkPassword") || relativeUri.startsWith("/resources/")) {
            // 비밀번호 확인 페이지와 정적 자원 경로는 인터셉터를 통과시킴
        	// 요청된 URI가 /resources/로 시작하는지 확인합니다.
        	// /resources/는 일반적으로 CSS, JavaScript, 이미지 파일과 같은 정적 자원(static resources)을 제공하는 경로입니다.
            return true;
        }

        // **세션 확인 및 로그인 여부 검사**
        HttpSession session = request.getSession(false); // 세션이 없으면 null 반환
        if (session == null || session.getAttribute("login") == null) {
            // 로그인 상태가 아니면 로그인 페이지로 리다이렉트
            response.sendRedirect(contextPath + "/member/login");
            return false; // 요청 중단
        }

        // SNS 로그인 사용자 확인
        Boolean snsLogin = (Boolean) session.getAttribute("snsLogin"); // SNS 로그인 여부
        if (snsLogin != null && snsLogin) {
            // SNS 로그인 사용자는 비밀번호 확인 과정 우회
            return true;
        }

        // 일반 로그인 사용자의 비밀번호 확인 여부 검사
        Boolean passwordCheck = (Boolean) session.getAttribute("passwordCheck"); // 비밀번호 확인 상태
        if (passwordCheck == null || !passwordCheck) {
            // 비밀번호가 확인되지 않은 경우
            session.setAttribute("redirectAfterPasswordCheck", relativeUri); // 확인 후 이동할 URI 저장
            response.sendRedirect(contextPath + "/member/checkPassword"); // 비밀번호 확인 페이지로 리다이렉트
            return false; // 요청 중단
        }

        // 비밀번호 확인이 완료된 경우 요청을 진행
        return true;
    }
}

