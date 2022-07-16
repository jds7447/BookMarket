package com.market.mapper;

import java.util.List;

import com.market.model.AuthorVO;
import com.market.model.Criteria2;

/* 영속 계층 => AuthorMapper.xml, AuthorMapper.java - 작가 등록 연산 수행 */
public interface AuthorMapper {

	/* 작가 등록 */
    public void authorEnroll(AuthorVO author);
    
	/* 작가 목록(관리) */
    public List<AuthorVO> authorGetList(Criteria2 cri);
    
    /* 작가 총 수 */
    public int authorGetTotal(Criteria2 cri);
    
    /* 작가 상세 */
	public AuthorVO authorGetDetail(int authorId);
	
	/* 작가 정보 수정 */
	public int authorModify(AuthorVO author);
	
	/* 작가 정보 삭제 */
	public int authorDelete(int authorId);
	
}
