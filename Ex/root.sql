-- ------------------------------------------------------------------
-- root 계정
-- ------------------------------------------------------------------

-- #계정 만들기

-- 모든 곳에서 접속 가능
-- create user 'web'@'%' identified by '1234';

-- localhost에서만 접속 가능
-- create user 'web'@'localhost' identified by '1234';

-- 192.186.0.122 에서만 접속 가능
-- create user 'web'@'192.186.0.122' identified by '1234';


-- 비밀번호 변경
-- alter user 'web'@'%' identified by 'web';

/*
mysql -u web -p
--> 'web'@'192.186.0.122'로 로그인 되는거임
--> 우선순위 'web'@'192.186.0.122' > 'web'@'localhost' > 'web'@'%'
*/

-- #계정 삭제
drop user 'web'@'192.186.0.122';
drop user 'web'@'localhost';
drop user 'web'@'%';

create user 'web'@'%' identified by '1234';
alter user 'web'@'%' identified by 'web';

-- #계정 조회
use mysql;

select user,
	   host
from user
;

-- ---------------------------------------------------------
-- #데이터베이스 (스키마) 만들기
-- ---------------------------------------------------------
create database web_db
    default character set utf8mb4
    collate utf8mb4_general_ci
    default encryption='n'
;

-- #데이터베이스 (스키마) 삭제
drop database web_db;

-- #데이터베이스 조회
show databases;

-- #데이터베이스 선택
use web_db;


-- -------------------------------------
-- #권한부여
-- 'web'@'%' 계정이 web_db (데이터베이스)의 모든 테이블에 모든 권한 부여
grant all privileges on web_db.* to 'web'@'%';
flush privileges;








