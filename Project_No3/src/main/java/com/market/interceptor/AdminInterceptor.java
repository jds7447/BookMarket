package com.market.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;

import com.market.model.MemberVO;

/* 관리자 메서드("/admin/**")에 접근하는 사용자의 admiCk 1인지 확인하는 작업이 핵심 */
public class AdminInterceptor implements HandlerInterceptor {
	
	/* "member"session정보를 MemberVO타입의 변수에 담은 후, 해당 변수를 통해 admiCk의 값을 호출하여 비교하는 로직 필요 */
	@Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        //Controller에 진입하기 전에 작업을 원하기 때문에 preHandle() 메서드를 오버 라이딩
		System.out.println("AdminInterceptor preHandle 작동");   //확인용
		
		//"member" session을 호출하여 MemberVO타입의 lvo 변수에 저장
		HttpSession session = request.getSession();
        MemberVO lvo = (MemberVO)session.getAttribute("member");   //MemberVO 타입으로 형 변환(Casting) - 세션 저장 시 Object 타입으로 저장됨
        
        if(lvo == null || lvo.getAdminCk() == 0) {   // 관리자 계정 아닌 경우
            response.sendRedirect("/main");   // 메인 페이지로 리다이렉트
            return false;
        }
        
        return true;   // 관리자 계정 로그인 경우(lvo != null && lvo.getAdminCk() == 1)
    }
	
}
