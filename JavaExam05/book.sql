-- ------------------------------------------------------------------
-- 조강민
-- ------------------------------------------------------------------
show databases;

-- author 테이블 생성
create table author(
	author_id		int				primary key		auto_increment,
    author_name		varchar(100)	not null,
    author_desc 	varchar(500)
);

-- author 테이블에 데이터 값 넣기
insert into author
values(null, '김문열', '경북 영양');

insert into author
values(null, '박경리', '경상남도 통영');

insert into author
values(null, '유시민', '17대 국회의원');

insert into author
values(null, '기안84', '기안동에서 산 84년생');

insert into author
values(null, '강풀', '온라인 만화가 1세대');

insert into author
values(null, '김영하', '알쓸신잡 출연');

-- 김문열 이문열로 변경
update author
set author_name = '이문열'
where author_id = 1;

-- author 테이블 확인
select *
from author
;

-- book 테이블 만들기
create table book(
	book_id		int				primary key		auto_increment,
    title		varchar(100)	not null,
    pubs 		varchar(100),
    pub_date	datetime,
    author_id	int,
    constraint book_fk foreign key(author_id)
    references author(author_id)
);

-- book 테이블에 데이터 값 넣기
insert into book
values(null, '우리들의 일그러진 영웅', '다림', '1998-02-22', 1);

insert into book
values(null, '삼국지', '민음사', '2002-03-01', 1);

insert into book
values(null, '토지', '마로니에북스', '2012-08-15', 2);

insert into book
values(null, '유시민의 글쓰기 특강', '생각의 길', '2015-04-01', 3);

insert into book
values(null, '패션왕', '중앙북스(books)', '2012-02-22', 4);

insert into book
values(null, '순정만화', '재미주의', '2011-08-03', 5);

insert into book
values(null, '26년', '재미주의', '2012-02-04', 5);


-- book 테이블 확인
select *
from book
;

-- 4) 아래의 결과처럼 나오는 쿼리문 2개 (where절, inner join 결과는 동일함)
-- where절
select *
from book b, author a
where b.author_id = a.author_id
;

-- inner join
select *
from book b
left outer join author a
		   on b.author_id = a.author_id
;

-- 5) 아래의 결과처럼 나오는 쿼리문
-- 김영하 작가 나옴
select *
from book b
right outer join author a
			on b.author_id = a.author_id
;

-- full outer join
select *
from book b
left outer join author a
		   on b.author_id = a.author_id
union
select *
from book b
right outer join author a
			on b.author_id = a.author_id
;

-- 6)강풀작가의 설명의 데이터 변경 (온라인 만화 1세대 --> 서울특별시)
update author
set author_desc = '서울특별시'
where author_id = 5
;

-- 7) 김영하 데이터 삭제 쿼리문
delete from author
where author_id = 6;

select *
from book b, author a
where b.author_id = a.author_id
;

-- 8)기안84 데이터 삭제 쿼리문
delete from author
where author_id = 4;

-- 9)기안84 데이터가 삭제 되지 않는 이유
/*
book에 fk로 사용하고 있기 때문에 데이터가 깨질(?)수 있기 때문에
*/

-- 10)기안84 삭제할 수 있는 방법
/*
#1. book에 있는 author_id를 먼저 삭제하고
	author에 있는 author_id를 삭제한다.

#2. CONSTRAINT book_fk FOREIGN KEY (author_id)
    REFERENCES author(author_id)
	on delete cascade; 를 해준다.
    
#3. CONSTRAINT book_fk FOREIGN KEY (author_id)
	REFERENCES author(author_id)
	on delete set null;을 해준다
    --> author_id가 null이어야 함
*/

select book_id,
	   title,
       pubs,
       pub_date,
       author_id
from book
;


