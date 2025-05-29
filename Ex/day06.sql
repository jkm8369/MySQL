-- ---------------------------------------------------
#SubQuery
-- ---------------------------------------------------
-- 'Den'보다 월급은 많이 받은 사람의 이름과 월급은?
-- Den의 월급
select salary
from employees
where first_name = 'Den'
;

-- 11000보다 많이 받은 사람의 리스트
select first_name,
	   salary
from employees
where salary >= 11000
;

select first_name,
	   salary
from employees
where salary >= (select salary
				 from employees
			    where first_name = 'Den')
;
-- -------------------------------------------------------
-- 월급을 가장 적게 받는 사람의 이름, 월급, 사원번호는?
-- 가장 적은 월급 min(), 그룹함수라서 이름하고 같이 사용할 수 없다
-- 1) 가장 적은 월급
select min(salary)
from employees
;

-- 2) 월급이 2100인 사람의 이름, 월급, 사번
select first_name,
	   salary,
       employee_id
from employees
where salary = 2100
;

-- 3) 합치기
select e.first_name,
	   e.salary,
       e.employee_id
from employees e
right outer join departments d
			  on e.department_id = d.department_id
where salary = (select min(salary)
				 from employees)
;

-- 절대로 한방에 작성하지 않는다

-- -------------------------------------------------------
-- 평균 월급보다 적게 받는 사람의 이름, 월급을 출력하세요
-- 1) 평균 월급
select avg(salary)
from employees
;

-- 평균 월급보다 적은 사람을 구한다
select first_name,
	   salary
from employees
where salary <= 6461.831776
;

-- 1과 2 합치기
select first_name,
	   salary
from employees
where salary <= (select avg(salary)
				   from employees)
order by salary asc
;

-- -------------------------------------------------------
-- 부서번호가 110인 직원의 월급과 같은 월급을 받는
-- 모든 직원의 사번, 이름, 월급을 출력하세요

-- 부서번호가 110인 직원
select first_name
from employees
where department_id = 110
;

-- 부서번호가 110인 직원의 월급
select salary
from employees
where department_id =110
;

-- 부서번호가 110인 직원의 월급과 같은 월급을 받는 직원
-- where절로 구하기, or 조건절이 여러개
select employee_id,
	   first_name,
       salary
from employees
where salary = 12008.00
or salary = 8300.00
;

-- 
select employee_id,
	   first_name,
       salary
from employees
where salary in(12008.00, 8300.00)
;

-- 합치기
select employee_id,
	   first_name,
       salary
from employees
where salary in(select salary
				  from employees
				 where department_id = 110)
;

-- -------------------------------------------------------
-- 각 부서별로 최고급여를 받는 사원의 이름과 월급을 출력하세요
-- 직원 데이터 보기
select department_id,
	   first_name,
       salary
from employees e
;

-- 1)각 부서별 최고 월급 --> 이름 출력 안됨
select department_id,
	   max(salary)
from employees
group by department_id
;
/*
10	4400.00
20	13000.00
30	11000.00
....
*/

-- 2) 각 부서별 최고 월급을 받은 사람 이름 출력
select first_name,
	   department_id,
       salary
from employees
where (department_id = 10 and salary = 4400)
or (department_id = 20 and salary = 13000)
or (department_id = 30 and salary = 11000)
;

-- 2-2) in () --> 비교값이 2개 이상
select first_name,
	   department_id,
       salary
from employees
where (department_id, salary) in ((10, 4400), (20, 13000), (30, 11000))
;

-- 3) 합치기 --> 2-2 사용
select first_name,
	   department_id,
       salary
from employees
where (department_id, salary) in (select department_id,
										 max(salary)
									from employees
                                    group by department_id)
;

-- -------------------------------------------------------
/*
부서번호가 110인 직원의 월급 중 
가장 작은 월급 보다 월급이 많은 모든 직원의 
이름, 급여를 출력하세요.(or연산--> 8300보다 큰)
*/

-- 1) 부서번호가 110인 직원의 월급(8300, 12008)
select salary
from employees
where department_id = 110
;

