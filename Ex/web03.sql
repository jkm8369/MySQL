-- ------------------------------------------------------------------
-- web 계정 03 fk
-- ------------------------------------------------------------------
drop table author;
drop table book;

show tables;

create table author(
	author_id		int				primary key		auto_increment,
    author_name		varchar(100)	not null,
    author_desc 	varchar(500)
);

insert into author 
values(null, '김문열', '경북 영양');

insert into author 
values(null, '박경리', '경삼남도 통영');

insert into author 
values(null, '유시민', '17대 국회의원');

insert into author 
values(null, '기안84', '기안동에서 산 84년생');

insert into author 
values(null, '강풀', '온라인 만화가 1세대');

insert into author 
values(null, '김영하', '알쓸신잡');

select *
from author
;

-- 테이블 만들기  but author 테이블이 없어서 fk가 적용이 안됨
create table book(
	book_id		int				primary key		auto_increment,
    title		varchar(100)	not null,
    pubs 		varchar(100),
    pub_date	date,
    author_id 	int,
    constraint book_fk foreign key(author_id)
    references author(author_id)
);

/*
-- ON DELETE CASCADE: 해당하는 FK를 가진 참조행도 삭제
-- ON DELETE SET NULL: 해당하는 FK를 NULL로 바꿈
*/

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

select *
from book b, author a
where b.author_id = a.author_id
;

-- 전체조회(실전코드)    컬럼명을 모두 명확하게 표기해준다  * 사용하지 않는다
select b.book_id,
	   b.title,
       b.pubs,
       b.pub_date,
       b.author_id,
       a.author_id,
       a.author_name,
       a.author_desc
from book b, author a
where b.author_id = a.author_id
;

-- 경북 영양 --> 서울  수정
update author
set author_desc = '서울'
where author_id = 1
;

-- 우리들의 일그러진 영웅 책 삭제
delete from book
where book_id = 1;

-- 작가 박경리 삭제
delete from author
where author_id = 2
;   -- > 삭제 안됨

-- --------------------------------------
insert into author
values(null, '정우성', '영화배우');

select *
from author
;

-- 삭제 잘됨 작가번호
delete from author
where author_id = 8
;

