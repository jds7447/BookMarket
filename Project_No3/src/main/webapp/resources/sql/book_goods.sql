-- 기본키 상품 번호를 위한 시퀀스
CREATE SEQUENCE seq_bookgoods_num
    NOCACHE;
    
-- 상품 테이블 
create table book_goods(
    bookId number primary key,   --상품 번호
    bookName varchar2(50)   not null,   --상품 이름
    authorId number,   --작가 번호
    publeYear Date not null,   --출판일
    publisher varchar2(70) not null,   --출판사
    cateCode varchar2(30),   --카테고리 코드 (상품 분류 코드)  --> 카테고리 테이블의 기본키를 참조할 예정
    bookPrice number not null,   --상품 가격
    bookStock number not null,   --상품 개수
    bookDiscount number(2,2),   --상품 할인율 (총 2의 길이에서 소수점 둘째 자리까지, 즉 소수점 2자리만 표현)
    bookIntro clob,   --상품 소개
    bookContents clob,   --상품 내용
    regDate date default sysdate,   --등록일
    updateDate date default sysdate   --수정일
);

/*
CLOB 이란
사이즈가 큰 데이터를 외부 파일로 저장하기 위한 데이터 타입 (최대 4GB)
문자열 데이터를 db 외부에 저장하기 위한 타입
CLOB 데이터의 최대 길이는 외부 저장소에 생성 가능한 파일 크기
CLOB 타입은 SQL 문에서 문자열 타입으로 입출력 값을 표현한다
즉, CHAR(n), VARCHAR(n), VARCHAR2(n), NCHAR(n), NCHAR VARYING(n) 타입과 호환된다
단, 명시적 타입 변환만 허용되며, 데이터 길이가 서로 다른 경우에는 최대 길이가 작은 타입에 맞추어 절삭된다
CLOB 타입 값을 문자열로 변환하는 경우, 변환된 데이터는 최대 1GB를 넘을 수 없다
반대로 문자열을 CLOB 타입으로 변환하는 경우, 변환된 데이터는 CLOB 저장소에서 제공하는 최대 파일 크기를 넘을 수 없다
즉, 문자형 대용량 파일 저장하는데 유용하고 가변 길이로 잘라서 저장이 된다
*/

-- 카테고리 테이블 (상품 분류)
create table book_bcate(
    tier number(1) not null,   --분류 등급 (해당 카테고리 번호가 1단계, 2단계, 3단계 중 어떠한 단계인지를 표시)
    cateName varchar2(30) not null,   --분류명
    cateCode varchar2(30) not null,   --분류 코드
    cateParent varchar2(30),   --상위 분류 (현재 행이 어떠한 분류의 하위 분류인지 알 수 있도록)
    primary key(cateCode),   --분류 코드 기본 키
    foreign key(cateParent) references book_bcate(cateCode)   --상위 분류를 동일 테이블의 분류 코드를 참조하는 외래키로 설정하여 해당 컬럼의 값만 들어올 수 있도록
);
/*
카테고리 코드(cateCode) 규칙
책 상품을 3가지 단계로 분류(책 상품에 대한 분류는 '교보문고'를 참고)
1단계 분류는 '국내','국외'의 구분\
2단계는 '소설', '교양', '인문', '과학', '철학'과 같이 큰 범주의 책 분야로 분류
3단계는 2단계의 분류에서 좀 더 세분화된 분야의 범주로 분류
예시>>   00    000   0000
       1단계  2단계   3단계
*/

-- 데이터 삽입
insert into book_bcate(tier, cateName, cateCode) values (1, '국내', '100000');
    insert into book_bcate(tier, cateName, cateCode, cateParent) values (2, '소설', '101000','100000');
        insert into book_bcate(tier, cateName, cateCode, cateParent) values (3, '한국소설', '101001','101000');
        insert into book_bcate(tier, cateName, cateCode, cateParent) values (3, '영미소설', '101002','101000');
        insert into book_bcate(tier, cateName, cateCode, cateParent) values (3, '일본소설', '101003','101000');
    insert into book_bcate(tier, cateName, cateCode, cateParent) values (2, '시/에세이', '102000','100000');
        insert into book_bcate(tier, cateName, cateCode, cateParent) values (3, '한국시', '102001','102000');
        insert into book_bcate(tier, cateName, cateCode, cateParent) values (3, '해외시', '102002','102000');
    insert into book_bcate(tier, cateName, cateCode, cateParent) values (2, '경제/경영', '103000','100000');
        insert into book_bcate(tier, cateName, cateCode, cateParent) values (3, '경영일반', '103001','103000');
        insert into book_bcate(tier, cateName, cateCode, cateParent) values (3, '경영이론', '103002','103000');
        insert into book_bcate(tier, cateName, cateCode, cateParent) values (3, '경제일반', '103003','103000');
        insert into book_bcate(tier, cateName, cateCode, cateParent) values (3, '경제이론', '103004','103000');
    insert into book_bcate(tier, cateName, cateCode, cateParent) values (2, '자기계발', '104000','100000');
        insert into book_bcate(tier, cateName, cateCode, cateParent) values (3, '성공/처세', '104001','104000');
        insert into book_bcate(tier, cateName, cateCode, cateParent) values (3, '자기능력계발', '104002','104000');
        insert into book_bcate(tier, cateName, cateCode, cateParent) values (3, '인간관계', '104003','104000');
    insert into book_bcate(tier, cateName, cateCode, cateParent) values (2, '인문', '105000','100000');
        insert into book_bcate(tier, cateName, cateCode, cateParent) values (3, '심리학', '105001','105000');
        insert into book_bcate(tier, cateName, cateCode, cateParent) values (3, '교육학', '105002','105000');
        insert into book_bcate(tier, cateName, cateCode, cateParent) values (3, '철학', '105003','105000');    
    insert into book_bcate(tier, cateName, cateCode, cateParent) values (2, '역사/문화', '106000','100000');
        insert into book_bcate(tier, cateName, cateCode, cateParent) values (3, '역사일반', '106001','106000');
        insert into book_bcate(tier, cateName, cateCode, cateParent) values (3, '세계사', '106002','106000');
        insert into book_bcate(tier, cateName, cateCode, cateParent) values (3, '한국사', '106003','106000');
    insert into book_bcate(tier, cateName, cateCode, cateParent) values (2, '과학', '107000','100000');
        insert into book_bcate(tier, cateName, cateCode, cateParent) values (3, '과학이론', '107001','107000');
        insert into book_bcate(tier, cateName, cateCode, cateParent) values (3, '수학', '107002','107000');
        insert into book_bcate(tier, cateName, cateCode, cateParent) values (3, '물리학', '107003','107000');
