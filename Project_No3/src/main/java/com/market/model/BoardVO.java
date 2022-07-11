package com.market.model;

import java.util.Date;

/*게시판의 데이터가 담긴 DB에서 1개의 튜플(행) 데이터를 정의하는 객체*/
//@Component
public class BoardVO {
	/*
	create table book_board(
	    bno number,
	    title varchar2(150) not null,
	    content varchar2(2000) not null,
	    writer varchar2(50) not null,
	    regdate date default sysdate,
	    updatedate date default sysdate,
	    constraint pk_board PRIMARY key(bno)
	);
	*/
	
	/* 게시글 번호 */
    private int bno;
    
    /* 게시글 제목 */
    private String title;
    
    /* 게시글 내용 */
    private String content;
    
    /* 게시글 작가 */
    private String writer;
    
    /* 등록 날짜 */
//    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date regdate;
    
    /* 수정 날짜 */
//    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date updateDate;

	public int getBno() {
		return bno;
	}

	public void setBno(int bno) {
		this.bno = bno;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getWriter() {
		return writer;
	}

	public void setWriter(String writer) {
		this.writer = writer;
	}

	public Date getRegdate() {
		return regdate;
	}

	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}

	public Date getUpdateDate() {
		return updateDate;
	}

	public void setUpdateDate(Date updateDate) {
		this.updateDate = updateDate;
	}

	@Override
	public String toString() {
		return "BoardVO [bno=" + bno + ", title=" + title + ", content=" + content + ", writer=" + writer + ", regdate="
				+ regdate + ", updateDate=" + updateDate + "]";
	}
    
    
}
