-- ------------------------------------------------------------------
-- web 계정
-- ------------------------------------------------------------------

-- #테이블 만들기
create table book(
	book_id int, 
    title varchar(50), 
    author varchar(20), 
    pub_date datetime
);


-- #테이블에 컬럼 추가
alter table book add pub varchar(50);

-- #테이블의 컬럼 값 수정
alter table book modify title varchar(100);   -- varchar(50) --> varchar(100)

-- #테이블의 컬럼 이름 수정
alter table book rename column title to subject;

-- #테이블의 컬럼 삭제
alter table book drop author;

-- #테이블 이름 수정
rename table book to article;

-- #테이블 삭제
drop table article;

select *
from article
;

create table book(
	book_id 	int 			primary key,
    title		varchar(50)		not null,
    pub_date	datetime,
    price 		int				not null
);

alter table book modify title varchar(100);

alter table book rename column title to subject;

alter table book rename column subject to title;

alter table book add pubs varchar(50);

alter table book drop pubs;

-- 다양한 insert문으로 데이터 넣어보기
insert into book()
values(1, '토지', '2005-11-03', 9800);

alter table book modify pub_date date;

insert into book(book_id, title, price)               -- 컬럼 순서 맞추고 안쓴 컬럼은 알아서 null 처리
values(2, '해리포터와 마법사의 돌', 15000);

insert into book(price, book_id, pub_date, title)     -- 순서 안 맞추고 작성(컬럼 o)
values(13800, 3, '2012-03-28', '나미야 잡화점의 기적');    -- 오류 x

insert into book                                      -- 순서 안 맞추고 작성(컬럼 x)
values('데미안', 9800, '헤르만 헤세', '2000-02-10');		  -- 오류

insert into book
values('4', '이기적 유전자', '2006-08-25', 18000);

alter table book add pubs varchar(50);

update book
set pubs = '커뮤니케이션북스'
where book_id = 1
;

update book
set pubs = '문학수첩'
where book_id = 2
;

update book
set pubs = '현대문학'
where book_id = 3
;

update book
set pubs = '을유문화사'
where book_id = 4
;

update book
set pub_date = '2000-11-15'
where book_id = 2
;

drop table book;

select *
from book
;






-- #작가 테이블 만들기
create table author(
	author_id		int				primary key,
    author_name		varchar(100)	not null,	
    author_desc		varchar(500)	
);

-- #책 테이블 만들기
create table book(
	book_id 		int				primary key,
    title			varchar(100)	not null,
    pubs			varchar(100),
    pub_date		datetime
);

-- #작가 데이터 insert
-- insert 문
insert into author
values(1, '박경리', '토지작가');

insert into author      -- 데이터 갯수를 맞춰야 함
values(2, '이문열', '');  -- 작가 설명에 '' 데이터를 입력한것임

insert into author       -- 오류
values(2, '이문열', '');   -- 컬럼수와 데이터 수가 맞지 않음

insert into author       -- 데이터 갯수를 맞춰줘야 함
values(6, '박명수', null); -- 작가 설명에 null --> 실제 데이터가 없는 값

insert into author 
values(3, '황일영', '강사');

-- 컬럼 명을 표시하면 데이터가 컬럼명과 일치해야 한다
insert into author(author_id, author_name)   -- 정상
values(4, '정우성');

insert into author(author_id, author_desc)    -- 오류 --> author_name에 not null을 넣어놔서 데이터가 들어갈 수 없다.
values(5, '런닝맨');							  -- author_name 데이터가 꼭 있어야 한다

insert into author(author_name, author_desc)  -- 오류 author_id --> pk (unique + not null)
values('유재석', '런닝맨');						  -- author_id 데이터가 꼭 있어야 한다 (유니크해야한다)

insert into author(author_desc, author_name, author_id)   -- 나열한 컬럼명의 순서대로
values('제주도', '이효리', 5);								  -- 데이터를 나열해야 한다


select *
from author
;
