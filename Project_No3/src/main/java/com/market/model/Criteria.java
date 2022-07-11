package com.market.model;

import java.util.Arrays;

/*페이징 쿼리를 동적 제어하기 위해 필요한 데이터 'pageNum'과 'amount'을 같이 파라미터로 전달하기 위한 용도로 Criteria 클래스(class)를 작성
  각각의 데이터를 분리하여 파라미터로 전달해도 되지만 연관성 있는 데이터를 같이 관리함으로써 관리하기 편하고 재사용성에도 장점 때문에 클래스를 작성*/
public class Criteria {
	
	/* 현재 페이지 번호 */
    private int pageNum;
    
    /* 한 페이지 당 보여질 게시물 개수 */
    private int amount;
    
	/* 검색 키워드 */
    private String keyword;
    
    /* 주제별 검색 타입 */
    private String type;
    	// type변수에  담길 데이터는 "T"(제목), "C"(내용), "W"(작성자), "TC"(제목 + 내용), "TW"(제목 + 작성자), "TCW"(제목 + 내용 + 작성자)
    	// "T", "C", "W"와 같이 문자 하나가 저장된 데이터 사용을 위해 "TC", "TW", "TCW" 데이터들이 문자 하나씩 저장된 데이터가 될 수 있도록 배열로 변환
    /* 검색 타입 배열 */
    private String[] typeArr;
    
    /* 기본 생성자 -> 기본 세팅 : pageNum = 1, amount = 10 */
    public Criteria() {
        this(1, 10);
    }
    
    /* 생성자 => 원하는 pageNum, 원하는 amount */
    public Criteria(int pageNum, int amount) {
        this.pageNum = pageNum;
        this.amount = amount;
    }

	public int getPageNum() {
		return pageNum;
	}

	public void setPageNum(int pageNum) {
		this.pageNum = pageNum;
	}

	public int getAmount() {
		return amount;
	}

	public void setAmount(int amount) {
		this.amount = amount;
	}

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
		//type변수에 데이터가 들어왔을 때 자동으로 배열 형식으로 변환하여 typeArr변수에 저장될 수 있도록
		this.typeArr = type.split("");   //String 타입의 데이터를 String 배열 타입 데이터로 변환해주는 split() 메서드
	}

	public String[] getTypeArr() {
		return typeArr;
	}

	public void setTypeArr(String[] typeArr) {
		this.typeArr = typeArr;
	}

	@Override
	public String toString() {
		return "Criteria [pageNum=" + pageNum + ", amount=" + amount + ", keyword=" + keyword + ", type=" + type
				+ ", typeArr=" + Arrays.toString(typeArr) + "]";
	}
    
}
