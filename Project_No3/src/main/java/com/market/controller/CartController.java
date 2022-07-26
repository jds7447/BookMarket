package com.market.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.market.model.CartDTO;
import com.market.model.MemberVO;
import com.market.service.CartService;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class CartController {

	@Autowired
	private CartService cartService;
	
	/* 장바구니에 상품 추가 */
	@PostMapping("/cart/add")
	@ResponseBody   //페이지 전환이 아니기 때문에 @ResponseBody 사용
	public String addCartPOST(CartDTO cart, HttpServletRequest request) {   //장바구니 등록할 객체, 로그인 여부 확인용 세션을 위한 요청 객체
		log.info("addCartPOST..........");
		
		// 로그인 체크
		HttpSession session = request.getSession();
		MemberVO mvo = (MemberVO)session.getAttribute("member");
		if(mvo == null) {   //로그인 안 했으면 5 반환
			return "5";
		}
		
		// 카트 등록
		int result = cartService.addCart(cart);
		
		return result + "";   //int 값을 문자열로 반환하기 위해
	}
	
	/* 장바구니 뷰 페이지 이동 요청을 수행하는 URL매핑 메서드 */
	/* 장바구니 조회를 위해 필요로 한 데이터 memberId를 얻기 위해 파라미터 추가와 PathVariable 패턴의 URL로 작성 (회원 id를 url로 받음)
	 * 조회한 장바구니 데이터를 뷰에 넘기기 위해 Model을 파라미터로 추가 */
	@GetMapping("/cart/{memberId}")
	public String cartPageGET(@PathVariable("memberId") String memberId, Model model) {
		log.info("cartPageGET..........");
		
		model.addAttribute("cartInfo", cartService.getCartList(memberId));   //장바구니 상품 리스트를 뷰로 전송
		
		return "/cart";
	}
	
	/* 카트 수량 수정 */
	@PostMapping("/cart/update")
	public String updateCartPOST(CartDTO cart) {
		log.info("updateCartPOST..........");
		
		cartService.modifyCount(cart);   //전달받은 장바구니 객체에 담긴 수량으로 DB 수정
		
		return "redirect:/cart/" + cart.getMemberId();   //요청했던 유저의 장바구니로 다시 이동
	}
	
	/* 카트 삭제 */
	@PostMapping("/cart/delete")
	public String deleteCartPOST(CartDTO cart) {
		log.info("deleteCartPOST..........");
		
		cartService.deleteCart(cart.getCartId());
		
		return "redirect:/cart/" + cart.getMemberId();
		
	}
	
}
