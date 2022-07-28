package com.market.mapper;

import com.market.model.BookVO;
import com.market.model.MemberVO;
import com.market.model.OrderDTO;
import com.market.model.OrderItemDTO;
import com.market.model.OrderPageItemDTO;

public interface OrderMapper {

	/* 주문 상품 정보 */
	public OrderPageItemDTO getGoodsInfo(int bookId);
	
	/* 주문 상품 정보 (주문 처리) */
	public OrderItemDTO getOrderInfo(int bookId);
	
	/* 주문 테이블 등록 */
	public int enrollOrder(OrderDTO ord);
	
	/* 주문 아이템 테이블 등록 */
	public int enrollOrderItem(OrderItemDTO orid);
	
	/* 주문 금액 차감 */
	public int deductMoney(MemberVO member);
	
	/* 주문 재고 차감 */
	public int deductStock(BookVO book);
	
}
