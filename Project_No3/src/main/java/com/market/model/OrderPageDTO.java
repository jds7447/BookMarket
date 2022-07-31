package com.market.model;

import java.util.List;

/* 주문 페이지에서 보여줄 상품들의 리스트
 * 주문되는 상품 각각의 개별 객체(OrderPageItemDTO)를 요소로 가지는 List 타입의 변수를 가지는 클래스 */
public class OrderPageDTO {

	private List<OrderPageItemDTO> orders;   //주문되는 상품 리스트

	public List<OrderPageItemDTO> getOrders() {
		return orders;
	}

	public void setOrders(List<OrderPageItemDTO> orders) {
		this.orders = orders;
	}

	@Override
	public String toString() {
		return "OrderPageDTO [orders=" + orders + "]";
	}
	
	
	
}
