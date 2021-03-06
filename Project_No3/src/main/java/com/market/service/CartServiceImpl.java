package com.market.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.market.mapper.AttachMapper;
import com.market.mapper.CartMapper;
import com.market.model.AttachImageVO;
import com.market.model.CartDTO;

@Service
public class CartServiceImpl implements CartService {

	@Autowired
	private CartMapper cartMapper;
	
	@Autowired
	private AttachMapper attachMapper;
	
	/* 장바구니 추가 */
	@Override
	public int addCart(CartDTO cart) {
		// 장바구니 데이터 체크
		CartDTO checkCart = cartMapper.checkCart(cart);   //등록하려는 상품이 장바구니에 이미 있는 데이터인지 확인
		
		if(checkCart != null) {   //장바구니에 이미 데이터가 있다면 2 반환
			return 2;
		}
		
		try {   //장바구니 등록 메서드에 throws Exception 구문이 작성되어 있기 때문에 try~catch 문으로 감싸
			return cartMapper.addCart(cart);   //장바구니에 데이터가 없다면 요청 데이터를 장바구니에 담고 결과 값 반환
		} catch (Exception e) {   //에러 발생으로 등록 실패 시 0 반환
			return 0;
		}
	}

	/* 장바구니 정보 리스트 */
	@Override
	public List<CartDTO> getCartList(String memberId) {
		List<CartDTO> cart = cartMapper.getCart(memberId);   //회원의 장바구니에 담은 상품 정보를 모두 가져와 리스트로
		
		for(CartDTO dto : cart) {   //반복문을 이용해 각 상품의 initSaleTotal() 메서드를 호출하여
			dto.initSaleTotal();   //'salePrice', 'totalPrice', 'point', 'totalPoint' 변수를 초기화
			
			/* 이미지 정보 얻기 */
			int bookId = dto.getBookId();   //장바구니 상품에서 id 값 가져오기
			List<AttachImageVO> imageList = attachMapper.getAttachList(bookId);   //상품 id로 해당 상품에 등록된 이미지 리스트 가져오기
			dto.setImageList(imageList);   //이미지 리스트를 장바구니 상품 객체에 저장
		}
		
		return cart;   //설정 완료한 장바구니 리스트 반환
	}
	
	/* 카트 수량 수정 */
	@Override
	public int modifyCount(CartDTO cart) {
		return cartMapper.modifyCount(cart);
	}
	
	/* 카트 삭제 */
	@Override
	public int deleteCart(int cartId) {
		return cartMapper.deleteCart(cartId);
	}
	
}