insert into book_bcate(tier, cateName, cateCode) values (1, '국외', '200000');
    insert into book_bcate(tier, cateName, cateCode, cateParent) values (2, '문학', '201000','200000');
        insert into book_bcate(tier, cateName, cateCode, cateParent) values (3, '소설', '201001','201000');
        insert into book_bcate(tier, cateName, cateCode, cateParent) values (3, '시', '201002','201000');
        insert into book_bcate(tier, cateName, cateCode, cateParent) values (3, '희곡', '201003','201000');
    insert into book_bcate(tier, cateName, cateCode, cateParent) values (2, '인문/사회', '202000','200000');
        insert into book_bcate(tier, cateName, cateCode, cateParent) values (3, '교양', '202001','202000');
        insert into book_bcate(tier, cateName, cateCode, cateParent) values (3, '철학', '202002','202000');
    insert into book_bcate(tier, cateName, cateCode, cateParent) values (2, '경제/경영', '203000','200000');
        insert into book_bcate(tier, cateName, cateCode, cateParent) values (3, '경제학', '203001','203000');
        insert into book_bcate(tier, cateName, cateCode, cateParent) values (3, '경영학', '203002','203000');
        insert into book_bcate(tier, cateName, cateCode, cateParent) values (3, '투자', '203003','203000');
    insert into book_bcate(tier, cateName, cateCode, cateParent) values (2, '과학/기술', '204000','200000');
        insert into book_bcate(tier, cateName, cateCode, cateParent) values (3, '교양과학', '204001','204000');
        insert into book_bcate(tier, cateName, cateCode, cateParent) values (3, '물리학', '204002','204000');
        insert into book_bcate(tier, cateName, cateCode, cateParent) values (3, '수학', '204003','204000');
commit;

-- 외래키 추가
/* 기존 테스트 편의를 위해서 '상품 테이블(book_goods)'의 cateCode, authorId에 외래 키를 추가하지 않았습니다
    기능을 완성했기때문에 아래의 명령을 통해서 외래키 설정을 해줍니다
    (아래의 코드를 실행 전 반드시 'book_bcate', 'book_author'에 없는 값을 가진 행은 삭제해주어야 합니다) */
alter table book_goods add foreign key (authorId) references book_author(authorId);
alter table book_goods add foreign key (cateCode) references book_bcate(cateCode);

--더미 데이터용 재귀 복사
insert into book_goods(bookId, bookName, authorId, publeYear, publisher, cateCode, bookPrice, bookStock, bookDiscount,bookIntro, bookContents)
(select seq_bookgoods_num.nextval, bookName, authorId, publeYear, publisher, cateCode, bookPrice, bookStock, bookDiscount,bookIntro, bookContents from book_goods);
commit;

--인덱스 힌트를 활용하기 위해 인덱스명 확인
SELECT * FROM USER_INDEXES WHERE TABLE_NAME = 'book_goods';

--상품 이미지 테이블
create table book_image(
    bookId int ,
    fileName varchar2(100) not null,
    uploadPath varchar2(200) not null,
    uuid varchar2(100)not null ,
    primary key (uuid),
    foreign key (bookId) references book_goods(bookId)   --상품(책) 테이블의 bookId 컬럼을 참조키로 하여 상품 테이블에 존재하는 데이터만 등록
);

--어제 저장된 이미지 파일 중에 DB에 데이터가 없는 이미지 파일을 삭제하는 배치 프로그램 테스트용 데이터
insert into book_image values (293, 'DB파일.png', '2022\07\18', 'test1');
insert into book_image values (293, 'DB파일2.png', '2022\07\18', 'test2');     
commit;