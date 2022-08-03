--리뷰 테이블 기본키인 replyId 컬럼용 시퀀스
CREATE SEQUENCE seq_bookreply_num
    NOCACHE;
    
--리뷰 테이블
create table book_reply(
    replyId number /*generated always as IDENTITY*/ primary key,   --댓글 id (오라클 버전 12 이상부터 시퀀스 역할의 generated 사용 가능)
    bookId number not null,   --상품 id
    memberId varchar2(50) not null,   --회원 id
    regDate date default sysdate,   --작성일
    content varchar2(3500),   --댓글 내용
    rating number(2,1) not null,   --상품 평점 (총 2자리, 소수점 1자리까지 허용 - 즉, 0.5, 1.0, 1.5, 2.0, .... 형식)
    FOREIGN KEY (memberId)REFERENCES book_member(memberId),   --회원 id 값은 회원 테이블의 회원 id를 참조한다
    FOREIGN KEY (bookId) REFERENCES book_goods(bookId),   --상품 id 값은 상품 테이블의 상품 id를 참조한다
    UNIQUE(bookId, memberId)   --회원은 상품 1개당 1개의 댓글만 달 수 있도록 중복 불가 제약)
);

drop sequence seq_bookreply_num;
drop table book_reply;

--댓글 리스트 페이징 테스트를 위해 최소 10개 이상의 댓글이 필요로 해서, 의미 없는 댓글 정보를 등록할 수 있도록 제약조건을 생략한 댓글 테이블 등록
--리뷰 테스트 테이블
create table book_reply(
    replyId number /*generated always as IDENTITY*/ primary key,
    bookId number not null,
    memberId varchar2(50) not null,
    regDate date default sysdate,
    content varchar2(3500),
    rating number(2,1) not null
);

--댓글 리스트 페이징용 더미 데이터
insert into book_reply(replyId, bookId, memberId, content, rating)
(select seq_bookreply_num.nextval, bookId, memberId, content, rating from book_reply);
commit;