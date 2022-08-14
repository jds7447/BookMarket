package com.market.service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.market.mapper.AttachMapper;
import com.market.mapper.BookMapper;
import com.market.mapper.CartMapper;
import com.market.mapper.MemberMapper;
import com.market.mapper.OrderMapper;
import com.market.model.AttachImageVO;
import com.market.model.BookVO;
import com.market.model.CartDTO;
import com.market.model.MemberVO;
import com.market.model.OrderCancelDTO;
import com.market.model.OrderDTO;
import com.market.model.OrderItemDTO;
import com.market.model.OrderPageItemDTO;

import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class OrderServiceImpl implements OrderService {

	@Autowired
	private OrderMapper orderMapper;
	
	@Autowired
	private AttachMapper attachMapper;
	
	@Autowired
	private MemberMapper memberMapper;
	
	@Autowired
	private CartMapper cartMapper;
	
	@Autowired
	private BookMapper bookMapper;

	@Override
	public List<OrderPageItemDTO> getGoodsInfo(List<OrderPageItemDTO> orders) {
		List<OrderPageItemDTO> result = new ArrayList<OrderPageItemDTO>();   //데이터를 담아 반환할 주문 상품 리스트 객체
		
		for(OrderPageItemDTO ord : orders) {   //반복문을 통해 전달 받은 상품 주문 리스트에 담긴 주문 상품들을 하나씩 꺼내기
			//반환 객체에 넣을 새로운 주문 상품 객체를 생성하고,
			OrderPageItemDTO goodsInfo = orderMapper.getGoodsInfo(ord.getBookId());   //주문 상품 객체의 상품 id를 통해 DB에서 상품 정보 획득
			
			goodsInfo.setBookCount(ord.getBookCount());   //기존 주문 상품 객체의 주문 개수를 새로운 주문 상품 객체에 저장
			
			goodsInfo.initSaleTotal();   //새로운 주문 상품 객체의 4가지 값 설정
			
			List<AttachImageVO> imageList = attachMapper.getAttachList(goodsInfo.getBookId());   //상품에 등록된 이미지 가져와 리스트에 담기
			
			goodsInfo.setImageList(imageList);   //이미지 리스트를 새로운 주문 상품 객체에 저장
			
			result.add(goodsInfo);   //반환 객체에 새로운 주문 상품 객체를 저장
		}
		
		return result;
	}
	
	/* 주문 */
	@Override
	@Transactional
	public void order(OrderDTO ord) {
		/* 사용할 데이터가져오기 */
		/* 회원 정보 */
		MemberVO member = memberMapper.getMemberInfo(ord.getMemberId());
		/* 주문 정보 */
		List<OrderItemDTO> ords = new ArrayList<>();
		for(OrderItemDTO oit : ord.getOrders()) {
			OrderItemDTO orderItem = orderMapper.getOrderInfo(oit.getBookId());
			// 수량 셋팅
			orderItem.setBookCount(oit.getBookCount());
			// 기본정보 셋팅
			orderItem.initSaleTotal();
			//List객체 추가
			ords.add(orderItem);
		}
		/* OrderDTO 셋팅 */
		ord.setOrders(ords);
		ord.getOrderPriceInfo();
		
		/*DB 주문,주문상품(,배송정보) 넣기*/
		/* orderId만들기 및 OrderDTO객체 orderId에 저장 */
		Date date = new Date();
		SimpleDateFormat format = new SimpleDateFormat("_yyyyMMddHHmmss");
		String orderId = member.getMemberId() + format.format(date);   //"회원 아이디" + "_년도 월 일 시 분 초"
		ord.setOrderId(orderId);
		/* db넣기 */
		orderMapper.enrollOrder(ord);   //book_order 등록
		for(OrderItemDTO oit : ord.getOrders()) {   //book_orderItem 등록
			oit.setOrderId(orderId);
			orderMapper.enrollOrderItem(oit);			
		}
		
		/* 비용 포인트 변동 적용 */
		/* 비용 차감 & 변동 돈(money) Member객체 적용 */
		int calMoney = member.getMoney();
		calMoney -= ord.getOrderFinalSalePrice();
		member.setMoney(calMoney);
		/* 포인트 차감, 포인트 증가 & 변동 포인트(point) Member객체 적용 */
		int calPoint = member.getPoint();
		calPoint = calPoint - ord.getUsePoint() + ord.getOrderSavePoint();	// 기존 포인트 - 사용 포인트 + 획득 포인트
		member.setPoint(calPoint);
		/* 변동 돈, 포인트 DB 적용 */
		orderMapper.deductMoney(member);
		
		/* 재고 변동 적용 */
		for(OrderItemDTO oit : ord.getOrders()) {
			/* 변동 재고 값 구하기 */
			BookVO book = bookMapper.getGoodsInfo(oit.getBookId());
			book.setBookStock(book.getBookStock() - oit.getBookCount());   //상품 재고 - 주문 수량
			/* 변동 값 DB 적용 */
			orderMapper.deductStock(book);
		}
		
		/* 장바구니 제거 */
		for(OrderItemDTO oit : ord.getOrders()) {   //주문 완료 제품 장바구니에서 제거
			CartDTO dto = new CartDTO();
			dto.setMemberId(ord.getMemberId());
			dto.setBookId(oit.getBookId());
			
			cartMapper.deleteOrderCart(dto);
		}
	}
	
	/* 주문취소 */
	@Override
	@Transactional
	public void orderCancle(OrderCancelDTO dto) {
		/* 주문, 주문상품 객체 (데이터 가져오기) */
		/*회원*/
		MemberVO member = memberMapper.getMemberInfo(dto.getMemberId());   //주문 취소한 회원 정보 (BOOK_MEMBER 테이블)
		
		/*주문상품*/
		List<OrderItemDTO> ords = orderMapper.getOrderItemInfo(dto.getOrderId());   //주문한 상품들 리스트 (BOOK_ORDERITEM 테이블)
		
		for(OrderItemDTO ord : ords) {   //각 상품들의 총 가격, 포인트 등 계산 값들 셋팅
			ord.initSaleTotal();
		}
		
		/* 주문 */
		OrderDTO orw = orderMapper.getOrder(dto.getOrderId());   //주문 정보 (BOOK_ORDER 테이블)
		orw.setOrders(ords);   //주문 정보에 주문 상품들 정보 담기
		orw.getOrderPriceInfo();   //주문 정보에 배송비, 최종 가격 등 계산 값들 셋팅
		
		/* 주문상품 취소 DB */
		orderMapper.orderCancle(dto.getOrderId());
		
		
		/* 주문 취소로 돈, 포인트, 재고 변환 (주문 전으로 복구) */
		/* 돈 */
		int calMoney = member.getMoney();   //회원 돈
		calMoney += orw.getOrderFinalSalePrice();   //주문 시 결제 금액을 회원 돈에 추가
		member.setMoney(calMoney);   //회원에게 주문 금액 추가된 돈 셋팅
		
		/* 포인트 */
		int calPoint = member.getPoint();   //회원 포인트
		calPoint = calPoint + orw.getUsePoint() - orw.getOrderSavePoint();   //회원 포인트에 사용 포인트 더하고 적립 포인트 빼기
		member.setPoint(calPoint);   //계산된 포인트를 회원에게 셋팅
		
		/* 셋팅한 돈과 포인트 적용된 회원 데이터 DB적용 */
		orderMapper.deductMoney(member);
		
		/* 재고 */
		for(OrderItemDTO ord : orw.getOrders()) {   //주문 정보에 저장한 주문 상품 정보들을 하나씩 꺼내 반복
			BookVO book = bookMapper.getGoodsInfo(ord.getBookId());   //각 주문 상품의 상품 정보
			book.setBookStock(book.getBookStock() + ord.getBookCount());   //각 상품 정보의 재고 수량에 주문 수량 더하기
			orderMapper.deductStock(book);   //DB에 재고 수량 적용
		}
	}
	
}
