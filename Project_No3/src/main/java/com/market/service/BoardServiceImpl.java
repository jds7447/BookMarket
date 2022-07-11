package com.market.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.market.mapper.BoardMapper;
import com.market.model.BoardVO;
import com.market.model.Criteria;

/*
런타입 시에 BoardService 인터페이스에 주입될 서비스 객체
게시판에 관련된 비즈니스 로직을 담당 
*/
@Service
public class BoardServiceImpl implements BoardService {
	/* 네임스페이스 설정으로 BoardMapper.xml 설정이 주입된 BoardMapper.java 인터페이스 */
	@Autowired
	private BoardMapper mapper;
	
	/* 맵퍼에서 게시글 등록 SQL을 호출하는 메서드 (DB에 전달받은 게시글 데이터를 삽입한다) */
	@Override
	public void enroll(BoardVO board) {
		mapper.enroll(board);
	}
	
	/* 맵퍼에서 게시글 목록 불러오는 SQL을 호출하는 메서드 (DB에 등록된 모든 게시글을 List 형식으로 불러온다) */
	@Override
    public List<BoardVO> getList() {
        return mapper.getList();
    }
	
	/* 게시글 목록 (페이징 적용) - cri 객체에 설정된 페지지 번호, 페이지당 게시물 수 멤버를 통해 최근 작성된 게시물 부터 일정 범위를 조회하는 SQL 호출 메서드 */
    @Override
    public List<BoardVO> getListPaging(Criteria cri) {
        return mapper.getListPaging(cri);
    }
    
    /* 맵퍼에서 게시글 총 개수를 조회하는 SQL을 호출하는 메서드 (페이징 계산을 위해 총 게시물 개수가 필요) */
    @Override
    public int getTotal(Criteria cri) {
        return mapper.getTotal(cri);
    } 
	
	/* 맵퍼에서 게시글을 조회하는 SQL을 호출하는 메서드 (게시글 목록에서 선택한 게시글의 상세 내용을 불러온다) */
    @Override
    public BoardVO getPage(int bno) {
        return mapper.getPage(bno);
    }
    
    /* 맵퍼에서 게시글을 수정하는 SQL을 호출하는 메서드 (게시글 조회 페이지에서 해당 게시글의 내용을 수정하여 저장한다) */
    @Override
    public int modify(BoardVO board) {   //게시글 수정 후 SQL 결과 값으로 성공 유무를 판별할 것이 아니라면
    	return mapper.modify(board);   //게시글 등록 메서드 처럼 반환값 void로 변경하고, return을 없애도 됨
    }
    
    /* 맵퍼에서 게시글을 삭제하는 SQL을 호출하는 메서드 (게시글 수정 페이지에서 해당 게시글 삭제 버튼 클릭) */
    @Override
    public int delete(int bno) {
        return mapper.delete(bno);
    }
    
}
