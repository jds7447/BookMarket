package com.market.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.market.mapper.ReplyMapper;
import com.market.model.Criteria2;
import com.market.model.PageMakerDTO2;
import com.market.model.ReplyDTO;
import com.market.model.ReplyPageDTO;
import com.market.model.UpdateReplyDTO;

@Service
public class ReplyServiceImpl implements ReplyService {
	
	@Autowired
	private ReplyMapper replyMapper;

	/* 댓글등록 */
	@Override
	public int enrollReply(ReplyDTO dto) {
		int result = replyMapper.enrollReply(dto);
		setRating(dto.getBookId());   //댓글에 등록된 평점을 상품의 평점 평균에 적용
		
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
	
	/* 댓글 수정 */
	@Override
	public int updateReply(ReplyDTO dto) {
		int result = replyMapper.updateReply(dto);
		setRating(dto.getBookId());   //댓글의 수정된 평점을 상품의 평점 평균에 적용
		
		return result;
	}
	
	/* 댓글 한개 정보 (수정 페이지에서 보여줄) */
	@Override
	public ReplyDTO getUpdateReply(int replyId) {
		return replyMapper.getUpdateReply(replyId);
	}
	
	/* 댓글 삭제 */
	@Override
	public int deleteReply(ReplyDTO dto) {
		int result = replyMapper.deleteReply(dto.getReplyId()); 
		setRating(dto.getBookId());   //삭제된 댓글의 평점을 상품의 평점 평균에 적용
		
		return result;
	}
	
	/* 댓글 평점의 평균 값 구하여 상품에 반영 */
	public void setRating(int bookId) {
		Double ratingAvg = replyMapper.getRatingAverage(bookId);   //평점 평균 값
		
		if(ratingAvg == null) {   //등록된 평점이 없으면 평균 값 0으로
			ratingAvg = 0.0;
		}
		
		/* 혹시 평점 평균 컬럼 데이터 타입에 number(2,1) 이 아니라 number 로만 작성하여 DB에 소수점이 길게 표시되는 경우 아래 코드 추가 */
//		ratingAvg = (double) (Math.round(ratingAvg*10));   //Math.round(부동소수점) : 소수점 첫째 자리에서 반올림하여 long 형 정수로 반환
//		ratingAvg = ratingAvg / 10;
		//즉, 평정 평균 값에 10을 곱하고, 그 값의 소수점 첫째 자리에서 반올림 후 (double)로 캐스팅하여 xx.0 형태로 만들고, 10으로 나눠 x.x 형태로 만든다
		
		//평점 평균 객체에 상품 id와 평균 셋팅
		UpdateReplyDTO urd = new UpdateReplyDTO();
		urd.setBookId(bookId);
		urd.setRatingAvg(ratingAvg);
		
		replyMapper.updateRating(urd);   //해당 상품에 평점 평균 적용
	}
	
}
