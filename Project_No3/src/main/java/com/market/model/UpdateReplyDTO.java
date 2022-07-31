/* 평점 평균값을 book_goods 테이블의 ratingAvg에 반영할때 실행될 쿼리에는 '반영 할 평점 평균 값'과
 * 어떠한 상품 평균 값을 구할지에 대한 조건인 '상품 번호(bookId)'가 필요
 * 따라서 평균값 반영 쿼리를 실행 할 Mapper 메서드에 두개의 데이터를 한번에 전달하기 위한 VO 객체 */

package com.market.model;

import lombok.Data;

@Data
public class UpdateReplyDTO {
	
	private int bookId;   //상품 id
	
	private double ratingAvg;   //상품의 평균 평점

}
