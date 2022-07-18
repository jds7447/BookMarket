package com.market.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.market.mapper.AdminMapper;
import com.market.model.BookVO;
import com.market.model.CateVO;
import com.market.model.Criteria2;

import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class AdminServiceImpl implements AdminService {

	@Autowired
	private AdminMapper adminMapper;
	
	/* 상품 등록 */
	//트랜잭션 처리하여 하나의 작업에서 에러 발생 시 같이 수행 하던(했던) 작업도 모두 취소
	@Transactional
	@Override
	public void bookEnroll(BookVO book) {
		log.info("(srevice)bookEnroll........");
		adminMapper.bookEnroll(book);
		
		/* 첨부 이미지가 없으면 상품 이미지 등록을 수행하지 않고 메서드 종료 */
		if(book.getImageList() == null || book.getImageList().size() <= 0) {
			return;
		}
		
		/* 상품 이미지 등록 - imageList의 요소의 크기만큼 반복하여 imageEnroll() 메서드를 호출 */
		// 일반적 for문
//        for(int i = 0; i < book.getImageList().size(); i++) {}
        // 향상된 for문
//		for(AttachImageVO attach : book.getImageList()) {}
        //람다식 활용한 for문
		book.getImageList().forEach(attach ->{   //attach 는 AttachImageVO 객체를 의미
			attach.setBookId(book.getBookId());   //위 상품 등록 메서드 myBatis의 selectkey로 인해 가져온 등록된 상품의 id를 이용
			adminMapper.imageEnroll(attach);
		});
	}
	
	/* 카테고리 리스트 */
	@Override
	public List<CateVO> cateList() {
		log.info("(service)cateList........");
		return adminMapper.cateList();
	}
	
	/* 상품 리스트 */
	@Override
	public List<BookVO> goodsGetList(Criteria2 cri) {
		log.info("(service)goodsGetTotalList()..........");
		return adminMapper.goodsGetList(cri);
	}

	/* 상품 총 갯수 */
	public int goodsGetTotal(Criteria2 cri) {
		log.info("(service)goodsGetTotal().........");
		return adminMapper.goodsGetTotal(cri);
	}
	
	/* 상품 상세 조회 페이지 */
	@Override
	public BookVO goodsGetDetail(int bookId) {
		log.info("(service)bookGetDetail......." + bookId);
		return adminMapper.goodsGetDetail(bookId);
	}
	
	/* 상품 정보 수정 */
	@Override
	public int goodsModify(BookVO vo) {
		log.info("goodsModify........");
		return adminMapper.goodsModify(vo);
	}
	
	/* 상품 정보 삭제 */
	@Override
	public int goodsDelete(int bookId) {
		log.info("goodsDelete..........");
		return adminMapper.goodsDelete(bookId);
	}
	
}
