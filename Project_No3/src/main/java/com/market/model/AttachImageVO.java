/* 이미지에 대한 정보 중에 '경로', 'uuid', '파일 이름'에 대한 데이터 그리고 해당 이미지를 업로드한 '상품의 id' 
 * 상품 등록 시 같이 업로드 하는 이미지의 데이터가 담기는 객체 */

package com.market.model;

import lombok.Data;

@Data
public class AttachImageVO {

	/* 경로 */
	private String uploadPath;
	
	/* uuid */
	private String uuid;
	
	/* 파일 이름 */
	private String fileName;
	
	/* 상품 id */
	private int bookId;
	
}
