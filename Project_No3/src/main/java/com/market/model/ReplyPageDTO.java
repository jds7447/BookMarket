/* 기존 구현의 경우 서버에서 페이징 된 뷰를 반환했는데,
 * 댓글 페이징의 경우는 단순히 서버로부터 댓글과 페이징 정보를 전달받아서 뷰에서 동적으로 댓글 태그들을 만들어 내야 된다는 점 */
/* 서버에서는 두 개의 정보를 만들어서 뷰로 전달해주어야 합
 * 하나는 10개로 페이징 된 '댓글 정보 리스트'를 다른 하나는 회원이 보고자 하는 '페이지 정보'
 * 원래라면 뷰에서는 두 개의 정보를 얻기 위해서 가각 두 번의 ajax 요청을 해야겠지만 한 번의 ajax 요청으로 두 개의 정보를 뷰로 반환할 수 있도록,
 * 두 개의 정보를 담는 그릇이 될 새로운 타입이 될 DTO클래스 */

package com.market.model;

import java.util.List;

import lombok.Data;

@Data
public class ReplyPageDTO {

	List<ReplyDTO> list;
	
	PageMakerDTO2 pageInfo;
	
}
