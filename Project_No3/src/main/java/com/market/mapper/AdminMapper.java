package com.market.mapper;

import java.util.List;

import com.market.model.BookVO;
import com.market.model.CateVO;
import com.market.model.Criteria2;

public interface AdminMapper {

	/* 상품 등록 */
	public void bookEnroll(BookVO book);
	
	/* 카테고리 리스트 */
	public List<CateVO> cateList();
	
	/* 상품 리스트 */
	public List<BookVO> goodsGetList(Criteria2 cri);
	
	/* 상품 총 개수 */
	public int goodsGetTotal(Criteria2 cri);
	
	/* 상품 상세 조회 페이지 */
	public BookVO goodsGetDetail(int bookId);
	
	/* 상품 수정 */
	public int goodsModify(BookVO vo);
	
	/* 상품 정보 삭제 */
	public int goodsDelete(int bookId);
	
}
