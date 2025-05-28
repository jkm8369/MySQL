/*************************************************
join
*************************************************/
-- 기본
-- 직원의 이름과 직원이 속한 부서명을 출력하세요
-- Steven    90 90  Executive
-- 카디젼 프로덕트 --> 모든 경우의 수의 갯수가 된다
-- 107 * 27 = 2889개 (원하는게 아니다 --> 107개)

select first_name 이름,
	   department_name 부서명
from employees, departments
;

-- where절을 사용한다
select first_name 이름,
	   department_name 부서명
from employees, departments
where employees.department_id = departments.department_id  -- where절 사용
;

/*************************************************
#inner join (equi join)   equi --> equal
*************************************************/
-- 직원의 이름과 직원이 속한 부서명을 출력하세요 
select first_name,
	   employees.department_id,
       departments.department_id
from employees 
inner join departments
		on employees.department_id = departments.department_id
;

-- inner join (equi join) 정식표현
select e.first_name,
	   e.department_id,
	   d.department_id,
	   d.department_name
from employees e 
inner join departments d
		on e.department_id = d.department_id
;

-- inner join (equi join) where절 사용 -->많이 사용
select e.first_name,
	   e.department_id,
	   d.department_id,
       d.department_name
from employees e, departments d
where e.department_id = d.department_id
;
-- ------------------------------------------
-- 여러개 테이블을 조인할때
/*
107      27        23
이름   부서명    부서도시
Steven Excutive  Seattle
Neena  Excutive  Seattle
...
David  IT        Southlake
(106개)
*/
-- inner join (equi join) where절 사용 -->많이 사용
select e.first_name,
	   d.department_name,
       l.city
from employees e, departments d, locations l
where e.department_id = d.department_id
and d.location_id = l.location_id
;

-- inner join (equi join) 정식표현
/*
107      27        23
이름   부서명    부서도시
Steven Excutive  Seattle
Neena  Excutive  Seattle
...
David  IT        Southlake
(106개)
*/
select e.first_name,
	   d.department_name,
       d.department_id,
       l.city,
       l.location_id
from employees e 
inner join departments d
	    on e.department_id = d.department_id
inner join locations l
	    on d.location_id = l.location_id
;

-- 모든 직원이름, 부서이름, 업무명 을 출력하세요   *3개의 테이블
select e.first_name 직원이름,
	   d.department_name 부서이름,
	   j.job_title 업무명
from employees e, departments d, jobs j
where e.department_id = d.department_id
and e.job_id = j.job_id
;

select e.first_name 직원이름,
	   d.department_name 부서이름,
	   j.job_title 업무명
from employees e
inner join departments d
	    on e.department_id = d.department_id
inner join jobs j
	    on e.job_id = j.job_id
;
-- -------------------------------------------------
select count(*) from employees;   -- 107

select count(*) from departments;  -- 27

select count(*) from locations;    -- 23

select * from employees;  -- 107

/*************************************************
#left outer join      -- where절로 표현 불가
*************************************************/
-- 왼쪽 테이블을 기준, 기준 테이블의 정보는 다 보여줌
-- (kimberley가 결과에 있어야 함: 소속부서가 없는 직원)

select e.first_name,
	   d.department_name,
       e.department_id,
       d.department_id
from employees e
left outer join departments d
			 on e.department_id = d.department_id
;

/*************************************************
#right outer join      -- where절로 표현 불가
*************************************************/
-- 모든 직원의 부서번호, 이름, 부서번호를 출력하세요
-- 직원이 없는 부서도 표시  (kimberley 빠짐)
select e.first_name,
	   d.department_name,
       d.department_id
from employees e
right outer join departments d
			  on e.department_id = d.department_id
;

/*************************************************
#right outer join --> left outer join     -- where절로 표현 불가
*************************************************/

select e.first_name,
	   d.department_name,
       d.department_id,
       e.department_id
from departments d
left outer join employees e
			 on d.department_id = e.department_id
