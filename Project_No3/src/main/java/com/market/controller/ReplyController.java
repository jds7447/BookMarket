package com.market.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.market.model.Criteria2;
import com.market.model.ReplyDTO;
import com.market.model.ReplyPageDTO;
import com.market.service.ReplyService;

import lombok.extern.log4j.Log4j;

/* 댓글 요청 처리의 경우 전부 뷰를 만들지 않고 http body에 바로 데이터를 담아 반환할 것이기 때문에 
@Controller 어노테이션 대신 @RestController 어노테이션을 추가 */
@RestController
@Log4j
@RequestMapping("/reply")
public class ReplyController {

	@Autowired
	private ReplyService replyService;
	
	/* 댓글 등록 */
	@PostMapping("/enroll")
	public void enrollReplyPOST(ReplyDTO dto) {
		log.info("enrollReplyPOST..........");
		replyService.enrollReply(dto);
	}
	
	/* 댓글 존재 체크 */
	/* memberId, bookId 파라미터 */
	/* 존재 : 1 / 존재x : 0 */
	@PostMapping("/check")
	public String replyCheckPOST(ReplyDTO dto) {
		log.info("replyCheckPOST..........");
		return replyService.checkReply(dto);
	}
	
	/* 댓글 페이징 */
	/* 댓글 페이징 동작 흐름
	 * 뷰에서 댓글 페이지 정보를 요청하며, bookId와 페이징 정보(요청 페이지(pageNum), 표시 량(amount))를 서버로 전송
	 * "reply/list" URL 매핑 메서드가 동작
	 * 댓글 페이징 정보를 만들어내는 Service 메서드를 호출
	 * Service 메서드는 '댓글 페이징 정보'와 '댓글 총 개수'를 반환 해주는 Mapper 메서드 2 개를 호출
	 * '댓글 총 갯수' 값은 '페이지 정보'인 담기는 PageMakerDTO2 객체를 만드는 데 사용
	 * Service 메서드에서 ReplyPageDTO 객체 생성하여 '댓글 페이징 정보'와 '페이지 정보'를 담은 후 해당 객체를 반환
	 * Controller은 반환받은 ReplyPageDTO 뷰로 전송
	 * ReplyPageDTO는 JSON 데이터로 변환되어 뷰로 전송 */
	@GetMapping(value="/list", produces = MediaType.APPLICATION_JSON_VALUE)
	public ReplyPageDTO replyListPOST(Criteria2 cri) {
		log.info("replyListPOST..........");
		return replyService.replyList(cri);
	}
	
	/* 댓글 수정 */
	@PostMapping("/update")
	public void replyModifyPOST(ReplyDTO dto) {   //뷰로부터 전달받는 데이터는 replyId, content, rating 이므로 다 담을 수 있는 ReplyDTO 타입을 파라미터로
		log.info("replyModifyPOST..........");
		replyService.updateReply(dto);
	}
	
	/* 댓글 삭제 */
	@PostMapping("/delete")
	public void replyDeletePOST(ReplyDTO dto) {
		log.info("replyDeletePOST..........");
		replyService.deleteReply(dto);
	}
	
}
