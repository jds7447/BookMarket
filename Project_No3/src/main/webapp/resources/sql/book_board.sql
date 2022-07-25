--기본키 글 번호를 위한 시퀀스
CREATE SEQUENCE seq_bookboard_num
    NOCACHE;

--게시판 테이블
create table book_board(
    bno number,   --게시글 번호
    title varchar2(150) not null,   --게시글 제목
    content varchar2(2000) not null,   --게시글 내용
    writer varchar2(50) not null,   --게시글 작가
    regdate date default sysdate,   --등록 날짜
    updatedate date default sysdate,   --수정 날짜
    constraint pk_board PRIMARY key(bno)   --게시글 번호 기본키 설정
);

--더미 데이터
insert into book_board(bno, title, content, writer) values (seq_bookboard_num.nextval, '테스트 제목1', '테스트 내용1', '작가1');
insert into book_board(bno, title, content, writer) values (seq_bookboard_num.nextval, '테스트 제목2', '테스트 내용2', '작가2');
insert into book_board(bno, title, content, writer) values (seq_bookboard_num.nextval, '테스트 제목3', '테스트 내용3', '작가3');

commit;

select * from book_board;

--페이징용 더미 데이터 삽입 1 (PL/SQL 방식)
--BEGIN
--    FOR i IN 1..50 LOOP
--        INSERT INTO book_board(bno, title, content, writer) 
--        VALUES(seq_bookboard_num.nextval, CONCAT('PagingTestTitle', i), CONCAT('PagingTestContent', i), CONCAT('PagingTestWriter', i));
--    END LOOP;
--END;

--페이징용 더미 데이터 삽입 2 (재귀 복사 방식 - 해당 테이블의 데이터를 그대로 다시 삽입)
insert into book_board(bno, title, content, writer)(select seq_bookboard_num.nextval, title, content, writer from book_board);
commit;

--페이징 조회 rownum 방식 1
select rn, bno, title, content, writer, regdate, updatedate 
from (select /*+INDEX_DESC(book_board pk_board) */ rownum as rn, bno, title, content, writer, regdate, updatedate
        from book_board)
        -- 서브쿼리 해석 : select rownum as rownum as rn, bno, title, content, writer, regdate, updatedate from book_board order by bno desc
where rn between 11 and 20;
    -- 조건절 해석 : rn > 10 and rn <= 20;

--페이징 조회 rownum 방식 2
select rn, bno, title, content, writer, regdate, updatedate from(
        select /*+INDEX_DESC(book_board pk_board) */ rownum  as rn, bno, title, content, writer, regdate, updatedate 
        from book_board where rownum <= 20) 
where rn > 10;

--rownum 방식 1 & 2 차이점
    --방식 2는 방식 1과 다르게 rownum 필터링에 대한 일부를 서브 쿼리에서 진행한다
    --방식 2는 매우 많은 데이터(수백만 행 단위 등)를 가진 테이블에서 rownum 앞번호를 검색하는 경우 방식 1에 비해 매우 빠른 속도를 보여줍니다.
    --하지만 rownum 뒷번호를 검색한 경우는 속도 차이가 거의 없습니다.
    --rownum 앞번호를 검색하는 경우에는 방식 1의 서브 쿼리에서 반환하는 테이블의 크기와 2의 서브쿼리에서 반환하는 테이블의 크기의 차이 때문에검색 속도가 차이 납니다.
    --rownum 11부터 20까지의 행을 검색하는 쿼리를 예로 들면 'Rownum 방식 1'의 경우 서브 쿼리에서 테이블이 가지고 있는 모든 행을 모두 검색한 테이블을 반환합니다.
    --하지만 'Rownum 방식 2'의 경우 서브 쿼리는 검색조건에 의해 20개의 행만 검색 후 테이블을 반환합니다.
    --정리하면 서브 쿼리의 조건으로 인해 불필요한 검색을 하지 않음으로써 시간을 절약하여 검색 속도를 향상했습니다.
    --rownum 뒷번호를 검색하는 경우에는 방식 1의 서브 쿼리에서 반환하는 테이블의 크기와 방식 2의 서브쿼리에서 반환하는 테이블의 크기가 거의 같기 때문에 검색 속도가 비슷합니다.
    --뒤의 행을 검색할 때는 큰속도차이가 없더라도 앞의 행을 검색할때 앞도적으로 속도가 차이 나기 때문에 방식 2를 사용하는 것이 좋습니다.

