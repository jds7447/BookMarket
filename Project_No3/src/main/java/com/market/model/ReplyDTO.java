//댓글 1개의 데이터

package com.market.model;

import java.util.Date;

import lombok.Data;

@Data
public class ReplyDTO {

	private int replyId;   //대글 id
	
	private int bookId;   //상품 id
	
	private String memberId;   //회원 id

	private Date regDate;   //댓글 작성일
	
	private String content;   //댓글 내용
	
	private double rating;   //평점
	
}
