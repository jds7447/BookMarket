/* 각 카테고리 하나의 데이터를 담는 객체 */

package com.market.model;

import lombok.Data;

/* 상품 카테고리 리스트 객체 - 카테고리 테이블(book_bcate)의 데이터를 저장할 그릇 */
@Data   //Lombok 라이브러리 활용 - getter/setter/toString 메서드 자동 생성
public class CateVO {

	/* 카테고리 등급 */
	private int tier;
	
	/* 카테고리 이름 */
	private String cateName;
	
	/* 카테고리 넘버 */
	private String cateCode;
	
	/* 상위 카테고리 */
	private String cateParent;
	
}
