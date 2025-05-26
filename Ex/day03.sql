-- 복습
-- 월급이 100000 이상인 직원의 이름 월급을 월급이 큰 직원부터 출력하세요
-- select 문의 기본구조 (4개의 절)
-- 작동 순서를 잘 알아야 한다.
-- 정상 작동
select first_name fname,
	   salary s
from employees
where salary >= 10000
order by s desc
;

-- where절 X, order by절 O --> 작동 순서를 잘 알아야한다
select first_name fname,
	   salary s
from employees
where s >= 10000
order by s desc
;

/*******************************************************
* 단일행 함수
*******************************************************/
-- 단일행 함수 --> 숫자 함수

-- round() : 반올림
select round(123.123, 2),       -- 123.123을 소수점 둘째 자리에서 반올림 표현
	   round(123.126, 2),		-- 소수점 셋째 자리에서 반올림
       round(234.567, 0),		-- 235
       round(123.456, 0), 		-- 123
       round(123.126, -1),      -- 120
       round(125.126, -1),		-- 130
       round(125.126, -2)		-- 100
from dual
;

-- ceil() : 올림    0번째 자리까지 표현 (소수점 첫번째 자리에서 반올림)
select ceil(123.456),   -- 124
	   ceil(123.789), 	-- 124
       ceil(123.7892313), -- 124
       ceil(987.1234)   -- 988
from dual
;

-- floor() : 내림   (소수점 다 버려버림)
select floor(123.456),      -- 123
	   floor(123.789),      -- 123 
       floor(123.7892313),  -- 123
       floor(987.1234)      -- 987
from dual
;

-- truncate() : 자리수 버림  --> 뒤에는 다 0됨      truncate: 길이를 줄이다
select truncate(1234.34567, 2),  -- 1234.34  둘째 자리 아래로 다 버림
       truncate(1234.34567, 3)   -- 1234.345
       truncate(1234.34567, 0),  -- 1234
       truncate(1234.34567, -2)  -- 1200
from dual
;

-- power(숫자, n), pow(숫자, n): 숫자의 n승
select power(12, 2),  -- 144
	   pow(12, 2)   -- 144
from dual
;

-- sqrt(숫자): 숫자의 제곱근 (루트)
select sqrt(144)  -- 12
from dual
;

-- sign(숫자): 숫자가 음수이면 -1, 0이면 0, 양수이면 1
select sign(123),
	   sign(0),
       sign(-123) 
from dual
;

-- abs(숫자): 절대값
select abs(123),  -- 123
	   abs(0),    -- 0
       abs(-123)  -- 123
from dual
;

-- greatest(x, y, z .....): 괄호안의 값 중 가장 큰 값
select greatest(2, 0, -2),             -- 2
	   greatest(4, 3.2, 5.25),         -- 5.25
       greatest('B', 'A', 'C', 'c'),   -- c 
       greatest('ㄱ', 'ㅎ', 'ㅏ', 'ㅣ')  -- ㅣ
from dual
;

-- least(x, y, z .....): 괄호안의 값 중 가장 작은 값
select	least(2, 0, -2),			-- -2
		least(4, 3.2, 5.25),		-- 3.2
        least('B', 'A', 'C', 'c')	-- A
from dual
;

-- 단일행 함수 --> 문자 함수
select concat('안녕', '하세요') 
from dual
;

select concat('안녕', '-', '하세요')
from dual
;

select concat(first_name, ' ' ,last_name)
from employees
;

-- concat_ws(s, str1, str2, ..., strn): str1, str2, ..., strn을 연결할때 사이에 s 로 연결    *with seperator
select	concat_ws('-', 'abc', '가나다', '123'),
		concat_ws('-', first_name, last_name, truncate(salary, 0))
from employees
;

-- lcase(str) 또는 lower(str): str의 모든 대문자를 소문자로 변환
select	first_name,
		lower(first_name),
        lcase(first_name),
        lower('ABCabc!#$%'),
        lower('가나다')
from employees;

-- ucase(str) 또는 upper(str): str의 모든 대문자를 소문자로 변환
select	first_name,
		upper(first_name),
        ucase(first_name),
        upper('ABCabc!#$%'),
        upper('가나다')
from employees;

-- 문자 갯수
-- length(str): str의 길이를 바이트로 반환
-- char_length(str) 또는 character_length(str): str의 문자열 길이를 반환
select first_name,
	   length(first_name),       -- 바이트 수
       char_length(first_name) '글자 수',    -- 글자 수
       character_length(first_name)		   -- 글자 수
from employees
;

select length('a'),      -- 1
	   char_length('a'),
       character_length('a')  
from dual
;

select length('가'),
	   char_length('가'),
       character_length('가')
from dual
;

-- substring(str, pos, len) 또는 substr(str, pos, len) :
-- str의 pos 위치에서 시작하여 len의 길이의 문자열 반환
select first_name,
	   substring(first_name, 1, 3),     -- 1번째, 3글자
       substring(first_name, 2, 3),      -- 2번째, 3글자
       substr(first_name, -3, 3)        --  끝에서 3번쨰, 3글자 (오른쪽 방향)
from employees
;

select substr('901112-2234567', 8, 1),   -- 성별
	   substr('901112-1234567', -7, 1),   -- 성별
       substr('94166056', 1, 2)          -- 입학년도
