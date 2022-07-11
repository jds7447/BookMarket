package com.market.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class BookController {
	
	//@Log4j 어노테이션 사용 안할 시
//	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	
	//메인 페이지 이동
	@RequestMapping(value = "/main", method = RequestMethod.GET)   // 혹은 @GetMapping("/main")
	public void mainPageGET() {
		log.info("'메인' 페이지 진입");   //@Log4j 어노테이션 사용 안할 시 ==> logger.info("...");
	}
	
}
