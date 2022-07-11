--회원 테이블
CREATE TABLE BOOK_MEMBER(
  memberId VARCHAR2(50),                --회원 id
  memberPw VARCHAR2(100) NOT NULL,      --회원 비밀번호
  memberName VARCHAR2(30) NOT NULL,     --회원 이름
  memberMail VARCHAR2(100) NOT NULL,    --회원 이메일
  memberAddr1 VARCHAR2(100) NOT NULL,   --회원 우편번호
  memberAddr2 VARCHAR2(100) NOT NULL,   --회원 주소
  memberAddr3 VARCHAR2(100) NOT NULL,   --회원 상세주소
  adminCk NUMBER NOT NULL,              --관리자 구분(0:일반사용자, 1:관리자)
  regDate DATE NOT NULL,                --등록일자
  money number NOT NULL,                --회원 돈
  point number NOT NULL,                --회원 포인트
  PRIMARY KEY(memberId)
);

--회원가입 쿼리
insert into book_member values('admin23', 'admin', 'admin', 'admin', 'admin', 'admin', 'admin', 1, sysdate, 1000000, 1000000);

--로그인에 사용할 쿼리문 (제출받은 로그인, 비밀번호 데이터와 비교하여 일치하는 데이터가 있을 시 해당 아이디의 정보를 반환)
SELECT MEMBERID, MEMBERNAME, ADMINCK, MONEY, POINT FROM book_member where MEMBERID = 'test' AND MEMBERPW = 'test';