package com.market.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.market.mapper.BookMapper;
import com.market.model.BookVO;
import com.market.model.Criteria2;

import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class BookServiceImpl implements BookService {

	@Autowired
	private BookMapper bookMapper;
	
	/* 상품 검색 */
	@Override
	public List<BookVO> getGoodsList(Criteria2 cri) {
		log.info("getGoodsList().......");
		
		String type = cri.getType();   //검색 타입
		String[] typeArr = type.split("");   //검색 타입을 각 단어별로 나눔 (예를들어 TWC 이면 [T, W, C] 형식)
		
		for(String t : typeArr) {
			if(t.equals("A")) {   //검색 타입이 작가일 경우
				String[] authorArr = bookMapper.getAuthorIdList(cri.getKeyword());   //작가 ID 리스트 검색
				cri.setAuthorArr(authorArr);   //작가 ID 리스트를 검색 객체에 담기
			}
		}
		
		return bookMapper.getGoodsList(cri);
	}

	/* 사품 총 개수 */
	@Override
	public int goodsGetTotal(Criteria2 cri) {
		log.info("goodsGetTotal().......");
		return bookMapper.goodsGetTotal(cri);
	}
	
}
