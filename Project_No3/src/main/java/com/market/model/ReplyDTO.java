//댓글 1개의 데이터

package com.market.model;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

@Data
public class ReplyDTO {

	private int replyId;   //대글 id
	
	private int bookId;   //상품 id
	
	private String memberId;   //회원 id

	/* Gson, Jackson 라이브러리를 사용해서 Date, LocalDateTime 타입의 데이터를 json으로 변환할 경우 "yyyy-MM-dd" 형식 변환되지 않는다
	 * 따라서 json으로 변환 대상인 Date, LocalDateTime 타입의 데이터에 어떠한 형식(포맷)으로 변환할지를 지정 해
	 * regDate 변수에 json으로 변환시 지정 형식으로 변하도록 설정해주는 어노테이션을 추가
	 * patter속성 값에 원하는 포맷을 작성 */
	@JsonFormat(shape= JsonFormat.Shape.STRING, pattern="yyyy-MM-dd", timezone="Asia/Seoul")
	private Date regDate;   //댓글 작성일
	
	private String content;   //댓글 내용
	
	private double rating;   //평점
	
}
