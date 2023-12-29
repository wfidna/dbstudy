데이터타입 변환 함수

/*
	dual table: dummy table
	1개의 열(dummy)과 1개의 행(x)으로 구성
	DU
	--
	X

	1. 테이블이 필요없는 경우에 사용하는 테이블
	2. 테이블이 필요없는 조회의 경우에도 from까지
*/

-- 문자 -> 숫자: TO_NUMBER(문자)
select * from department_t where dept_no = '1'; -- no error
-- no error because oracle do the auto transformation with to_number

-- 숫자 -> 문자: TO_CHAR(숫자, [형식])
select to_char(salary),
       to_char(salary, '99999999'), -- 빈자리 공백
       to_char(salary, '00000000'), -- 빈자리 0
       to_char(salary, '9999,9,999'),
       to_char(salary, '9999') -- #### 처리
     from employee_t;

-- 문자 -> 날짜: to_date(문자, [형식])
/*
	* 날짜/시간 형식
	YY, YYYY, MM, DD, AM(오전/오후), HH(12시간), HH24(24시간), MI(분), SS(초), FF2(밀리초)
*/
select to_date('03/02/01') from dual;

-- 날짜 -> 문자: TO_CHAR
-- current date: SYSDATE
-- oracle date type does not store more than seconds

/*
	date 형식의 날짜/시간 연산
	   1) 1을 1일로, 1일을 1로 처리
	   2) 단위 처리: 1: 1일, 1/24: 1시간, ...
*/
select to_char(sysdate, 'yy/mm/dd hh24:mi:ss'),
       to_char(sysdate + 1, 'yy/mm/dd hh24:mi:ss'),
       to_char(sysdate - 1/24, 'yy/mm/dd hh24:mi:ss'),
       to_char(sysdate + 1/24/60, 'yy/mm/dd hh24:mi:ss')
     from dual;

select systimestamp + 1 + interval '2' month from dual;

/*
	날짜/시간 단위 추출
	extract(단위 from 날짜/시간)
*/

-- extracting as utc
select extract(HOUR FROM systimestamp),
       extract(YEAR FROM sysdate) as "year from sysdate"
     from dual;

/*
	month 전용 함수?
	ADD_MONTHS(date, n)
	MONTHS_BETWEEN(date1, date2)
*/
