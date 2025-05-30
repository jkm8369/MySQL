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

-- 평균월급, 최대월급 사이 월급을 받는 직원
select *
from employees
where salary >=6461.831776 
and salary <= 24000.00
;


select employee_id,
	   first_name,
       salary,
       (select round(avg(salary), 0)
		from employees) avgSalary,
       (select max(salary)
		from employees) maxSalary
from employees e
where salary between (select avg(salary)
					    from employees)
				 and (select max(salary)
						from employees)
order by salary asc
;

/*
문제3.
직원중 Steven(first_name) king(last_name)이 소속된 부서(departments)가 있는 곳의 주소를 알아보려고 한다.  department_id = 90
도시아이디(location_id), 거리명(street_address), 우편번호(postal_code), 도시명(city), 주(state_province), 나라아이디(country_id) 를 출력하세요
*/
-- 스티븐킹 정보
select *
from employees
where first_name = 'Steven'
and last_name = 'king'
;

-- join
select l.location_id,
	   l.street_address,
       l.postal_code,
       l.city,
       l.state_province,
       l.country_id
from employees e, departments d,locations l
where e.department_id = d.department_id
and d.location_id = l.location_id
;

-- 서브쿼리 이용
select first_name,
	   last_name,
	   l.location_id,
	   l.street_address,
       l.postal_code,
       l.city,
       l.state_province,
       l.country_id
from (select first_name,
	         last_name,
			 department_id
	  from employees
	  where first_name = 'Steven'
	  and last_name = 'king') e, departments d,locations l
where e.department_id = d.department_id
and d.location_id = l.location_id
;

/*
문제5. 
각 부서별로 최고의 월급을 받는 사원의 직원번호(employee_id), 이름(first_name)과 월급(salary) 부서번호(department_id)를 조회하세요 
단 조회결과는 월급의 내림차순으로 정렬되어 나타나야 합니다. 
조건절비교, 테이블조인 2가지 방법으로 작성하세요
(11건)
*/
-- 부서 별 최고 월급
select department_id,
	   max(salary)
from employees
group by department_id
;

-- 부서별 최고월급 in()
select *
from employees
where (department_id,salary) in ((10, 4400), (20,13000), (30,11000))
;

-- where절 + 서브쿼리
select employee_id,
	   first_name,
       salary,
       department_id
from employees
where (department_id,salary) in (select department_id,
										max(salary)
								 from employees
								 group by department_id)
;

-- null 없애기
select e.employee_id,
	   e.first_name,
       e.salary,
       e.department_id
from employees e
left outer join departments d
		   on e.department_id = d.department_id
where (e.department_id, e.salary) in (select department_id,
										max(salary)
								 from employees
								 group by department_id)
order by salary desc
;

/*
문제6.
각 업무(job) 별로 월급(salary)의 총합을 구하고자 합니다. 
월급 총합이 가장 높은 업무부터 업무명(job_title)과 월급 총합을 조회하시오
(19건)
*/
-- 업무 별 월급 총합  //가장 높은 업무 SA_REP 월급 총합 250500 월급총합 내림차순
select job_id,
	   sum(salary)
from employees
group by job_id
;

select job_title,
	   sum(salary)
from employees e, jobs j
where e.job_id = j.job_id
group by job_title
order by sum(salary) desc
;

/*
문제7.
자신의 부서 평균 월급보다 월급(salary)이 많은 직원의 직원번호(employee_id), 이름(first_name)과 월급(salary)을 조회하세요 
(38건)
*/
-- 각 부서별 평균월급
select department_id,
	   avg(salary)
from employees
group by department_id
;

-- 
select e.employee_id,
	   e.first_name,
       e.salary,
       e.department_id
from employees e, (select department_id,
						  avg(salary) avgSalary
				   from employees
				   group by department_id) as s
where e.department_id = s.department_id
and e.salary > s.avgSalary
group by e.employee_id, e.first_name, e.salary, e.department_id
;







