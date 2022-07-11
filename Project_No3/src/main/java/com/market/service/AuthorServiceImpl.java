package com.market.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.market.mapper.AuthorMapper;
import com.market.model.AuthorVO;
import com.market.model.Criteria2;

import lombok.extern.log4j.Log4j;

/* 비즈니스 로직 => AuthorService.java, AuthorServiceImpl.java - 작가 등록 로직 구현 */
@Service
@Log4j
public class AuthorServiceImpl implements AuthorService {
	
//	private static final Logger log = LoggerFactory.getLogger(AuthorServiceImpl.class);

	@Autowired
    AuthorMapper authorMapper;
	
	/* 작가 등록 */
	@Override
    public void authorEnroll(AuthorVO author) throws Exception {
        authorMapper.authorEnroll(author);
    }
	
	/* 작가 목록(관리) */
    @Override
    public List<AuthorVO> authorGetList(Criteria2 cri) throws Exception {
    	log.info("(secive)authorGetList().........." + cri);
        return authorMapper.authorGetList(cri);
    }
    
    /* 작가 총 수 */
    @Override
    public int authorGetTotal(Criteria2 cri) throws Exception {
        log.info("(service)authorGetTotal()......." + cri);
        return authorMapper.authorGetTotal(cri);
    }
    
    /* 작가 상세 */
	@Override
	public AuthorVO authorGetDetail(int authorId) throws Exception {
		log.info("authorGetDetail........" + authorId);
		return authorMapper.authorGetDetail(authorId);
	}
	
	/* 작가 정보 수정 */
	@Override
	public int authorModify(AuthorVO author) throws Exception {
		log.info("(service) authorModify........." + author);
		return authorMapper.authorModify(author);   //수정 성공 시 1 반환, 실패 시 0 반환
	}
	
}
