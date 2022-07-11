package com.market.mapper;

import java.util.List;

import com.market.model.BoardVO;
import com.market.model.Criteria;

/*
mapper.xml 파일의 네임 스페이스 속성 값이 이 인터페이스 경로 이름으로 설정되어
마이바티스가 SQL 처리시 이 인터페이스와 xml 파일을 병합으로 처리하여
메서드 선언은 인터페이스가 담당하지만 SQL 처리는 xml 파일의 설정 값으로 처리한다
즉, 런타임 시 com.market.mapper.BoardMapper 인터페이스에 com.market.mapper.BoardMapper XML 파일이 주입된다고 생각하면 편할 듯 함
*/

public interface BoardMapper {
	
	/* 게시글 등록 */
    public void enroll(BoardVO board);
    
    /* 게시글 목록 */
    public List<BoardVO> getList();
    
    /* 게시글 목록 (페이징 적용) */
    public List<BoardVO> getListPaging(Criteria cri);
    
    /* 게시글 총 개수 */
    public int getTotal(Criteria cri);
    
    /* 게시글 조회 */
    public BoardVO getPage(int bno);
    
    /* 게시글 수정 */
    public int modify(BoardVO board);
    
    /* 게시글 삭제 */
    public int delete(int bno);
    
}
