package com.market.model;

import java.util.List;

/* 주문되는 상품 1개의 데이터가 들어가는 VO객체 */
public class OrderPageItemDTO {

	/* 뷰로부터 전달받을 값 */
    private int bookId;   //상품 id
    
    private int bookCount;   //상품 개수
    
    
    /* DB로부터 꺼내올 값 */
    private String bookName;   //상품 이름
    
    private int bookPrice;   //상품 가격 (원가)
    
    private double bookDiscount;   //상품 할인율
    
    
    /* 만들어 낼 값 */
    private int salePrice;   //상품 판매가 (할인율 적용된 상품 가격)
    
    private int totalPrice;   //상품 총 가격 (상품 판매가 * 상품 개수)
    
    private int point;   //상품 한 개당 획득 포인트
    
    private int totalPoint;   //총 획득 포인트 (획득 포인트 * 상품 개수)
    
    
    /* 상품 이미지 */
	private List<AttachImageVO> imageList;
    
    
	/* 만들어 낼 값은 전달 받거나 DB에서 꺼내오는 것이 아니라 그 것들로 만들어내는 값이기 때문에
	 * setter를 따로 만들지 않고 아래의 메서드로 만들어낸다 */
    public void initSaleTotal() {
		this.salePrice = (int) (this.bookPrice * (1 - this.bookDiscount));
		this.totalPrice = this.salePrice * this.bookCount;
		this.point = (int)(Math.floor(this.salePrice * 0.05));
		this.totalPoint =this.point * this.bookCount;
	}

	public int getBookId() {
		return bookId;
	}

	public void setBookId(int bookId) {
		this.bookId = bookId;
	}

	public int getBookCount() {
		return bookCount;
	}

	public void setBookCount(int bookCount) {
		this.bookCount = bookCount;
	}

	public String getBookName() {
		return bookName;
	}

	public void setBookName(String bookName) {
		this.bookName = bookName;
	}

	public int getBookPrice() {
		return bookPrice;
	}

	public void setBookPrice(int bookPrice) {
		this.bookPrice = bookPrice;
	}

	public double getBookDiscount() {
		return bookDiscount;
	}

	public void setBookDiscount(double bookDiscount) {
		this.bookDiscount = bookDiscount;
	}

	public int getSalePrice() {
		return salePrice;
	}

	public int getTotalPrice() {
		return totalPrice;
	}

	public int getPoint() {
		return point;
	}

	public int getTotalPoint() {
		return totalPoint;
	}

	public List<AttachImageVO> getImageList() {
		return imageList;
	}

	public void setImageList(List<AttachImageVO> imageList) {
		this.imageList = imageList;
	}
	
	@Override
	public String toString() {
		return "OrderPageItemDTO [bookId=" + bookId + ", bookCount=" + bookCount + ", bookName=" + bookName
				+ ", bookPrice=" + bookPrice + ", bookDiscount=" + bookDiscount + ", salePrice=" + salePrice
				+ ", totalPrice=" + totalPrice + ", point=" + point + ", totalPoint=" + totalPoint + ", imageList="
				+ imageList + "]";
	}
    
}
