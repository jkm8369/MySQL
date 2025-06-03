-- ------------------------------------------------------------------
-- web 계정 02
-- ------------------------------------------------------------------

-- 계정 삭제
drop table author;
drop table book;

-- 작가 테이블 생성
create table author(
	author_id		int				primary key		auto_increment,
    author_name 	varchar(100)	not null,
    author_desc		varchar(500)
);

select *
from author
;

insert into author 
values(null, '박경리', '토지 작가');

insert into author 
values(null, '이문열', null);

insert into author(author_desc, author_name)
values('런닝맨', '유재석');

-- ----------------------------------------------------
-- #데이터 삭제
-- where절에 pk 컬럼 조건식을 사용해 삭제
delete from author
where author_id = 3
;

-- pk 컬럼 이외의 컬럼은 기본적으로 삭제되지 않는다(옵션으로 조정할 수 있다)
delete from author
where author_name = '이문열'
;

delete from author;  -- 테이블 데이터 전체 삭제 의미 (막혀있음)

truncate table author; -- 테이블 데이터 전체 삭제

-- ----------------------------------------------------                                                    
-- #데이터 수정
-- update author 

-- where절을 꼭 써야한다 (pk로 조건절 작성)
update author
set author_name = '기안84',
	author_desc = '웹툰작가'
where author_id = 1
;

update author
set author_name = '서장훈',
	author_desc = '농구선수'
where author_id >= 1
;

