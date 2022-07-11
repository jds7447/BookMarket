package com.market.mapper;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.market.model.Criteria;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class BoardMapperTests {
 
     private static final Logger log = LoggerFactory.getLogger(BoardMapperTests.class);
     
     @Autowired
     private BoardMapper mapper;
     
     /* 게시글 등록 테스트 */
//     @Test
//     public void testEnroll() {
//         BoardVO vo = new BoardVO();
//         
//         vo.setTitle("mapper test");
//         vo.setContent("mapper test");
//         vo.setWriter("mapper test");
//         
//         mapper.enroll(vo);
//     }
     
     /* 게시글 목록 테스트 */
//     @Test
//     public void testGetList() {
//         List list = mapper.getList();
//        /* 일반적 for문 */
//         for(int i = 0; i < list.size();i++) {
//             log.info("" + list.get(i));
//         }
//        /* foreach문(향상된 for문) */
//         for(Object a : list) {
//             log.info("" + a);
//         }
//        /* foreach문 & 람다식 */
//         list.forEach(board -> log.info("" + board));
//     }
     
     /* 게시글 조회 테스트 */
//     @Test
//     public void testGetPage() {
//    	 /* DB에 존재하는 페이지 번호 */
//    	 int bno = 8;
//
//    	 log.info("" + mapper.getPage(bno));
//     }
     
     /* 게시글 수정 테스트 */
//     @Test
//     public void testModify() {
//         BoardVO board = new BoardVO();
//         board.setBno(8);
//         board.setTitle("수정 제목");
//         board.setContent("수정 내용");
//         
//         int result = mapper.modify(board);
//         log.info("result : " +result);
//     }
     
     /* 게시글 삭제 테스트 */
//     @Test
//     public void testDelete() {
//         int result = mapper.delete(7);
//         log.info("result : " + result);
//     }
     
     /* 게시판 목록(페이징 적용) 테스트 */
     @Test
     public void testGetListPaging() {
         Criteria cri = new Criteria();
//         cri.setPageNum(2);
         List list = mapper.getListPaging(cri);
         list.forEach(board -> log.info("" + board));
     }
 
}
