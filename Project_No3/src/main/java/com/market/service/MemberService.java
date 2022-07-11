package com.market.service;

import com.market.model.MemberVO;

/*
DI를 위한 서비스 인터페이스
코드 상에선 어떤 객체인지 정의되지 않으나
런타임 시 설정에 따른 객체가 주입되어 해당 객체의 동작을 수행한다
SOLID 원칙 중 OCP(개방 폐쇄 원칙)을 준수하여 변화에는 닫혀있고 확장에는 열려있는 형태이다
즉, 해당 인터페이스를 이용하는 객체들을 부품이라고 했을 때 월할 때마다 부품을 추가하거나 바꿔 끼울 수 있기 때문에
굳이 부품 객체들의 코드를 하나씩 수정할 필요가 없다
*/
public interface MemberService {

	//회원가입
	public void memberJoin(MemberVO member) throws Exception;
	
	//회원가입 아이디 중복 검사
	public int idCheck(String memberId) throws Exception;
	
	/* 로그인 */
    public MemberVO memberLogin(MemberVO member) throws Exception;
	
}
