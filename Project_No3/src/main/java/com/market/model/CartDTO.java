/* 장바구니에 담긴 상품 1개의 데이터 객체 */

package com.market.model;

import java.util.List;

public class CartDTO {

	private int cartId;   //장바구니 id
    
    private String memberId;   //장바구니 추가한 회원 id
    
    private int bookId;   //장바구니에 추가된 상품 id
    
    private int bookCount;   //장바구니에 추가된 상품 개수
    
    
    private String bookName;   //장바구니에 추가된 상품 이름
    
    private int bookPrice;   //장바구니에 추가된 상품 가격
    
    private double bookDiscount;   //장바구니에 추가된 상품 할인율
    

    private int salePrice;   //할인율 적용한 상품 가격
    
    private int totalPrice;   //장바구니에 추가된 상품 총합 가격 (salePrice * bookCount)
    
    private int point;   //상품 한 개의 받을 수 있는 포인트
    
    private int totalPoint;   //총 받을 수 있는 포인트 (point * bookCount)
    
    private List<AttachImageVO> imageList;   //상품 이미지 리스트

    
	/* 할인율 적용된 상품 가격, 상품 총합 가격, 상품 한 개의 포인트, 장바구니에 담은 총합 포인트는
	 * setter를 만들지 않고 아래의 메서드로만 초기화 되도록 (다른 멤버들의 값으로 계산하는 것이기 때문) */
    public void initSaleTotal() {
		this.salePrice = (int) (this.bookPrice * (1-this.bookDiscount));
		this.totalPrice = this.salePrice * this.bookCount;
		this.point = (int)(Math.floor(this.salePrice * 0.05));
		this.totalPoint = this.point * this.bookCount;
	}
    
	public int getCartId() {
		return cartId;
	}

	public void setCartId(int cartId) {
		this.cartId = cartId;
	}

	public String getMemberId() {
		return memberId;
	}

	public void setMemberId(String memberId) {
		this.memberId = memberId;
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
		return "CartDTO [cartId=" + cartId + ", memberId=" + memberId + ", bookId=" + bookId + ", bookCount="
				+ bookCount + ", bookName=" + bookName + ", bookPrice=" + bookPrice + ", bookDiscount=" + bookDiscount
				+ ", salePrice=" + salePrice + ", totalPrice=" + totalPrice + ", point=" + point + ", totalPoint="
				+ totalPoint + ", imageList=" + imageList + "]";
	}
    
    
	
}