;

/*************************************************
#full outer join   union               -- where절로 표현 불가
*************************************************/
-- (왼쪽 기준)
select e.employee_id,
	   e.first_name,
	   d.department_id,
       d.department_name
from employees e
left outer join departments d
			 on e.department_id = d.department_id
union
-- (오른쪽 기준)
select e.employee_id,
	   e.first_name,
       d.department_id,
       d.department_name
from employees e
right outer join departments d
			  on e.department_id = d.department_id
;

-- --------------------------------------------------------
/*************************************************
#self join
*************************************************/
-- 테이블에서 자신의 pk를 fk로 가지고 있는 경우
-- 같은 테이블을 두번 불러와서 써야되는 경우
-- 두번 불러와서 별명을 다르게 준다(꼭 별명을 주어야 함)
select e.employee_id,
	   e.first_name,
       e.phone_number,
	   m.employee_id as 'm_id',
       m.first_name as m_first_name,
       m.phone_number as m_phone_number
from employees e, employees m
where e.manager_id = m.employee_id
;

/*************************************************
#참고 잘못된 join
*************************************************/
-- 잘못된 join
-- 아무 컬럼이나 where에 사용하면 안된다
select *
from employees e, locations l
where e.salary = l.location_id
;

-- ---------------------------------------------------------------
# 조인 연습(equi join, inner join 두가지로 풀어볼것)
-- 직원아이디, 이름, 월급, 부서아이디, 부서명, 도시아이디, 도시명
-- equi join
select e.employee_id '직원 아이디',
	   e.first_name 이름,
       e.salary 월급,
       e.department_id '부서 아이디',
       d.department_name 부서명,
       l.location_id '도시 아이디',
       l.city 도시명
from employees e, departments d, locations l
where e.department_id = d.department_id
and d.location_id = l.location_id
;

-- inner join
select e.employee_id '직원 아이디',
	   e.first_name 이름,
       e.salary 월급,
       e.department_id '부서 아이디',
       d.department_name 부서명,
       l.location_id '도시 아이디',
       l.city 도시명
from employees e
inner join departments d
		on e.department_id = d.department_id
inner join locations l
		on d.location_id = l.location_id
;

-- 직원아이디, 이름, 월급, 부서아이디, 부서명, 도시아이디, 도시명, 나라아이디, 나라명
-- equi join
select e.employee_id 직원아이디,
	   e.first_name 이름,
       e.salary 월급,
       d.department_id 부서아이디,
       d.department_name 부서명,
       l.city 도시명,
       c.country_id 나라아이디,
       c.country_name 나라명
from employees e, departments d, locations l, countries c
where e.department_id = d.department_id
and d.location_id = l.location_id
and l.country_id = c.country_id
;   
-- inner join
select e.employee_id 직원아이디,
	   e.first_name 이름,
       e.salary 월급,
       d.department_id 부서아이디,
       d.department_name 부서명,
       l.city 도시명,
       c.country_id 나라아이디,
       c.country_name 나라명
from employees e
inner join departments d
		on e.department_id = d.department_id
inner join locations l
		on d.location_id = l.location_id
inner join countries c
		on l.country_id = c.country_id
;

-- 직원아이디, 이름, 월급, 부서아이디, 부서명, 도시아이디, 도시명, 나라아이디, 나라명, 지역아이디, 지역명
-- equi join
select e.employee_id 직원아이디,
	   e.first_name 이름,
       e.salary 월급,
       d.department_id 부서아이디,
       d.department_name 부서명,
       l.location_id 도시아이디,
       l.city 도시명,
       c.country_id 나라아이디,
       c.country_name 나라명,
       r.region_id 지역아이디,
       r.region_name 지역명
from employees e, departments d, locations l, countries c, regions r
where e.department_id = d.department_id
and d.location_id = l.location_id
and l.country_id = c.country_id
and c.region_id = r.region_id
;







