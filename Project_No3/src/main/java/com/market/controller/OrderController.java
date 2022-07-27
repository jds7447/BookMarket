package com.market.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

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
	
}
