package com.market.model;

import lombok.Data;

@Data
public class OrderCancelDTO {

	/* 주문 취소 시 필요 데이터 */
	private String memberId;   //회원 ID
	
	private String orderId;   //주문 ID
	
	
	/* 주문 취소 후 기존 페이지로 돌아가기 위한 페이징 데이터 */
	private String keyword;   //검색 키워드
	
	private int amount;   //보여질 데이터 개수
	
	private int pageNum;   //페이지 번호
	
	
	
	
}
