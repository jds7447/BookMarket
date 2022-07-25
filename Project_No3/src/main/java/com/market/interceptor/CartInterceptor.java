package com.market.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;

import com.market.model.MemberVO;

/* 장바구니 요청 시 현재 로그인 상태인지 확인 */
public class CartInterceptor implements HandlerInterceptor {

	//Controller에 진입하기 전에 작업을 원하기 때문에 preHandle() 메서드를 오버 라이딩
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		HttpSession session = request.getSession();   //세션을 가져와
		
		MemberVO mvo = (MemberVO)session.getAttribute("member");   //세션에 저장된 로그인 정보 확인
		
		if(mvo == null) {   //로그인 정보가 없으면 로그인 페이지로 리다이렉트
			response.sendRedirect("/member/login");
			return false;
		}
		else {
			return true;
		}
	}

	
	
}
