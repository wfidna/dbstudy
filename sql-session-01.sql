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

-- �μ� ���̺� �μ� ��ȣ �����ϴ� ������

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

INSERT INTO DEPARTMENT_T(DEPT_NO, DEPT_NAME, LOCATION) VALUES (dept_seq.NEXTVAL, '������', '�뱸');
INSERT INTO DEPARTMENT_T VALUES (dept_seq.NEXTVAL, '�λ��', '����');
INSERT INTO DEPARTMENT_T VALUES (dept_seq.NEXTVAL, '�ѹ���', '�뱸');
INSERT INTO DEPARTMENT_T VALUES (dept_seq.NEXTVAL, '��ȹ��', '����');

INSERT INTO EMPLOYEE_T VALUES(emp_seq.NEXTVAL, '��â��', 1, '����', 'M', '95-05-01', 5000000);
INSERT INTO EMPLOYEE_T VALUES(emp_seq.NEXTVAL, '��μ�', 1, '���', 'M', '17-09-01', 2500000);
INSERT INTO EMPLOYEE_T VALUES(emp_seq.NEXTVAL, '������', 2, '����', 'F', '90-09-01', 5500000);
INSERT INTO EMPLOYEE_T VALUES(emp_seq.NEXTVAL, '�Ѽ���', 2, '����', 'M', '93-04-01', 5000000);

COMMIT;

/*
	����

	UPDATE table_name SET updating_content, ... WHERE conditional_expression
*/

-- DEPARTMENT_T���� �μ���ȣ(DEPT_NO)�� 3�� �μ��� ����(LOCATION)�� '��õ'���� ����
UPDATE DEPARTMENT_T
       SET LOCATION = '��õ'
     WHERE DEPT_NO = 3;

-- EMPLOYEE_T���� �μ���ȣ(DEPART)�� 2�� �μ��� ������� �⺻��(SALARY) 10% �λ�
UPDATE EMPLOYEE_T
       SET SALARY = SALARY * 1.1
     WHERE DEPART = 2;

-- �ѹ�
-- SAVEPOINT savepointflag;
-- ROLLBACK TO savepointflag;

ROLLBACK; -- default to commit

/*
	����

	DELETE FROM table_name WHERE conditional_expression
*/

-- DEPARTMENT_T���� �μ���ȣ(DEPT_NO)�� 3�� �μ� ���� (�μ���ȣ�� 3�� ����� ����: does not affect referential integrity)
DELETE FROM DEPARTMENT_T
       WHERE DEPT_NO = 3;

-- EMPLOYEE_T���� �μ���ȣ(DEPART)�� 1�� 4�� ��� ����
DELETE FROM EMPLOYEE_T
       WHERE DEPART IN(1, 4);

-- DEPARTMENT_T���� �μ���ȣ(DEPT_NO)�� 2�� �μ� ���� (�μ���ȣ�� 2�� ����� ����: breaks referential integrity
   		    			    	      -- on delete set null ���� ������ ����� dept_no ���� null�� �Ǹ鼭 ������ ����)
DELETE FROM DEPARTMENT_T
       WHERE DEPT_NO = 2;

ROLLBACK;
