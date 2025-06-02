-- ---------------------------------
-- 작성자: 홍길동 <---이름적을것
-- ---------------------------------


/* 문제1
부서번호가 100번인 부서의 
사번(employee_id), 이름(first_name), 월급(salary), 부서번호(department_id)를 
월급이 많은 직원부터 출력하세요
컬럼명은 괄호의 영어로 출력되도록 하세요
*/
select employee_id,
	   first_name,
       salary,
       department_id
from employees
where department_id = 100
order by salary desc
;


/* 문제2
월급이 12000 초과인 직원의 이름(first_name), 입사일(hire_date), 월급(salary), 사번(employee_id)을 입사일이 빠른직원부터 출력하세요
월급은 24,000 원 과 같이 출력하세요( 3자리 마다 콤마  그리고 소수첫째자리에서 반올림)
입사일은 2003/06/07 형식으로 출력하세요 
컬럼명은 괄호의 영어로 출력되도록 하세요
*/
select first_name,
	   date_format(hire_date, '%Y/%m/%d') as hire_date,
       format(salary, 0),
       employee_id
from employees
where salary > 12000
;


/* 문제3
각 부서별로 최고월급과, 평균월급, 부서번호를 구하세요
출력은 최고월급(maxSalary), 평균월급(avgSalary), 부서번호(department_id), 
컬럼명은 괄호의 영어로 출력되도록 하세요
*/
select max(salary),
	   avg(salary),
       department_id
from employees
group by department_id
;


/* 문제4
월급이 7000이상 8000미만인 직원을 출력하세요
출력 형식은 이름(first_name), 월급(salary), 부서번호(department_id), 부서명(department_name)
부서가 없은 직원도 출력하며 부서번호가 낮은부서 부터 출력하세요.
*/
select e.first_name,
	   e.salary,
	   e.department_id,
       d.department_name
from employees e
left outer join departments d
			 on e.department_id = d.department_id 
where salary >=7000
and salary < 8000
order by department_id asc
;

/* 문제5
부서번호가 60인 부서의 최고 월급보다 더 많은 월급을 받는 직원을 출력하세요
출력 형식은 사번, 이름, 월급, 부서번호 이며
월급이 높은직원 부터 출력하세요
*/
-- 부서번호 60인 부서의 최고 월급
select max(salary)
from employees
where department_id = 60
;

-- 출력
select employee_id 사번,
	   first_name 이름,
       salary 월급,
       department_id 부서번호
from employees
where salary > (select max(salary)
				from employees
				where department_id = 60)
order by salary desc
;

