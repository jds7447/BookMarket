/* 상품 등록 시 해당 상품의 모든 데이터가 담기는 객체 */

package com.market.model;

import java.util.Date;
import java.util.List;

import lombok.Data;

/* 이번 VO 객체는 getter/setter/toString 메서드를 생성하지 않고 Lombok 라이브러리를 활용해 자동 생성 */
@Data
public class BookVO {

	/* 상품 id */
	private int bookId;
	
	/* 상품 이름 */
	private String bookName;
	
	/* 작가 id */
	private int authorId;
	
	/* 작가 이름 */
	private String authorName;
	
	/* 출판일 */
	private String publeYear;
	
	/* 출판사 */
	private String publisher;
	
	/* 카테고리 코드 */
	private String cateCode;
	
	/* 카테고리 이름 */
	private String cateName;
	
	/* 상품 가격 */
	private int bookPrice;
	
	/* 상품 재고 */
	private int bookStock;
	
	/* 상품 할인률(백분율) */
	private double bookDiscount;
	
	/* 상품 소개 */
	private String bookIntro;
	
	/* 상품 목차 */
	private String bookContents;
	
	/* 등록 날짜 */
	private Date regDate;
	
	/* 수정 날짜 */
	private Date updateDate;
	
	/* 이미지 정보 */
	private List<AttachImageVO> imageList;
	
	/* 상품 평점 평균 */
	private double ratingAvg;
	
}