from dual
;

-- lpad or rpad(str, len, padstr): str 문자열 왼쪽 or 오른쪽에 padstr 문자열을 추가하여, 전체 문자열의 길이가 leg이 되도록 만듦
select first_name,
	   lpad(first_name, 10, '*'),
       rpad(first_name, 10, '*'),
       first_name
from employees
;

-- trim(str)  --> 문자의 중간의 공백은 적용되지 않는다.
select concat('|', '          안녕하세요          ', '|'),
	   concat('|', trim('          안녕하세요          '), '|'),
       concat('|', ltrim('          안녕하 세요          '), '|'),
       concat('|', rtrim('          안녕하세요          '), '|'),
       concat('|', '          안녕하세요          ', '|'),
       trim(concat('|', '          안녕하세요          ', '|'))
from employees
; 

-- replace(str, from_str, to_str): str에서 from_str을 to_str로 변경
select first_name,
	   replace(first_name, 'a', '&*&')
from employees
;

select first_name,
	   substr(first_name, 2, 3),
       replace(first_name, substr(first_name, 2, 3), '***')   -- 이벤트 당첨자
from employees
;

-- 단일행 함수 --> 날짜 함수
select curdate(),
	   current_date()
from dual
;

select curtime(),
	   current_time()
from dual
;

select current_timestamp(),
	   now()
from dual
;

-- 날짜 + 시간
select current_timestamp(),     
	   now()
from dual;

-- 날짜, 시간 더하기 빼기
select '2021-06-20 00:00:00' 오늘,
	    adddate(date_format('2021-06-20 00:00:00', '%Y-%m-%d %H:%i:%s'), interval 1 year) '1년 후',
        adddate('2021-06-20 00:00:00', interval 1 month) '1달 후',
        adddate('2021-06-20 00:00:00', interval 1 week) '1주일 후',
        adddate('2021-06-20 00:00:00', interval -1 day) '1일 전',
        adddate('2021-06-20 00:00:00', interval 1 hour) '1시간 후',
        adddate('2021-06-20 00:00:00', interval 1 minute) '1분 후',
        adddate('2021-06-20 00:00:00', interval 1 second) '1초 후'
from dual
;

select '2021-06-20 00:00:00' 오늘,
	    subdate('2021-06-20 00:00:00', interval 1 year) '1년 전',
        subdate('2021-06-20 00:00:00', interval 1 month) '1달 전',
        subdate('2021-06-20 00:00:00', interval 1 week) '1주일 전',
        subdate('2021-06-20 00:00:00', interval 1 day) '1일 전',   -- -1 day 하면 더해짐
        subdate('2021-06-20 00:00:00', interval 1 hour) '1시간 전',
        subdate('2021-06-20 00:00:00', interval 1 minute) '1분 전',
        subdate('2021-06-20 00:00:00', interval 1 second) '1초 전'
from dual
;

-- datediff(): 두 날짜 간 일수 차이
select datediff('2021-06-21', '2021-06-20'),     -- 일                -- ('2021-06-21 01:05:05', '2021-06-21 01:00:00')  --> 0
	   timediff('2021-06-21 01:05:05', '2021-06-20 01:00:00')  -- 초
from dual
;


select first_name,
	   ceil(datediff(now(), hire_date)/365),
	   concat(round(datediff(now(), hire_date)/365, 0), '년차')
from employees
;

-- --------------------------------------
-- 단일행 함수 --> 변환 함수
select now(),
	   date_format(now(), '%y-%m-%d %h:%i:%s'),
       date_format(now(), '%Y-%M-%d %H:%i:%s (%p)'),
       date_format(now(), '%y-%m-%d %h:%i:%s'),
       date_format(now(), '%Y-%m-%d %H:%i:%s')
from dual
;

select first_name,
	   date_format(hire_date, '%d.%m.%Y')
from employees
;

-- 원래 문자열 --> 날짜형(자동으로 변환)
select datediff('2025-09-05', '2025-03-27')
from dual   -- 수업기간 며칠 남았나
;

-- 문자열 --> 날짜형으로 변환 --> 계산
select str_to_date('2021-Jun-22', '%Y-%b-%d'),
	   str_to_date('2021-06-21', '%Y-%m-%d'),
       datediff(str_to_date('2021-Jun-22', '%Y-%b-%d'), str_to_date('2021-06-21', '%Y-%m-%d'))
from dual
;

-- 숫자 --> 문자열
-- format(숫자, p): 숫자에 콤마(,)를 추가, 소수점 p자리까지 출력
select format(1234567, 0),
	   format(1234567.89128, 4),  -- > 소수점 자리수 반올림
       format(1234567.89128, -5)   -- > 소수점 자리수 반올림, 마이너스(-)는 안먹는다
from dual
;

-- ifnull(컬럼명, null일떄의 값): 컬럼의 값이 null일 때 정해진 값을 출력
select first_name,
	   commission_pct,
	   ifnull(commission_pct, '없음')
from employees;

select first_name,
	   manager_id,
       ifnull(manager_id, '매니저 없음')
from employees;

select 메소드(first_name),
	   salary
from employees
where salary >= 10000
order by salary desc
;

