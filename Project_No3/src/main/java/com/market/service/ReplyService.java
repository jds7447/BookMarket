package com.market.service;

import com.market.model.Criteria2;
import com.market.model.ReplyDTO;
import com.market.model.ReplyPageDTO;

public interface ReplyService {
	
	/* 댓글 등록 */
	public int enrollReply(ReplyDTO dto);
	
	/* 댓글 존재 체크 */
	/* 반환 타입은 String으로 지정 - 댓글이 존재할 경우 "1"을 존재하지 않을 경우 "0"을 반환 */
	public String checkReply(ReplyDTO dto);
	
	/* 댓글 페이징 */
	public ReplyPageDTO replyList(Criteria2 cri);

}
