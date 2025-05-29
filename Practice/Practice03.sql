/*
문제1.
직원들의 사번(employee_id), 이름(firt_name), 성(last_name)과 부서명(department_name)을 조회하여
부서이름(department_name) 오름차순, 사번(employee_id) 내림차순 으로 정렬하세요.
(106건)
*/

select e.employee_id 사번,
	   e.first_name 이름,
       e.last_name 성,
       d.department_name 부서명
from employees e, departments d
where e.department_id = d.department_id
order by d.department_name asc, e.employee_id desc
;

/*
문제2.
employees 테이블의 job_id는 현재의 업무아이디를 가지고 있습니다.
직원들의 사번(employee_id), 이름(firt_name), 월급(salary), 부서명(department_name), 현재업무(job_title)를
사번(employee_id) 오름차순 으로 정렬하세요.
부서가 없는 Kimberely(사번 178)은 표시하지 않습니다.
(106건)
*/
select e.employee_id 사번,
	   e.first_name 이름,
       e.salary 월급,
       d.department_name 부서명,
       j.job_title 현재업무
from employees e, jobs j, departments d
where e.job_id = j.job_id
and e.department_id = d.department_id
order by e.employee_id asc
;

/*
문제2-1.
문제2에서 부서가 없는 Kimberely(사번 178)까지 표시해 보세요
(107건)
*/
select e.employee_id 사번,
	   e.first_name 이름,
       e.salary 월급,
       d.department_name 부서명,
       j.job_title 현재업무
from employees e
left outer join departments d
		     on e.department_id = d.department_id
	 inner join jobs j
			 on e.job_id = j.job_id
order by e.employee_id asc
;

/*
문제3.
도시별로 위치한 부서들을 파악하려고 합니다.
도시아이디, 도시명, 부서명, 부서아이디를 도시아이디(오름차순)로 정렬하여 출력하세요 
부서가 없는 도시는 표시하지 않습니다.
(27건)
*/
select l.location_id 도시아이디,
	   l.city 도시명,
       d.department_name 부서명,
       d.department_id 부서아이디
from locations l, departments d
where l.location_id = d.location_id
order by l.location_id
;

select *
from locations l, departments d
where l.location_id = d.location_id
;

/*
문제4.
지역(regions)에 속한 나라들을 지역이름(region_name), 나라이름(country_name)으로 출력하되 지역이름(오름차순), 나라이름(내림차순) 으로 정렬하세요.
(25건)
*/
















