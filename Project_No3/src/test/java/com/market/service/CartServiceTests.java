package com.market.service;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.market.model.CartDTO;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class CartServiceTests {

	@Autowired
	private CartService service;
	
	//등록 테스트
	@Test
	public void addCartTest() {
		String memberId = "admin";
		int bookId = 22;
		int count = 5;
		
		CartDTO dto = new CartDTO(); 
		dto.setMemberId(memberId);
		dto.setBookId(bookId);
		dto.setBookCount(count);
		
		int result = service.addCart(dto);
		
		System.out.println("** result : " + result);
	}
	
}
