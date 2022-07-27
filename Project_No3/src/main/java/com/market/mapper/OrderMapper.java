package com.market.mapper;

import com.market.model.OrderPageItemDTO;

public interface OrderMapper {

	/* 주문 상품 정보 */
	public OrderPageItemDTO getGoodsInfo(int bookId);
	
}
