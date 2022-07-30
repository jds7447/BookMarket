package com.market.service;

import java.util.List;

import com.market.model.BookVO;
import com.market.model.CateFilterDTO;
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
	
	/* 검색결과 카테고리 필터 정보 */
	public List<CateFilterDTO> getCateInfoList(Criteria2 cri);
	
	/* 상품 상세 정보 */
	public BookVO getGoodsInfo(int bookId);
	
	/* 상품 id 이름 */
	public BookVO getBookIdName(int bookId);
	
}
