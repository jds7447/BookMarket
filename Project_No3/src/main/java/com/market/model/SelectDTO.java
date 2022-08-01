/* 메인 페이지에 보여질 평점 높은 상품들 각 1개의 데이터가 담길 객체 */

package com.market.model;

import java.util.List;

import lombok.Data;

@Data
public class SelectDTO {

	/* 상품 id */
	private int bookId;
	
	/* 상품 이름 */
	private String bookName;
	
	/* 카테고리 이름 */
	private String cateName;
	
	/* 평균 평점 */
	private double ratingAvg;	
	
	/* 상품 이미지 */
	private List<AttachImageVO> imageList;
	
}
