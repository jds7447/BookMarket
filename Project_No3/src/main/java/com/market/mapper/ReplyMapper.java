package com.market.mapper;

import java.util.List;

import com.market.model.Criteria2;
import com.market.model.ReplyDTO;

public interface ReplyMapper {

	/* 댓글 등록 */
	public int enrollReply(ReplyDTO dto);
	
	/* 댓글 존재 체크 */
	/* 반환 타입을 int가 아닌 Integer를 지정
	 * memberId와 bookId를 조건으로 하는 행이 없을 경우 MyBatis는 null을 반환
	 * 그런데 int 타입은 null 값이 없기 때문에 반환 타입이 int일 경우 에러가 발생
	 * 따라서 null 값도 가질 수 있는 Integer를 반환 타입으로 지정 */
	public Integer checkReply(ReplyDTO dto);
	
	/* 댓글 페이징 */
	public List<ReplyDTO> getReplyList(Criteria2 cri);
	
	/* 댓글 총 개수 (페이징) */
	public int getReplyTotal(int bookId);
	
}
