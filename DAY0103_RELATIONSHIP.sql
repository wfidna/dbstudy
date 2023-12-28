/*
CREATE TABLE BLOG_T (
    BLOG_NO  NUMBER	NOT NULL	PRIMARY KEY,
    TITLE    VARCHAR2(100 BYTE)		NOT NULL,
    EDITOR   VARCHAR2(100 BYTE)		NOT NULL,
    CONTENTS CLOB	  		NULL,
    CREATED  DATE			NOT NULL
    )
*/

-- product table
CREATE TABLE PRODUCT_T (
       PRODUCT_NO		NUMBER			NOT NULL	PRIMARY KEY,
       PRODUCT_NAME		VARCHAR2(100 BYTE)	NOT NULL,
       PRODUCT_PRICE		NUMBER	    		NOT NULL,
       PRODUCT_STOCK		NUMBER			NULL
       );

-- order table
CREATE TABLE ORDER_T (
       ORDER_NO			NUMBER			NOT NULL	PRIMARY KEY,
       MEMBER_ID		VARCHAR2(100 BYTE)	NOT NULL,
       PRODUCT_NO		NUMBER	     		REFERENCES PRODUCT_T (PRODUCT_NO),
       ORDERED_AT		DATE			NOT NULL
       );

/*
    foreign key
    1. when referencing other table
    2. can be duplicated and nulled
    3. must keep referential integrity:
       1) only data exising in referencing table
       2) to prevent violating referential integrity, use 'additional options'
       :: solutions
          - delete only child key when parent key is deleted
	  - delete all rows containing child key when parent key is deleted
    4. format
       parent table - child table
       parent key   - child key
       -- parent key:
          basically "primary key", any unique keys

    when is referential integrity violated?
      think about a situation when some member sign out your website.

    solutions?
      1. delete only foreign key (then the items in the child table remain)
       : ON DELETE SET NULL
      2. delete both (delete both items in both table)
       : ON DELETE CASCADE
*/

/*
    one to N relationship
    1. most of relationships relating two tables
    2. 1 : N = PK : FK
    3. parent table must be created before creating child table
       - child table must be deleted before deleting parent
*/

-- delete order table
DROP TABLE ORDER_T;

-- delete product table
DROP TABLE PRODUCT_T;



-- student table
CREATE TABLE STUDENT_T (
       STUDENT_NO		NUMBER			NOT NULL	PRIMARY KEY,
       STUDENT_NAME    		VARCHAR2(100 BYTE)	NOT NULL,
       STUDENT_GRADE   		NUMBER	   		NOT NULL,
       STUDENT_CLASS   		CHAR(100 BYTE)		NOT NULL,
       STUDENT_CLASS_NO		NUMBER			NOT NULL
       );

-- subject table
CREATE TABLE SUBJECT_T (
       SUBJECT_NO		NUMBER			NOT NULL	PRIMARY KEY,
       SUBJECT_NAME    		VARCHAR2(100 BYTE)	NOT NULL
       );

-- registration table (mediating table)
CREATE TABLE ENROLL_T (
       ENROLL_NO		NUMBER			NOT NULL	PRIMARY KEY,
       STUDENT_NO		NUMBER	     		REFERENCES STUDENT_T (STUDENT_NO) ON DELETE CASCADE, -- after student deleted enrollment also deleted
       SUBJECT_NO		NUMBER			REFERENCES SUBJECT_T (SUBJECT_NO) ON DELETE SET NULL
       );

/*
   N to N relationship
   mediating table is required: it is not possible to relate those two table directly
   decompose into two 1 to n table/relationship
*/

-- 테이블 정의서 --


-- department table
CREATE TABLE DEPARTMENT_TBL (
       DEPT_NO			VARCHAR2(15 BYTE)	NOT NULL	PRIMARY KEY,
       DEPT_NAME		VARCHAR2(30 BYTE)	NULL,
       DEPT_LOCATION		VARCHAR2(50 BYTE)	NULL
       );

-- employee table
CREATE TABLE EMPLOYEE_TBL (
       EMP_NO			NUMBER			NOT NULL	PRIMARY KEY,
       DEPT_NO			VARCHAR2(15 BYTE)	NULL		REFERENCES DEPARTMENT_TBL (DEPT_NO) ON DELETE SET NULL,
       EMP_POSITION		CHAR(10 BYTE)		NULL,
       EMP_NAME			VARCHAR2(15 BYTE)	NULL,
       HIRE_DATE		DATE	    		NULL,
       SALARY			NUMBER			NULL
       );

-- project table
CREATE TABLE PROJECT_TBL (
       PRJ_NO			NUMBER			NOT NULL	PRIMARY KEY,
       PRJ_NAME			VARCHAR2(30 BYTE)	NULL,
       BEGIN_DATE		DATE	    		NULL,
       END_DATE			DATE			NULL
       );

-- proceeding table
CREATE TABLE PROCEEDING_TBL (
       PCD_NO			NUMBER			NOT NULL	PRIMARY KEY,
       EMP_NO			NUMBER			NULL		REFERENCES EMPLOYEE_TBL (EMP_NO) ON DELETE CASCADE,
       PRJ_NO			NUMBER			NULL		REFERENCES PROJECT_TBL (PRJ_NO) ON DELETE SET NULL,
       PRJ_STATE		NUMBER			NOT NULL
       );
