package com.market.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.market.model.ReplyDTO;
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
	
}
