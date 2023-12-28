/*
	DML: data manipulation language
	needed to be transactioned

	transaction <atomicity, all or none>
	- needed to be executed at once like bank transaction that comprise more than one process
	- example: bank transaction
	  1) take money from my pocket
	  2) put money into his pocket
	  if powers gone between 1) and 2) only loss occur
	BEGIN;
	ROLLBACK;
	COMMIT;
	-- also called transaction control language

	addition
	modification
	deletion
	these three process requires to be "committed"

	type of dml:
	     1. row insertion		: INSERT INTO VALUES
	     2. row modification	: UPDATE SET WHERE
	     3. row deletion		: DELETE FROM WHERE

	sequence can be create with CREATE
	CREATE SEQUENCE sequence_name

	SEQUENCE: database object that generates sequence
	- mostly used for generating primary key value
	- function
	  -- generate new value: NEXTVAL
	  -- check the current value: CURRVAL
*/

-- 부서 테이블 부서 번호 생성하는 시퀀스

DROP SEQUENCE dept_seq;

CREATE SEQUENCE dept_seq
    INCREMENT BY 1
    START WITH 1
    NOMAXVALUE
    NOMINVALUE
    NOCYCLE
    NOCACHE
    ORDER
;

DROP TABLE EMPLOYEE_T;
DROP TABLE DEPARTMENT_T;

CREATE TABLE DEPARTMENT_T (
       DEPT_NO			NUMBER			NOT NULL,
       DEPT_NAME		VARCHAR2(15 BYTE)	NOT NULL,
       LOCATION			VARCHAR2(15 BYTE)	NOT NULL,

       CONSTRAINT		PK_DEPT     		PRIMARY KEY(DEPT_NO)
       );

CREATE TABLE EMPLOYEE_T (
       EMP_NO		NUMBER			NOT NULL,
       NAME		VARCHAR2(20 BYTE)	NOT NULL,
       DEPART		NUMBER	    		NULL,
       POSITION		VARCHAR2(20 BYTE)	NULL,
       GENDER		CHAR(2 BYTE)		NULL,
       HIRE_DATE	DATE   			NULL,
       SALARY		NUMBER			NULL,

       CONSTRAINT	PK_EMP			PRIMARY KEY(EMP_NO),
       CONSTRAINT	FK_EMP_DEPT		FOREIGN KEY(DEPART) REFERENCES DEPARTMENT_T(DEPT_NO) ON DELETE SET NULL
       );

DROP SEQUENCE emp_seq;

CREATE SEQUENCE emp_seq
       START WITH 1001
       NOCACHE
;

INSERT INTO DEPARTMENT_T(DEPT_NO, DEPT_NAME, LOCATION) VALUES (dept_seq.NEXTVAL, '영업부', '대구');
INSERT INTO DEPARTMENT_T VALUES (dept_seq.NEXTVAL, '인사부', '서울');
INSERT INTO DEPARTMENT_T VALUES (dept_seq.NEXTVAL, '총무부', '대구');
INSERT INTO DEPARTMENT_T VALUES (dept_seq.NEXTVAL, '기획부', '서울');

INSERT INTO EMPLOYEE_T VALUES(emp_seq.NEXTVAL, '구창민', 1, '과장', 'M', '95-05-01', 5000000);
INSERT INTO EMPLOYEE_T VALUES(emp_seq.NEXTVAL, '김민서', 1, '사원', 'M', '17-09-01', 2500000);
INSERT INTO EMPLOYEE_T VALUES(emp_seq.NEXTVAL, '이은영', 2, '부장', 'F', '90-09-01', 5500000);
INSERT INTO EMPLOYEE_T VALUES(emp_seq.NEXTVAL, '한성일', 2, '과장', 'M', '93-04-01', 5000000);

COMMIT;

/*
	수정

	UPDATE table_name SET updating_content, ... WHERE conditional_expression
*/

-- DEPARTMENT_T에서 부서번호(DEPT_NO)가 3인 부서의 지역(LOCATION)을 '인천'으로 수정
UPDATE DEPARTMENT_T
       SET LOCATION = '인천'
     WHERE DEPT_NO = 3;

-- EMPLOYEE_T에서 부서번호(DEPART)가 2인 부서의 사원들의 기본급(SALARY) 10% 인상
UPDATE EMPLOYEE_T
       SET SALARY = SALARY * 1.1
     WHERE DEPART = 2;

-- 롤백
-- SAVEPOINT savepointflag;
-- ROLLBACK TO savepointflag;

ROLLBACK; -- default to commit

/*
	삭제

	DELETE FROM table_name WHERE conditional_expression
*/

-- DEPARTMENT_T에서 부서번호(DEPT_NO)가 3인 부서 삭제 (부서번호가 3인 사원이 없음: does not affect referential integrity)
DELETE FROM DEPARTMENT_T
       WHERE DEPT_NO = 3;

-- EMPLOYEE_T에서 부서번호(DEPART)가 1과 4인 사원 삭제
DELETE FROM EMPLOYEE_T
       WHERE DEPART IN(1, 4);

-- DEPARTMENT_T에서 부서번호(DEPT_NO)가 2인 부서 삭제 (부서번호가 2인 사원이 있음: breaks referential integrity
   		    			    	      -- on delete set null 구문 때문에 사원의 dept_no 값이 null이 되면서 실행이 가능)
DELETE FROM DEPARTMENT_T
       WHERE DEPT_NO = 2;

ROLLBACK;
