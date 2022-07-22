package com.market.mapper;

import java.util.List;

import com.market.model.BookVO;
import com.market.model.CateVO;
import com.market.model.Criteria2;

public interface BookMapper {

	/* 상품 검색 */
	public List<BookVO> getGoodsList(Criteria2 cri);
	
	/* 상품 총 개수 */
	public int goodsGetTotal(Criteria2 cri);
	
	/* 작가 id 리스트 요청 */
	public String[] getAuthorIdList(String keyword);
	
	/* 국내 카테고리 리스트 */
	public List<CateVO> getCateCode1();
	
	/* 외국 카테고리 리스트 */
	public List<CateVO> getCateCode2();
	
}
