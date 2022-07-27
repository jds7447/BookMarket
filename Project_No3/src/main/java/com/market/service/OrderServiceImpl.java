package com.market.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.market.mapper.AttachMapper;
import com.market.mapper.OrderMapper;
import com.market.model.AttachImageVO;
import com.market.model.OrderPageItemDTO;

import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class OrderServiceImpl implements OrderService {

	@Autowired
	private OrderMapper orderMapper;
	
	@Autowired
	private AttachMapper attachMapper;

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
	
	
	
}
