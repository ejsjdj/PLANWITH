package com.itbank.PLANWITH.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;


import com.itbank.PLANWITH.model.MemberDTO;

import lombok.extern.log4j.Log4j;

@Log4j
@Component
public class LoginInterceptor implements HandlerInterceptor {

     @Override
       public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

           // 현재 세션 가져오기 (기존 세션이 없으면 null 반환)
           HttpSession session = request.getSession(false);

           // 세션이 없는 경우 새 세션 생성
           if(session == null) {
//               System.out.println("세션이 유효하지 않음. 새로운 세션 생성");
               session = request.getSession(true);
           }

           // 세션에서 로그인 정보를 가져옴
           MemberDTO login = (MemberDTO) session.getAttribute("login");

           if(login == null) {
               // 로그인 페이지로 리다이렉트
               String redirectUrl = request.getContextPath() + "/member/login";
//               System.out.println("LoginInterceptor: 로그인 정보 없음);
               response.sendRedirect(redirectUrl);

               // 요청 처리 중단
               return false;
           }
           // 로그인된 사용자인 경우 요청을 계속 처리
           return true;
       }

}
