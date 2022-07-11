package com.market.model;

/* 페이징 이동
사용자가 마우스 클릭을 통해 페이지를 이동 할 수 있도록 해주는 인터페이스를 구현하고자
화면에 표시되는 페이지 번호, 현재 보이는 페이지의 '이전 페이지'와 '다음 페이지', 현재 페이지 표시
3가지 정보를 서버에서 Model 담아서 뷰로 전송하여, 뷰가 이를 활용하여 화면에 표시
위의 3가지 정보를 한 번에 각 단계끼리 교환될 수 있도록 클래스에 정의하여 사용
*/
public class PageMakerDTO2 {
	/* 시작 페이지 번호 */
    private int startPage;
    
    /* 끝 페이지 번호 */
    private int endPage;
    
    /* 이전 페이지, 다음 페이지 버튼 존재유무 */
    private boolean prev, next;
    
    /* 전체 작가 수 (행 개수) */
    private int total;
    
    /* 현재페이지 번호(pageNum), 행 표시 수(amount), 검색 키워드(keyword), 검색 종류(type) */
    private Criteria2 cri;
    
    /* 생성자 */
    public PageMakerDTO2(Criteria2 cri, int total) {
        this.cri = cri;
        this.total = total;
        
        //화면에 보여질 페이지의 개수는 10개 단위 (1~10, 11~20, ...)
        /* 마지막 페이지 (현재 화면에서 보여질 페이지 끝 번호) */
        this.endPage = (int)(Math.ceil(cri.getPageNum()/10.0))*10;   //Math.ceil : 소수점 올림 (예시: Math.ceil(0.1) --> 1.0)
        
        /* 시작 페이지 (현재 화면에서 보여질 페이지 시작 번호) */
        this.startPage = this.endPage - 9;
        
        /* 전체 마지막 페이지 (페이지의 총 개수를 의미, 페이지당 표시할 게시글 개수에 따라 페이지 총 개수가 달라짐) */
        int realEnd = (int)(Math.ceil(total * 1.0/cri.getAmount()));   //1.0을 곱해 실수 계산으로 바꿔 낱개 게시글이 마지막 페이지에 표시 되도록
        
        /* 전체 마지막 페이지(realend)가 화면에 보여질 마지막 페이지(endPage)보다 작은 경우, 마지막 페이지(endPage) 값을 전체 마지막 페이지 값으로 조정 */
        if(realEnd < this.endPage) {
            this.endPage = realEnd;
        }
        
        /* 시작 페이지(startPage)값이 1보다 큰 경우 true (예시: 페이지 표시 11~20 에서 이전(1~10) 페이지가 존재할 경우 true) */
        this.prev = this.startPage > 1;
        
        /* 마지막 페이지(endPage)값이 전체 마지막 페이지보다 작은 경우 true (예시: 페이지 표시 1~10 에서 다음(11~20) 페이지가 존재할 경우 true) */
        this.next = this.endPage < realEnd;
    }

	public int getStartPage() {
		return startPage;
	}

	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}

	public int getEndPage() {
		return endPage;
	}

	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}

	public boolean isPrev() {
		return prev;
	}

	public void setPrev(boolean prev) {
		this.prev = prev;
	}

	public boolean isNext() {
		return next;
	}

	public void setNext(boolean next) {
		this.next = next;
	}

	public int getTotal() {
		return total;
	}

	public void setTotal(int total) {
		this.total = total;
	}

	public Criteria2 getCri() {
		return cri;
	}

	public void setCri(Criteria2 cri) {
		this.cri = cri;
	}

	@Override
	public String toString() {
		return "PageMakerDTO [startPage=" + startPage + ", endPage=" + endPage + ", prev=" + prev + ", next=" + next
				+ ", total=" + total + ", cri=" + cri + "]";
	}
}
