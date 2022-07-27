package com.market.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.market.mapper.MemberMapper;
import com.market.model.MemberVO;

@Service
public class MemberServiceImpl implements MemberService {

	//맵퍼 인터페이스에 지정된 맵퍼 xml 의존 주입
	@Autowired
	MemberMapper membermapper;

	//회원가입
	@Override
	public void memberJoin(MemberVO member) throws Exception {
		membermapper.memberJoin(member);
	}
	
	//회원가입 아이디 중복 검사
	@Override
	public int idCheck(String memberId) throws Exception {
		return membermapper.idCheck(memberId);
	}
	
	/* 로그인 */
    @Override
    public MemberVO memberLogin(MemberVO member) throws Exception {
        return membermapper.memberLogin(member);
    }
    
    /* 주문자 정보 */
	@Override
	public MemberVO getMemberInfo(String memberId) {
		return membermapper.getMemberInfo(memberId);
	}
	
}
