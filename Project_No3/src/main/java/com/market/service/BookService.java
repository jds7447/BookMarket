package com.market.service;

import java.util.List;

import com.market.model.BookVO;
import com.market.model.CateVO;
import com.market.model.Criteria2;

public interface BookService {

	/* 상품 검색 */
	public List<BookVO> getGoodsList(Criteria2 cri);
	
	/* 상품 총 갯수 */
	public int goodsGetTotal(Criteria2 cri);
	
	/* 국내 카테고리 리스트 */
	public List<CateVO> getCateCode1();
	
	/* 외국 카테고리 리스트 */
	public List<CateVO> getCateCode2();
	
}
