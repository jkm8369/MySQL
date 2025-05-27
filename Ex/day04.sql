select first_name,
	   upper(first_name),
       rpad(upper(first_name), 10 , '*')
from employees
;

/*************************************************
* 복수행 함수(그룹함수, 집계함수)
*************************************************/
-- 종류: 갯수, 합계, 평균, 최고값, 최저값
-- 사용 가능 (결과 1개 --> 표현 가능)
select avg(salary)
from employees
;

-- 사용 불가능 (결과 107개와 1개를 같이 표현 못함 --> 표현 불가능)
select first_name,
	   avg(salary)
from employees
;

-- 그룹 함수 > count()
-- 직원의 수를 구하시오
select count(*)      -- 전체 갯수(row 갯수)
from employees
;

select count(commission_pct)   -- 커미션을 받은 직원의 수 (null을 뺀 갯수)
from employees
;

select count(manager_id)   -- 매니저(팀장)가 있는 직원의 수 (null을 뺀 갯수)
from employees
;

select count(*),
	   count(commission_pct)
from employees
;

-- 월급이 16000 초과되는 직원의 수는?
select count(*),
	   count(salary),
       count(manager_id)
from employees
where salary > 16000
;

-- 그룹 함수 > sum()
-- 전체직원의 수와 급여의 합
select count(*),
	   floor(sum(salary))
from employees
;

-- 논리적으로 잘못된 합계
select sum(employee_id),
	   sum(first_name)
from employees
;

-- 그룹 함수 > avg()   : null 포함 여부
-- 월급의 평균을 구하시오
select avg(salary),              -- salary가 null이면 평균에 포함 안됨
	   avg(ifnull(salary, 0))    -- salary가 null이면 0으로 평균에 포함됨
from employees
;

-- 그룹 함수 > max(), min() : 정렬 로직을 가지고 있어서 계산량이 많다
select max(salary),   -- 1개
	   min(salary),   -- 1개
       sum(salary)    -- 1개
	-- first_name     --> 107개라 안됨
from employees
;

-- 공부하는 시기에서 검증은 노가다 해라
select *
from employees
order by salary desc
;

select min(hire_date),
	   max(first_name)
from employees
;
-- ---------------------------------------------------------------
-- 부서별로 월급 합계를 구하시오

-- 현재로는 where 절을 이용해서 구한다 --> 한그룹씩만 가능
select sum(salary)
from employees
where department_id = 90
;

-- 한번에 그룹별로 합계를 구한다
-- group by에 참여한 컬럼이나 그룹 함수만 올 수 있다.
select department_id, 
	   sum(salary),
       count(*),
       avg(salary),
       max(salary),
       min(salary)
from employees
group by department_id
order by department_id asc
;

-- 부서 별로 부서 번호와 인원수, 월급 합계를 출력하세요
select department_id 부서번호,
	   count(*) 인원수,
       sum(salary) 월급합계
from employees
group by department_id
order by department_id asc
;

-- 부서별로 부서 번호와, 최고월급, 최고월급을 받는 직원의 이름을 출력하세요
-- group by에 참여한 컬럼이나 그룹 함수만 올 수 있다.  --> ??
select department_id '부서 번호',
	   max(salary) 최고월급
       
from employees
group by department_id
;

-- 그룹을 나누는 첫번째 기준 department_id, 그 안에서 서브(두번째)그룹을 job_id로
select department_id,
	   job_id,
	   sum(salary),
       count(*)
from employees
group by department_id, job_id
;

-- ------------------------------------------------------
select department_id 부서번호,
	   lower(job_id) 직업명,
	-- first_name,           -- 그룹에 참여하지 않은 컬럼명은 사용할 수 없다.
	   sum(salary) 급여,
       concat(count(*), '명') 명수
from employees
group by department_id, job_id
;

-- -------------------------------------------------------
-- 월급(salary)의 합계가 20000 이상이고 부서번호가 100번 이상인
-- 부서의 부서 번호와, 인원 수, 월급 합계를 출력하세요
-- having절 (그룹전용 where절)의 조건이 복잡할 때
select department_id,
	   count(*),
       sum(salary)
from employees
group by department_id
having sum(salary) >= 20000 
and department_id >= 100
order by department_id asc
;

/*************************************************
* if(조건문, 참일 때, 거짓일 때)
*************************************************/
-- 모든 직원의 이름, 월급, 수당, 상태 (state)를 출력하세요
-- 상태 컬럼은 수당이 없으면 0, 수당이 있으면 1을 state 컬럼에 표시하세요
select 이름 월급 수당 상태 0 1
from 직원
;

/*
select first_name,
	   salary,
       commission_pct,
       if(조건식, 0, 1)  0 --> 참일 때,  1 --> 거짓일 때
       
       if(commission_pct != null) {
			return 1;
       } else {
			return 0;
       }
       state <-- commission_pct null ==> 0       commission_pct !null ==> 1
from employees
;
*/

select first_name,
	   salary,
       commission_pct,
       if(commission_pct is null, '사무직', '영업사원') as 'if()',
       ifnull(commission_pct, '없음') as 'ifnull()'
from employees
;

-- 직원아이디, 월급, 업무아이디, 실제월급(realSalary)을 출력하세요.
-- 실제월급은 job_id 가 'AC_ACCOUNT' 면 월급+월급*0.1,
--                        'SA_REP'면 월급+월급*0.2,                           
-- 						'ST_CLERK' 면 월급+월급*0.3                      
--  		         		그외에는 월급으로 계산하세요

select job_id,
	   salary,
       case when job_id = 'AC_ACCOUNT' then salary + salary*0.1
		    when job_id = 'SA_REP' then salary + salary*0.2
            when job_id = 'ST_CLERK' then salary + salary*0.3
            else salary
	   end as realSalary
from employees
;

-- 직원의 이름, 부서아이디, 팀을 출력하세요
-- 팀은 코드로 결정하며 부서코드가  10~50 이면 'A-TEAM' 
-- 60~100이면 'B-TEAM' 
-- 110~150이면 'C-TEAM'    
-- 나머지는 '팀없음' 으로 출력하세요.

select first_name 이름,
	   department_id '부서 아이디',
       case when department_id >=10 and department_id <=50 then 'A-TEAM'
			when department_id >=60 and department_id <=100 then 'B-TEAM'
			when department_id >=110 and department_id <=150 then 'C-TEAM'
			else '팀없음'
       end as 'Team'
from employees;

select *
from employees;




