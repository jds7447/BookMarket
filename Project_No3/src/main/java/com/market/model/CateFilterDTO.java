/* 상품 검색 시 해당 검색 조건에 하당하는 데이터들을 카테고리별로 분류하여 필터링하여 볼 수 있도록
 * 각 카테고리 분류별 데이터 1개가 담긴 객체 */

package com.market.model;

public class CateFilterDTO {

	/* 카테고리 이름 */
	private String cateName;
	
	/* 카테고리 넘버 */
	private String cateCode;;
	
	/* 카테고리 상품 수 */
	private int cateCount;	
	
	/* 국내,국외 분류 */
	private String cateGroup;

	public String getCateName() {
		return cateName;
	}

	public void setCateName(String cateName) {
		this.cateName = cateName;
	}

	public String getCateCode() {
		return cateCode;
	}

	public void setCateCode(String cateCode) {
		this.cateCode = cateCode;
		this.cateGroup = cateCode.split("")[0];   // cateCode변수에 값이 들어올 때 국내의 경우 1, 국외의 경우 2가 값이 되도록 세팅
	}

	public int getCateCount() {
		return cateCount;
	}

	public void setCateCount(int cateCount) {
		this.cateCount = cateCount;
	}

	public String getCateGroup() {
		return cateGroup;
	}

	public void setCateGroup(String cateGroup) {
		this.cateGroup = cateGroup;
	}

	@Override
	public String toString() {
		return "CateFilterVO [cateName=" + cateName + ", cateCode=" + cateCode + ", cateCount=" + cateCount
				+ ", cateGroup=" + cateGroup + "]";
	}
	
	
	
}
