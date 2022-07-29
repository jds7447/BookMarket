--주문 테이블
create table book_order(
    orderId varchar2(50) primary key,   --주문 테이블 기본 키 (주문번호라고 볼 수 있음)
    addressee varchar2(50) not null,   --주문자 이름
    memberId varchar2(50),   --주문자 id
    memberAddr1 varchar2(100) not null,   --배송지 주소1
    memberAddr2 varchar2(100) not null,   --배송지 주소2
    memberAddr3 varchar2(100) not null,   --배송지 주소3
    orderState varchar2(30) not null,   --주문 상태 => 배송 준비', '배송 취소'(, '배송 중', '배송 완료) => 준비와 취소만 구현 예정
    deliveryCost number not null,   --배송비
    usePoint number not null,   --주문 시 주문자가 사용한 포인트
    orderDate date default sysdate,   --주문일
    FOREIGN KEY (memberId) REFERENCES book_member (memberId)   --주문자 id는 회원 테이블의 id를 참조한 외래키 적용
);

--주문상품 테이블 기본키인 orderItemId 컬럼용 시퀀스
CREATE SEQUENCE seq_bookOrderItem_num
    NOCACHE;

--하나의 주문은 여러 개의 상품을 가질 수 있고, 하나의 상품은 여러 주문에 속할 수 있기 때문에 주문 테이블과 상품 테이블의 관계는 논리적으로 N : M (다 대 다) 관계이다
--논리적으로 다 대 다 관계가 성립할 수 있지만 물리적으로는 불가능 하기에 이 관계를 해소하는 매핑 테이블을 추가한다
--주문 테이블과 상품 테이블 사이에서 매핑 역할을 하는 '주문상품' 테이블
create table book_orderItem(
    orderItemId number primary key,   --주문상품 테이블 기본 키
    orderId varchar2(50),   --주문 id (주문번호라고 볼 수 있음)
    bookId number,   --상품 id
    bookCount number not null,   --상품 개수
    bookPrice number not null,   --상품 가격
    bookDiscount number not null,   --상품 할인율
    savePoint number not null,   --주문 시 적립되는 포인트
    FOREIGN KEY (orderId) REFERENCES book_order(orderId),   --주문 id 컬럼은 주문 테이블의 주문 id를 참조한 외래키
    FOREIGN KEY (bookId) REFERENCES book_goods(bookId)   --상품 id 컬럼은 상품 테이블의 상품 id를 참조한 외래키
);