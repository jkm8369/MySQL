/*
문제1.
평균 월급보다 적은 월급을 받는 직원은 몇명인지 구하시요.  평균월급 6461.831776
(56건)
*/
-- 평균 월급
select avg(salary)
from employees
;

-- 평균 월급보다 적은 월급을 받는 직원의 수
select count(salary)
from employees
where salary < (select avg(salary)
					  from employees)
;

/*
문제2. 
평균월급 이상, 최대월급 이하의 월급을 받는 사원의   (평균월급: 6461.831776  최대월급: 24000.00)
직원번호(employee_id), 이름(first_name), 월급(salary), 평균월급, 최대월급을 월급의 오름차순으로 정렬하여 출력하세요 
*/
-- 평균월급, 최대월급
select avg(salary),
	   max(salary)
from employees
;

-- 
select *
from employees
where salary >=6461.831776 
and salary <= 24000.00
;

-- 
select employee_id,
	   first_name,
       salary,
       avg(salary),
       max(salary)
from employees
where salary between (select avg(salary)
					    from employees)
				 and (select max(salary)
						from employees)
group by employee_id, first_name, salary
order by salary asc
;




















