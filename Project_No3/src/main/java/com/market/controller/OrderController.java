package com.market.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import com.market.model.MemberVO;
import com.market.model.OrderDTO;
import com.market.model.OrderPageDTO;
import com.market.service.MemberService;
import com.market.service.OrderService;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class OrderController {
	
	@Autowired
	private OrderService orderService;
	
	@Autowired
	private MemberService memberService;

	/* '주문 페이지' 이동을 수행하는 URL 매핑 메서드 */
	@GetMapping("/order/{memberId}")
	public String orderPgaeGET(@PathVariable("memberId") String memberId, OrderPageDTO opd, Model model) {
		log.info("orderPgaeGET..........");
		
		model.addAttribute("orderList", orderService.getGoodsInfo(opd.getOrders()));   //상품 정보
		model.addAttribute("memberInfo", memberService.getMemberInfo(memberId));   //회원 정보
		
		return "/order";
	}
	
	/* 뷰에서 요청하는 "주문"을 처리하는 URL 매핑 메서드 */
	@PostMapping("/order")
	public String orderPagePost(OrderDTO od, HttpServletRequest request) {
		log.info("orderPagePost..........");
		
		orderService.order(od);   //상품 주문 서비스(비즈니스 로직 수행)
		
		/* 메인 페이지 우측 회원 정보 칸을 주문 후 정보로 최신화 */
		MemberVO member = new MemberVO();   //주문한 회원 정보 담을 회원 정보 객체
		member.setMemberId(od.getMemberId());   //주문한 회원 정보 중 id 값을 새로 만든 회원 정보 객체에 저장
		
		HttpSession session = request.getSession();
		
		try {
			MemberVO memberLogin = memberService.memberLogin(member);   //전달하는 회원 객체의 id를 이용해 최신화 된 회원 정보 가져오기
			memberLogin.setMemberPw("");   //보안을 위해 암호화 된 비밀번호 값은 공란으로 설정
			session.setAttribute("member", memberLogin);   //세션에 최신화 된 회원 정보 셋팅
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "redirect:/main";
	}
	
}
