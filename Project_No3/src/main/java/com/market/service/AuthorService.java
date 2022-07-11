package com.market.service;

import java.util.List;

import com.market.model.AuthorVO;
import com.market.model.Criteria2;

/* 비즈니스 로직 => AuthorService.java, AuthorServiceImpl.java - 작가 등록 로직 구현 */
public interface AuthorService {
	
	/* 작가 등록 */
    public void authorEnroll(AuthorVO author) throws Exception;
    
    /* 작가 목록(관리) */
    public List<AuthorVO> authorGetList(Criteria2 cri) throws Exception;
    
    /* 작가 총 수 */
    public int authorGetTotal(Criteria2 cri) throws Exception; 
    
    /* 작가 상세 */
	public AuthorVO authorGetDetail(int authorId) throws Exception;
	
	/* 작가 정보 수정 */
	public int authorModify(AuthorVO author) throws Exception;
    
}
