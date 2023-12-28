/*
	DQL: data query language

	실행시 데이터에 영향을 주지 않음
	no transaction

	SELECT querying_column, ...
	       FROM table_name
	       [
	       WHERE condition
	       <GROUP BY grouping_columns
	        HAVING grouping_condition> -- usually comes together
	       ORDER BY ordering_columns ASC|DESC, ...
	       ]
*/

-- 부서 테이블의 모든 칼럼 조회
SELECT DEPT_NO, DEPT_NAME FROM DEPARTMENT_T;
SELECT * FROM DEPARTMENT_T; -- !!!!!!!!!!! 실무에서 사용 금지 !!!!!!!!!!!!! 성능에 영향 있음

SELECT DEPARTMENT_T.DEPT_NO, DEPARTMENT_T.DEPT_NAME, DEPARTMENT_T.LOCALTION FROM DEPARTMENT_T;

SELECT D.DEPT_NO, D.DEPT_NAME, D.LOCALTION FROM DEPARTMENT_T D;

-- 부서 테이블의 모든 칼럼 조회. 조회 칼럼명 지정: '부서번호', '부서명', '위치'
SELECT DEPT_NO AS 부서번호,
       DEPT_NAME AS 부서명,
       LOCATION AS 위치
   FROM DEPARTMENT_T;

-- 부서 테이블의 위치 칼럼을 중복 제거하여 조회
SELECT DISTINCT LOCATION
   FROM DEPARTMENT_T;

SELECT LOCATION
   FROM DEPARTMENT_T
  GROUP BY LOCATION;

/*
	주요 조건식 작성 방법
	1. column = value
	2. column between value1 AND value2
	3. column IN(value1, value2)
	4. column IS NULL
	5. column IS NOT NULL
	6. column LIKE value -- depends on value/whether column value include value
*/

-- 부서 테이블에서 부서번호가 1인 부서 정보 조회
SELECT *
       FROM DEPARTMENT_T
      WHERE DEPT_NO = 1;

-- 부서 테이블에서 지역이 '서울'인 부서 정보를 조회
SELECT *
       FROM DEPARTMENT_T
      WHERE LOCATION = '서울'; -- location 칼럼은 unique 하지 않ㅈ기 때문에 조회 결과가 두 개 이상일 수 있음

-- 사원 테이블에서 기본급이 3000000 이상인 사원 조회
SELECT *
       FROM EMPLOYEE_T
      WHERE SALARY > 3000000;

-- 사원 테이블에서 기본급이 2000000 ~ 3000000 사원 조회
SELECT *
       FROM EMPLOYEE_T
      WHERE SALARY BETWEEN 2000000 AND 3000000;

-- 사원 테이블에서 직급이 '사원', '과장'인 사원 조회
SELECT *
       FROM EMPLOYEE_T
      WHERE POSITION IN('사원', '과장');

/*
	WILD CARD: % (any length), _ (single character)
	examples: A%, _A%, %A, %A% ...
*/

-- 사원 테이블에서 '한'씨 조회
SELECT *
       FROM EMPLOYEE_T
      WHERE NAME LIKE '한%';

-- 사원 테이블에서 9월 입사 사원 조회
SELECT *
       FROM EMPLOYEE_T
      WHERE HIRE_DATE LIKE '%/09/%';
