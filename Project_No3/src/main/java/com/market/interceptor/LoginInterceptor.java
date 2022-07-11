package com.market.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;

public class LoginInterceptor implements HandlerInterceptor {
	
	/* 일어날 확률은 매우 낮지만 이전 작업 중 세션이 완전히 제거되지 않아 로그인을 위해 새로운 세션을 저장할 때 발생할 수 있는 에러를
	 * 방지하기 위해서 로그인 메서드가 있는 MemberController.java에 진입하기 전 세션을 제거하는 작업을 */
	@Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        //Controller에 진입하기 전에 작업을 원하기 때문에 preHandle() 메서드를 오버 라이딩
		System.out.println("LoginInterceptor preHandle 작동");   //확인용
        
        HttpSession session = request.getSession();
        session.invalidate();
		
        return true;
    }
	
}
