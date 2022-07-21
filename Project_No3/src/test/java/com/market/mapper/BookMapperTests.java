package com.market.mapper;

import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class BookMapperTests {

	@Autowired
	private BookMapper mapper;
	
	/* 상품 검색 */
//	@Test
//	public void getGoodsListTest() {
//		Criteria2 cri = new Criteria2();
//		
//		// 테스트 키워드
//		//cri.setKeyword("test");
//		System.out.println("cri : " + cri);
//		
//		List<BookVO> list = mapper.getGoodsList(cri);
//		System.out.println("list : " + list);
//		
//		System.out.println("==========");
//		int goodsTotal = mapper.goodsGetTotal(cri);
//		System.out.println("totla : " + goodsTotal);
//	}
	
	/* 작가 id 리스트 요청 */
//	@Test
//	public void getAuthorId() {
//		String keyword = "폴";
//		
//		String[] list = mapper.getAuthorIdList(keyword);
//		
//		System.out.println("결과 : " + list.toString());
//		
//		for(String id : list) {
//			System.out.println("개별 결과 : " + id);
//		}
//	}
	
	/* 검색 (동적 쿼리 적용) - 작가*/
//	@Test 
//	public void getGoodsListTest1() {
//		Criteria2 cri = new Criteria2();
//		String type = "A";
//		String keyword = "유홍준";		// DB에 등록된 작가 데이터
////        String keyword = "없음";		// DB에 등록되지 않은 작가 데이터
//		String catecode = "";
//		
//		cri.setType(type);
//		cri.setKeyword(keyword);
//		cri.setAuthorArr(mapper.getAuthorIdList(keyword));
//		cri.setCateCode(catecode);
//		
//		List<BookVO> list = mapper.getGoodsList(cri);
//		
//		System.out.println("cri : " + cri);
//		System.out.println("list : " + list);
//	}
	
	/* 검색 (동적 쿼리 적용) - 책제목*/
//	@Test 
//	public void getGoodsListTest2() {
//		Criteria2 cri = new Criteria2();
//		String type = "T";
//		String keyword = "테스트";			// 테이블에 등록된 책 제목 데이터
////		String keyword = "없음";				// 테이블에 등록되지 않은 데이터
//		String catecode = "";	
//		
//		cri.setType(type);
//		cri.setKeyword(keyword);
//		cri.setAuthorArr(mapper.getAuthorIdList(keyword));
//		cri.setCateCode(catecode);
//		
//		List<BookVO> list = mapper.getGoodsList(cri);
//		
//		System.out.println("cri : " + cri);
//		System.out.println("list : " + list);
//	}
	
	/* 검색 (동적 쿼리 적용) - 카테고리*/
//	@Test 
//	public void getGoodsListTest3() {
//		Criteria2 cri = new Criteria2();
//		String type = "C";
//		String keyword = "";
//		String catecode = "103002";		
//		
//		cri.setType(type);
//		cri.setKeyword(keyword);
//		cri.setAuthorArr(mapper.getAuthorIdList(keyword));
//		cri.setCateCode(catecode);
//		
//		List<BookVO> list = mapper.getGoodsList(cri);
//		
//		System.out.println("cri : " + cri);
//		System.out.println("list : " + list);
//	}
	
	/* 검색 (동적 쿼리 적용) - 카테고리 + 작가 */
//	@Test 
//	public void getGoodsListTest4() {
//		Criteria2 cri = new Criteria2();
//		String type = "AC";
////		String keyword = "위지";	// 카테고리에 존재하는 작가
//		String keyword = "머스크";	// 카테고리에 존재하지 않는 작가
//		String catecode = "105002";
//		
//		cri.setType(type);
//		cri.setKeyword(keyword);
//		cri.setAuthorArr(mapper.getAuthorIdList(keyword));
//		cri.setCateCode(catecode);
//		
//		List<BookVO> list = mapper.getGoodsList(cri);
//		
//		System.out.println("cri : " + cri);
//		System.out.println("list : " + list);	
//	}
	
	/* 검색 (동적 쿼리 적용) - 카테고리 + 책 제목 */
//	@Test 
//	public void getGoodsListTest5() {
//		Criteria2 cri = new Criteria2();
//		String type = "CT";
//		String keyword = "테스트";   // 카테고리에 존재하는 책
////		String keyword = "없음";   // 카테고리에 존재하지 않는 책
//		String catecode = "101002";
//		
//		cri.setType(type);
//		cri.setKeyword(keyword);
//		cri.setAuthorArr(mapper.getAuthorIdList(keyword));
//		cri.setCateCode(catecode);
//		
//		List<BookVO> list = mapper.getGoodsList(cri);
//		
//		System.out.println("cri : " + cri);
//		System.out.println("list : " + list);
//	}
	
	
	
}
