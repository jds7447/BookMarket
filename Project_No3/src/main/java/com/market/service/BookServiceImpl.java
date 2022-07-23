package com.market.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.market.mapper.AttachMapper;
import com.market.mapper.BookMapper;
import com.market.model.AttachImageVO;
import com.market.model.BookVO;
import com.market.model.CateFilterDTO;
import com.market.model.CateVO;
import com.market.model.Criteria2;

import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class BookServiceImpl implements BookService {

	@Autowired
	private BookMapper bookMapper;
	
	@Autowired
	private AttachMapper attachMapper;   //이미지 데이터 가져오기 위해
	
	/* 상품 검색 */
	@Override
	public List<BookVO> getGoodsList(Criteria2 cri) {
		log.info("getGoodsList().......");
		
		String type = cri.getType();   //검색 타입
		String[] typeArr = type.split("");   //검색 타입을 각 단어별로 나눔 (예를들어 TWC 이면 [T, W, C] 형식)
		
		/* 작가 검색 조건이 있는 경우에는 검색조건과 상관없는 책 데이터들이 검색됨
		 * 작가 정보의 경우 getAuthorIdList() Mapper 메서드로부터 반환받은 데이터를 활용해서 동적 쿼리에 사용이 되는데,
		 * 작가 정보가 없는 경우 요소가 없는 빈 배열 객체가 MyBatis 쿼리문에 전달되어서 작가 조건문이 추가되지 않은 쿼리문이 사용되게 되기 때문
		 * MyBatis쿼리문에 <if> 혹은 <choose>, <when> 태그를 추가하여 보완을 해줄 수도 있겠지만,
		 * getAuthorIdList() Mapper 메서드의 결과가 요소가 없는 빈 배열을 반환하게 된다면 검색 쿼리 결과도 없어야 하는 것이기 때문에
		 * Service 단계에서 getAuthorIdList() 메서드가 빈 배열을 반환할 시 Controller에 요소가 없는 빈 List를 반환하도록 코드를 수정 */
//		for(String t : typeArr) {
//			if(t.equals("A")) {   //검색 타입이 작가일 경우
//				String[] authorArr = bookMapper.getAuthorIdList(cri.getKeyword());   //작가 ID 리스트 검색
//				cri.setAuthorArr(authorArr);   //작가 ID 리스트를 검색 객체에 담기
//			}
//		}
		String[] authorArr = null;   //작가 ID 리스트 담을 문자열 배열
		
		if(type.equals("A") || type.equals("AC") || type.equals("AT") || type.equals("ACT")) {   //검색 타입에 작가 타입이 들어갈 경우
			authorArr = bookMapper.getAuthorIdList(cri.getKeyword());   //작가 이름 키워드를 통해 작가 ID 리스트 검색
			
			if(authorArr.length == 0) {   //검색한 작가 키워드에 해당하는 작가가 없는 경우
				return new ArrayList();   //컨트롤러에 빈 배열 객체를 반환 후 메서드 종료
			}
		}
		
		for(String t : typeArr) {   //검색 타입 하나씩 확인 (위의 if문을 통과 했다는건 작가 리스트에 요소가 들어있다는 것)
			if(t.equals("A")) {   //검색 타입이 작가 타입인 경우
				cri.setAuthorArr(authorArr);   //작가 리스트를 검색 객체에 추가
			}
		}
		
		/* 상품 검색 후 검색된 상품 목록에 각 상품마다 등록된 이미지 미리보기를 추가하기 위해 반환값에 이미지 데이터 추가 */
//		return bookMapper.getGoodsList(cri);
		List<BookVO> list = bookMapper.getGoodsList(cri);   //반환할 상품 객체
		/* 반복문을 이용해 반환할 상품 객체 리스트에 담긴 각 상품마다의 id를 이용해 이미지 데이터 검색 후 해당 객체의 이미지 리스트에 담기 */
		list.forEach(book -> {
			int bookId = book.getBookId();   //상품 ID
			
			List<AttachImageVO> imageList = attachMapper.getAttachList(bookId);   //해당 상품에 등록된 이미지 데이터 리스트
			
			book.setImageList(imageList);   //상품에 이미지 데이터 적용
		});
		return list;
	}

	/* 사품 총 개수 */
	@Override
	public int goodsGetTotal(Criteria2 cri) {
		log.info("goodsGetTotal().......");
		return bookMapper.goodsGetTotal(cri);
	}
	
	/* 국내 카테고리 리스트 */
	@Override
	public List<CateVO> getCateCode1() {
		log.info("getCateCode1().........");
		return bookMapper.getCateCode1();
	}

	/* 외국 카테고리 리스트 */
	@Override
	public List<CateVO> getCateCode2() {
		log.info("getCateCode2().........");
		return bookMapper.getCateCode2();
	}
	
	/* 검색결과 카테고리 필터 정보 */
	@Override
	public List<CateFilterDTO> getCateInfoList(Criteria2 cri) {
		List<CateFilterDTO> filterInfoList = new ArrayList<CateFilterDTO>();   //반환할 카테고리 정보 데이터가 담길 상자 역할
		
		String[] typeArr = cri.getType().split("");
		String [] authorArr;
		
		for(String type : typeArr) {   //검색 타입 확인
			if(type.equals("A")) {   //검색 타입이 작가인 경우
				authorArr = bookMapper.getAuthorIdList(cri.getKeyword());   //검색 키워드가 포함된 작가 이름을 가진 작가 id 리스트 획득
				if(authorArr.length == 0) {   //해당 작가가 없는 경우 빈 카테고리 정보 객체를 반환
					return filterInfoList;
				}
				cri.setAuthorArr(authorArr);
			}
		}
		
		String[] cateList = bookMapper.getCateList(cri);   //검색 대상의 카테고리 코드 리스트 획득
		
		String tempCateCode = cri.getCateCode();   //검색 객체에 담겨 전달받은 카테고리 코드를 임시로 담을 변수
		
		for(String cateCode : cateList) {   //획득한 카테고리 리스트의 카테고리 코드들을 하나씩 순회하며 해당 코드에 맞는 카테고리 정보를 얻어 리스트에 담기
			cri.setCateCode(cateCode);
			CateFilterDTO filterInfo = bookMapper.getCateInfo(cri);
			filterInfoList.add(filterInfo);
		}
		
		cri.setCateCode(tempCateCode);   //임시로 저장했던 기존의 카테고리 코드를 다시 검색 객체에 담기

		return filterInfoList;   //검색 대상의 카테고리 정보 리스트를 반환
	}
	
}
