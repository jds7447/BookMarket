package com.market.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.market.mapper.ReplyMapper;
import com.market.model.Criteria2;
import com.market.model.PageMakerDTO2;
import com.market.model.ReplyDTO;
import com.market.model.ReplyPageDTO;

@Service
public class ReplyServiceImpl implements ReplyService {
	
	@Autowired
	private ReplyMapper replyMapper;

	/* 댓글등록 */
	@Override
	public int enrollReply(ReplyDTO dto) {
		int result = replyMapper.enrollReply(dto);
		
		return result;
	}

	/* 댓글 존재 체크 */
	@Override
	public String checkReply(ReplyDTO dto) {
		Integer result = replyMapper.checkReply(dto);
		
		if(result == null) {   //이전에 작성한 댓글 없음
			return "0";
		} else {   //해당 상품에 이미 댓글을 작성 했음
			return "1";
		}
	}
	
	/* 댓글 페이징 */
	@Override
	@Transactional
	public ReplyPageDTO replyList(Criteria2 cri) {
		ReplyPageDTO dto = new ReplyPageDTO();
		
		dto.setList(replyMapper.getReplyList(cri));   //댓글 리스트
		dto.setPageInfo(new PageMakerDTO2(cri, replyMapper.getReplyTotal(cri.getBookId())));   //페이징 데이터
		
		return dto;
	}
	
}
