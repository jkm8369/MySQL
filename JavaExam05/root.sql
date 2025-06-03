-- book에 권한 주기

-- 계정 만들기
create user 'book'@'%' identified by 'book';

-- 계정 조회
use mysql;

select user,
	   host
from user
;

-- ------------------------------------------------------------------
-- 조강민
-- ------------------------------------------------------------------

-- 데이터베이스 만들기
create database book_db
	default character set utf8mb4
    collate utf8mb4_general_ci
    default encryption='n'
;

-- 데이터베이스 조회
show databases;

-- 데이터베이스 선택
use book_db;

-- 권한부여
grant all privileges on book_db.* to 'book'@'%';