--위의 SQL에서 'order by bno desc' 구문을 사용하지 않고 /*+INDEX_DESC(book_board pk_board) */ 라는 인덱스 힌트 구문을 사용하여 최근에 입력된 데이터 순서로 조회를 실행했다
-- /*+INDEX_DESC(book_board pk_board) */ 라는 인덱스 힌트(hint) 사용 이유
    --select * from book_board order by bno desc;
    --보통의 경우 위 SQL 문의 실행 계획은 '인덱스'를 활용하는 실행계획을 세우게 됩니다. 왜냐하면 제일 적은 비용(cost)으로 실행할 수 있는 방법이기 때문입니다.
    --데이터베이스에서 인덱스란 도서 뛰 쪽에 정리되어 있는 '색인'과 같은 역할을 해줍니다.
    --보통 컬럼에 PRIMARY KEY(기본키) 설정을 하게 되면 자동적으로 해당 컬럼(Column)의 '인덱스'가 생성됩니다.
    --위의 힌트를 해석해보면 PK_BOARD '인덱스'를 전체 역(DESC) 순으로 스캔을 합니다.
    --그리고 '인덱스'에는 실제 테이블에 저장되어 있는 각행의 주소인 'ROWID'가 존재하는데, 해당 'ROWID'를 사용해서 실제 테이블(book_board)의 데이터들을 연결해주는 작업이 진행됩니다.
    --매우 많은 데이터가 저장된 경우 인덱스를 활용하지 않은 실행계획이 세워지는 경우도 있는데,
    --테이블 전체를 스캔(FULL) 한 후 이를 다시 정렬(ORDER BY) 하는 순으로 계획되어 있습니다.
    --인덱스를 사용하는 방식과는 다르게 정렬(ORDER BY) 과정에서 상당히 많은 비용(COST)가 발생합니다. 
    --'인덱스'를 사용하지 않는 경우에는 테이블을 전체 스캔한 후 다시 정렬(sort)의 과정을 거치기 때문에 좀 더 많은 비용(cost)으로 실행되고,
    --'인덱스'를 통한 접근의 경우 이미 처음 스캔을 할 때 정렬되어있는 인덱스를 활용하면 되기 때문에 다소 적은 비용(cost)으로 실행됩니다.
    --이렇게 분명히 더 나은 성능의 "실행계획"이 있음에도, 정렬(sort)을 사용하는 다소 낮은 성능의 "실행계획"을 사용할 가능성을 없애기 위해서 힌트(hint)를 사용합니다.
    --인덱스와 관련된 힌트(hint)는 "INDEX_ASC(테이블명 , 인덱스명)", "INDEX_DESC(테이블명 , 인덱스명)"가 있습니다.
    --인덱스를 순서대로 이용할 경우는 "INDEX_ASC(테이블명 , 인덱스명)"를 사용하고, 인덱스를 역손으로 이용하고 싶은 경우는 "INDEX_DESC(테이블명 , 인덱스명)"를 사용하면 됩니다.
    --그리고 해당 인덱스 힌트를 사용할 경우는 "order by "를 사용할 필요가 없습니다. 인덱스 자체가 정렬이 되어있기 때문에 새로이 정렬(SORT)을 해줄 필요는 없습니다. 
    --힌트는 대용량의 데이터를 가진 테이블 또는 복잡한 구조(ex. JOIN)를 가진 테이블을 검색할 때 성능을 향상하기 위해서 주로 사용합니다.
    --지금 현재의 테이블 경우 아주 단순한 구조와 상황이 때문에 사용해도 큰 문제는 없지만, 힌트(hint) 사용에 확신을 할 수 없는 상황에는 되도록이면 사용을 지양하는 것이 좋습니다.
    --어중간한 힌트(hint)로 인해 오히려 검색의 성능이 더 떨어질 수 있기 때문입니다.
--인덱스 힌트를 활용하기 위해 인덱스명 확인
--SELECT * FROM USER_INDEXES WHERE TABLE_NAME = '테이블명';

--게시물 제목 검색 기능 : 페이징 서브 쿼리에 and 연산자를 활용하여 title 컬럼에 대한 조건을 추가하면 제목 검색에 대한 SQL
select bno, title, content, writer, regdate, updatedate from(
        select /*+INDEX_DESC(vam_board pk_board) */ rownum  as rn, bno, title, content, writer, regdate, updatedate
        from vam_board where rownum <= 10 and title like '%검색%')
where rn > 0;

--각 주제별 게시물 검색 : 서브 쿼리의 and title like '%검색%' 구문을 선택된 주제에 따라 아래의 주제 별로 바꿔 끼울 것임
--myBatis의 <trim>, <foreach>, <choose>, <when>, <sql>, <include> 태그 등을 이용
-- 제목
--title like '%검색%'
-- 내용
--content like '%검색%'
-- 작성자
--writer like '%검색%'    
-- 제목 + 내용
--(title like '%검색%' OR content like '%검색%')
-- 내용 + 작성자
--(content like '%검색%' OR writer like '%검색%')
-- 제목 + 내용 + 작성자
--(title like '%검색%' OR content like '%검색%' OR writer like '%검색%')