-- 2) 월급이 8300보다 많은 직원 (8300보다 많은 직원 또는 12008보다 많은 직원)
-- 2-1) where절
select *
from employees
where salary >8300
or salary > 12008
;

-- 2-2) any()    where절이 or일 때
select *
from employees
where salary > any(8300, 12008)
;

-- 3) 합치기
-- or --> any
select first_name,
	   salary
from employees
where salary > any (select salary
					  from employees
					 where department_id = 110)
;

-- -------------------------------------------------------
/*
부서번호가 110인 직원의 월급 중 
가장 많은 월급 보다 월급이 많은 모든 직원의   //12008 보다 많은
이름, 급여를 출력하세요.(and연산--> 12008보다 큰)
*/

-- 1) 부서번호 110인 직원의 월급 구하기
select salary
from employees
where department_id = 110
;

-- 2) 부서번호 110의 직원의 월급 중 가장 높은 월급보다 월급이 높은 직원 구하기
-- 2-1) where절로 표현
select first_name,
	   salary
from employees
where salary > 8300 
and salary > 12800
;

-- 2-2) all로 ()로 표현 -- 의미만
select first_name,
	   salary
from employees
where salary > all (select salary
					  from employees
				     where department_id = 110 )
;

-- -------------------------------------------------------
-- 각 부서별로 최고 월급을 받는 사원의 부서번호, 직원번호, 이름, 월급을 출력하세요
-- 1)각 부서별 최고 월급
select department_id,
	   max(salary)
from employees
group by department_id
order by department_id asc  -- 확인용
;

-- 2) 
select *
from employees
where department_id = 10 and salary = 4400
or department_id = 20 and salary = 13000
or department_id = 30 and salary = 11000
;

-- 2-2) in any all
select *
from employees
where (department_id, salary) in ((10, 4400), (20, 13000), (30, 11000))
;

-- 3) 2-2로 합친다
-- 부서번호, 직원번호, 이름, 월급
select department_id,
	   employee_id,
       first_name,
       salary
from employees
where (department_id, salary) in (select department_id,
										 max(salary)
									from employees
								group by department_id)
order by department_id asc
;

/*
select *
from 테이블명
where 컬럼명 in (서브커리 결과)
;
*/

-- ------------------------------------------------------

-- #from절의 테이블로 해결

/*
-- 테이블 2를 조인한다.
select *
from 테이블명(서브커리 결과), 테이블2(서브쿼리결과)
where 컬럼명 = 컬렁명
*/

-- 각 부서별로 최고월급을 받는 사원의 부서번호, 직원번호, 이름, 월급을 출력하세요
-- 1) 각 부서별 최고 월급
select department_id,
	   max(salary)
from employees
group by department_id
;

-- 결과 일부
-- (10,4400)
-- (20, 13000)
-- (30, 11000)

-- 2) 전체구조
select *
from employees e, 가상의테이블 s
where e.department_id = s.department_id
and e.salary = s.salary
;

select *
from employees e
where e.department_id = 20
and e.salary = 6000
;

-- ------------------------------------------------------
-- 각 부서별로 최고 급여를 받는 사원을 출력하세요
select department_id,
	   max(salary)
from employees
group by department_id
;

select employee_id,
	   department_id,
	   first_name,
	   salary
from employees e
where (e.department_id = 10 and salary = 4400)
or (e.department_id = 20 and salary = 13000)
or (e.department_id = 30 and salary = 11000)
;

select employee_id,
	   department_id,
	   first_name,
	   salary
from employees e
where (e.department_id, salary) in (select department_id,
										   max(salary)
									  from employees
								  group by department_id)
;

-- ------------------------------------------------------
select department_id,
	   max(salary)
from employees
group by department_id
;

select e.department_id,
	   e.employee_id,
       e.first_name,
       e.salary,
       s.maxSalary
from employees e, (select department_id,
						  max(salary) maxSalary
					 from employees
			     group by department_id) as s
where e.department_id = s.department_id
and e.salary = s.maxSalary
;