/* 작가 등록 시 해당 작가의 모든 데이터가 담기는 객체 */

package com.market.model;

import java.util.Date;

/* 도메인 모델 계층 => AuthorVO 작성 - 작가 관련 데이터 운반 역할 */
public class AuthorVO {

	/* 작가 아이디 */
    private int authorId;
    
    /* 작가 이름 */
    private String authorName;
    
    /* 국가 id */
    private String nationId;
    
    /* 작가 국가 */
    private String nationName;
    
    /* 작가 소개 */
    private String authorIntro;
    
    /*등록 날짜*/
    private Date regDate;
    
    /* 수정 날짜 */
    private Date updateDate;

	public int getAuthorId() {
		return authorId;
	}

	public void setAuthorId(int authorId) {
		this.authorId = authorId;
	}

	public String getAuthorName() {
		return authorName;
	}

	public void setAuthorName(String authorName) {
		this.authorName = authorName;
	}

	public String getNationId() {
		return nationId;
	}

	public void setNationId(String nationId) {
		this.nationId = nationId;
		/* 작가 목록(관리) 쿼리 반환 결과 데이터에는 AuthorVO에 정의되어 있는 '소속 국가 이름(nationName)'은 반환되지 않습니다
		 * 작가 테이블(book_Author)에는 국가 코드(nationId)의 01, 02 숫자만 저장되고, 해당 컬럼은 국가 테이블(book_nation)을 참조합니다 
		 * 국내, 해외 형식으로 반환받도록 쿼리문을 작성할 수 있지만 국가 테이블(book_nation)에서 데이터를 가져와야 하기 때문에 자원을 좀 더 많이 소모하게 됩니다
		 * 이러한 소모를 줄이기 위해서 쿼리 문의 반환받은 결과 데이터 중 nationId를 전달받을 때 nationName의 값이 초기화될 수 있도록 할 것입니다
		 * 더불어 처리해야 할 데이터가 '01(국내)', '02(국외)' 밖에 없기 때문에 Java단계에서 처리해주도록 하였습니다 */
		if(nationId.equals("01")) {
            this.nationName = "국내";
        } else {
            this.nationName = "국외";
        }
	}

	public String getNationName() {
		return nationName;
	}

	public void setNationName(String nationName) {
		this.nationName = nationName;
	}

	public String getAuthorIntro() {
		return authorIntro;
	}

	public void setAuthorIntro(String authorIntro) {
		this.authorIntro = authorIntro;
	}

	public Date getRegDate() {
		return regDate;
	}

	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}

	public Date getUpdateDate() {
		return updateDate;
	}

	public void setUpdateDate(Date updateDate) {
		this.updateDate = updateDate;
	}

	@Override
	public String toString() {
		return "AuthorVO [authorId=" + authorId + ", authorName=" + authorName + ", nationId=" + nationId
				+ ", nationName=" + nationName + ", authorIntro=" + authorIntro + ", regDate=" + regDate
				+ ", updateDate=" + updateDate + "]";
	}
	
    
}
