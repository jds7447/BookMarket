--장바구니 테이블 기본키인 cartId 컬럼용 시퀀스
CREATE SEQUENCE seq_bookcart_num
    NOCACHE;

--장바구니 테이블
create table book_cart(
    cartId number primary key,
    memberId varchar2(50),
    bookId number,
    bookCount number,
    foreign key (memberId) references book_member(memberId),
    foreign key (bookId) references book_goods(bookId)
);

--서버에서 이미 등록한 상품이 있는 경우 INSERT 쿼리를 나가지 않도록 로직을 짜겠지만 혹시 모르니 DB에서도 유니크 제약조건 걸기
alter table book_cart add unique (memberId, bookId);