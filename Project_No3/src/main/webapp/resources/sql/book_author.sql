-- 국가 테이블 생성 (작가 테이블의 소속 국가 컬럼 참조용)
create table book_nation(
    nationId varchar2(2) primary key,
    nationName varchar2(50)
);
 
-- 국가 테이블 데이터 삽입 (작가 테이블의 소속 국가 컬럼 참조용)
insert into book_nation values ('01', '국내');
insert into book_nation values ('02', '국외');
COMMIT;
 
-- 기본키 작가 번호를 위한 시퀀스
CREATE SEQUENCE seq_bookauthor_num
    NOCACHE;
 
-- 작가 테이블 생성
create table book_author(
    authorId number primary key,
    authorName varchar2(50),
    nationId varchar2(2),
    authorIntro long,
    foreign key (nationId) references book_nation(nationId)
);

-- 추가한 날짜와 수정한 날짜를 자동으로 기록하기 위해 작가 테이블에 regDate, updateDate 두 개의 컬럼(Column)을 추가 (기본 값으로 시스템 날짜 적용)
alter table book_author add regDate date default sysdate;
alter table book_author add updateDate date default sysdate;

-- 작가 테이블 더미 데이터
insert into book_author(authorId, authorName, nationId, authorIntro) values(seq_bookauthor_num.nextval, '유홍준', '01', '작가 소개입니다' );
insert into book_author(authorId, authorName, nationId, authorIntro) values(seq_bookauthor_num.nextval, '김난도', '01', '작가 소개입니다' );
insert into book_author(authorId, authorName, nationId, authorIntro) values(seq_bookauthor_num.nextval, '폴크루그먼', '02', '작가 소개입니다' );
commit;

--페이징용 더미 데이터 삽입 2 (재귀 복사 방식 - 해당 테이블의 데이터를 그대로 다시 삽입)
insert into book_author(authorId, authorName, nationId)(select seq_bookauthor_num.nextval, authorName, nationId from book_author);
commit;