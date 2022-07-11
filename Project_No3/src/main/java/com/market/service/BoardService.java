package com.market.service;

import java.util.List;

import com.market.model.BoardVO;
import com.market.model.Criteria;

/*
DI를 위한 서비스 인터페이스
코드 상에선 어떤 객체인지 정의되지 않으나
런타임 시 설정에 따른 객체가 주입되어 해당 객체의 동작을 수행한다
SOLID 원칙 중 OCP(개방 폐쇄 원칙)을 준수하여 변화에는 닫혀있고 확장에는 열려있는 형태이다
즉, 해당 인터페이스를 이용하는 객체들을 부품이라고 했을 때 월할 때마다 부품을 추가하거나 바꿔 끼울 수 있기 때문에
굳이 부품 객체들의 코드를 하나씩 수정할 필요가 없다
*/
public interface BoardService {
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
