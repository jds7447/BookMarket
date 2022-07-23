package com.market.service;

import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class BookServiceTests {

	@Autowired
	BookService service;
	
//	@Test
//	public void getCateInfoListTest1() {
//		Criteria2 cri = new Criteria2();
//	
//		String type = "TC";
//		//String keyword = "테스트";
//		String keyword = "없음";	
//		String cateCode="103002";
//
//		cri.setType(type);
//		cri.setKeyword(keyword);
//		cri.setCateCode(cateCode);
//		
//		System.out.println("List<CateFilterDTO> : " + service.getCateInfoList(cri));
//	}
	
//	@Test
//	public void getCateInfoListTest2() {
//		Criteria2 cri = new Criteria2();
//	
//		String type = "AC";
//		String keyword = "유홍준";	
//		//String keyword = "머스크";	
//		String cateCode = "103002";
//
//		cri.setType(type);
//		cri.setKeyword(keyword);
//		cri.setCateCode(cateCode);
//		
//		System.out.println("List<CateFilterDTO> : " + service.getCateInfoList(cri));
//	}	

//	@Test
//	public void getCateInfoListTest3() {
//		Criteria2 cri = new Criteria2();
//	
//		String type = "T";
//		String keyword = "테스트";
//		//String keyword = "없음";	
//		
//
//		cri.setType(type);
//		cri.setKeyword(keyword);
//		
//		System.out.println("List<CateFilterDTO> : " + service.getCateInfoList(cri));
//	}	
	
//	@Test
//	public void getCateInfoListTest4() {
//		Criteria2 cri = new Criteria2();
//	
//		String type = "AC";
//		//String keyword = "유홍준";	
//		String keyword = "머스크";	
//
//		cri.setType(type);
//		cri.setKeyword(keyword);
//		
//		System.out.println("List<CateFilterDTO> : " + service.getCateInfoList(cri));
//	}
	
}
