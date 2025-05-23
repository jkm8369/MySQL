/******************************************************************************
select문 (조회)
******************************************************************************/

-- ------------------------------------------------------------
-- where절
-- ------------------------------------------------------------

-- 부서 아이디가 30인 사원의 이름과 부서 번호를 구하시오
select first_name,
	   department_id
from employees
where department_id = 30;     --   =, >, <, >=, <=, !=, <>

-- 월급이 15000 이상인 사원들의 이름과 월급을 출력하세요
select concat(first_name, ' ' ,last_name) 이름,
       salary 월급
from employees
where salary >= 15000
;

-- 07/01/01 일 이후에 입사한 사원들의 이름과 입사일을 출력하세요 (날짜비교)
-- 07/01/01 일 이후 --> 07/01/01, 07/01/02, 07/01/03  ....... 09/12/01 .....
select concat(first_name, ' ' ,last_name) 이름,
       hire_date 입사일
from employees
where hire_date >='07/01/01'
;

/*
-- 특정 기준일을 0으로 해서 숫자로 관리한다
1700-01-01 00:00:00     0   --> 1700/01/01 00:00:00
1700-01-01 00:00:00     1
1700-01-01 00:00:00     2
1700-01-01 00:10:00     60

2025-05-23 00:00:00     23123
*/

-- 이름이 Lex인 직원의 이름과 월급을 출력하세요  
select first_name 이름,
       salary 월급
from employees
where first_name = 'Lex'
;

-- 비교
select first_name 이름,
       salary 월급
from employees
where first_name = 'lEx'
;  -- 대소문자 구별하지 않는다

-- 비교
-- 문자열 대소문자를 구별하지 않는다.  구별하려면 binary 사용
select first_name 이름,
       salary 월급
from employees
where binary first_name = 'Lex'
;  -- 대소문자를 구별한다

-- *조건이 2개 이상 일 때 한꺼번에 조회하기
-- 월급이 14000이상 17000이하인 사원의 이름과 월급을 구하시오
-- salary >= 14000 월급이 14000이상
-- salary <= 17000 월급이 17000이하
-- 두 조건이 모두 만족해야 된다 && --> and , (|| --> or)
select first_name,
       salary
from employees
where salary >=14000
and salary <=17000
;

-- 월급이 14000 이하이거나 17000 이상인 사원의 이름과 월급을 출력하세요
select first_name 이름,
       salary 월급
from employees
where salary <= 14000
or salary >=17000
;

-- 입사일이 04/01/01 에서 05/12/31 사이의 사원의 이름과 입사일을 출력하세요
select first_name 이름,
       hire_date 입사일
from employees
where hire_date >= '04/01/01'
and hire_date <= '05/12/31'
; 

-- 월급이 14000 이상 17000 이하인 사원의 이름과 월급을 구하시오
select first_name 이름,
	   salary 월급
from employees
where salary >= 14000 and salary <=17000;


select first_name 이름,
	   salary 월급
from employees
where salary between 14000 and 17000
;

-- IN 연산자로 여러 조건을 검사하기
-- Neena, Lex, John 의 이름, 성, 월급을 구하시오

select first_name
from employees
where first_name = 'Neena'
or first_name = 'Lex'
or first_name = 'John'
;

select first_name 이름,
	   last_name 성,
       salary 급여
from employees
where first_name in('Neena', 'Lex', 'John')
;

-- 월급이 2100, 3100, 4100, 5100 인 사원의 이름과 월급을 구하시오
select first_name 이름,
	   salary 월급
from employees
where salary in(2100, 3100, 4100, 5100)
;

-- *Like 연산자로 비슷한 것들 모두 찾기
select *
from employees
where binary first_name like 'L___'
;

-- 이름에 am 을 포함한 사원의 이름과 월급을 출력하세요
select first_name 이름,
	   salary 월급
from employees
where first_name like '%am%'
;

-- 이름의 두번째 글자가 a 인 사원의 이름과 월급을 출력하세요
select first_name 이름,
	   salary 월급
from employees
where first_name like '_a%'
;

-- 이름의 네번째 글자가 a 인 사원의 이름을 출력하세요
select first_name 이름
from employees
where first_name like '___a%'
;

-- 이름이 4글자인 사원중 끝에서 두번째 글자가 a인 사원의 이름을 출력하세요
select first_name 이름
from employees
where first_name like '__a_'
;

-- 부서가 없는 사람의 이름과 부서번호를 출력하세요
-- is null
select first_name 이름,
       department_id 부서번호
from employees
where department_id is null
;

-- 부서가 있는 사람의 이름과 부서번호를 출력하세요
-- is not null
select first_name 이름,
	   department_id 부서번호
from employees
where department_id is not null
;

select first_name 이름,
	   salary 급여,
       commission_pct,
       salary*commission_pct,
       salary*commission_pct+200
from employees
;

-- 커미션비율이 있는 사원의 이름과 월급 커미션비율을 출력하세요
select first_name 이름,
	   salary*commission_pct '월급 커미션비율'
from employees
where commission_pct is not null
;

-- 담당매니저가 없고 커미션비율이 없는 직원의 이름과 매니저아이디 커미션 비율을 출력하세요
select first_name 이름,
	   manager_id*commission_pct '매니저아이디 커미션 비율'
from employees
where manager_id is null 
and commission_pct is null
;


-- 부서가 없는 직원의 이름과 월급을 출력하세요
select first_name 이름,
	   salary 월급
from employees
where department_id is null
;

-- 월급이 6000 이상 10000 이하인 직원 중 커미션 비율이 없는 직원의
-- 이름 월급 커미션 비율을 출력하세요
select first_name 이름,
	   salary 월급,
       commission_pct '커미션 비율'
from employees
where salary between 6000 and 10000
and commission_pct is null
;


-- ------------------------------------------------------------
-- order by 절 (정렬)
-- ------------------------------------------------------------

-- 직원의 이름과 월급을 월급이 많은 직원부터 출력하세요 (큰-->작 : 내림차순)
-- 오름차순: asc    내림차순: desc
select first_name 이름,
	   salary 월급
from employees
-- where salary >=10000
order by salary  desc
;

-- 월급이 9000이상인 직원의 이름과 월급을 월급이 많은 직원부터 출력하세요
select first_name 이름,
	   salary 월급
from employees
where salary >=9000
order by salary desc
;

-- 부서번호를 오름차순으로 정렬하고 부서번호, 월급, 이름을 출력하세요
select department_id 부서번호,
	   salary 월급,
       first_name 이름
from employees
order by department_id asc
;

-- 월급이 10000 이상인 직원의 이름 월급을 월급이 큰직원부터 출력하세요
select first_name 이름,
	   salary 월급
from employees
where salary >=10000
order by salary desc
;

-- 부서번호를 오름차순으로 정렬하고 부서번호가 같으면 월급이 높은 사람부터 부서번호 월급 이름을 출력하세요
select department_id 부서번호,
	   salary 월급,
       first_name 이름
from employees
order by department_id asc, salary desc, first_name asc
;

-- 직원의 이름, 급여, 입사일을 이름의 알파벳 올림차순으로 출력하세요
select first_name 이름,
	   salary 급여,
	   hire_date 입사일
from employees
order by first_name asc
;

-- 직원의 이름, 급여, 입사일을 입사일이 빠른 사람 부터 출력하세요
select first_name 이름,
	   salary 급여,
       hire_date 입사일
from employees
order by hire_date asc
;




