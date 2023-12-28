DROP TABLE CUSTOMER_T;
DROP TABLE BANK_T;

CREATE TABLE BANK_T (
    BANK_CODE	    VARCHAR2(20 BYTE)	NOT NULL,
    BANK_NAME	    VARCHAR2(30 BYTE),
    CONSTRAINT	    PK_BANK		PRIMARY KEY(BANK_CODE)
    );

CREATE TABLE CUSTOMER_T (
    CUST_NO  		NUMBER			NOT NULL,
    CUST_NAME		VARCHAR2(30 BYTE)   	NOT NULL,
    CUST_PHONE		VARCHAR2(30 BYTE)   	UNIQUE,
    CUST_AGE		NUMBER(3)   	    	CHECK(CUST_AGE >= 0 AND CUST_AGE <= 120),
    					    	-- CHECK(CUST_AGE BETWEEN 0 AND 120),
    BANK_CODE		VARCHAR2(20 BYTE),
    CONSTRAINT		PK_CUSTOMER 	    	PRIMARY KEY(CUST_NO),
    CONSTRAINT		FK_CUSTOMER_BANK	FOREIGN KEY(BANK_CODE) REFERENCES BANK_T(BANK_CODE)
    );

-- CONSTRAINT
--SELECT * FROM USER_CONSTRAINTS;

-- 1. BANK_T�� ����ó(BANK_TEL) Į�� �߰�
ALTER TABLE BANK_T ADD BANK_TEL VARCHAR2(15 BYTE);

-- 2. BANK_T�� �����(BANK_NAME) Į���� VARCHAR2(15 BYTE)�� �ٲ� �� �ʼ� ���������� ����
ALTER TABLE BANK_T MODIFY BANK_NAME VARCHAR2(15 BYTE) NOT NULL;

-- 3. CUSTOMER_T�� ����(CUST_AGE) Į���� ����
ALTER TABLE CUSTOMER_T DROP COLUMN CUST_AGE;

-- 4. CUSTOMER_T�� ����ó(CUST_PHONE) Į���� CUST_TEL�� ����
ALTER TABLE CUSTOMER_T RENAME COLUMN CUST_PHONE TO CUST_TEL;

-- 5. CUSTOMER_T�� ���(GRADE) Į�� �߰�. ���� 'VIP', 'GOLD', 'SILVEER', 'BRONZE' �� ����
ALTER TABLE CUSTOMER_T ADD GRADE VARCHAR2(6 BYTE) CHECK(GRADE = 'VIP' OR GRADE = 'GOLD' OR GRADE = 'SILVEER' OR GRADE = 'BRONZE');
      	    	       	   	 	    	  -- CHECK(GRADE IN('VIP', 'GOLD', 'SILER', 'BRONZE'));

-- 6. CUSTOMER_T�� ����(CUST_NAME) Į���� �ʼ��������� ����
ALTER TABLE CUSTOMER_T MODIFY CUST_NAME VARCHAR2(30 BYTE) NULL;

-- 7. CUSTOMER_T�� ���̺���� CUST_T�� ����
ALTER TABLE CUSTOMER_T RENAME TO CUST_T;

/*
	1. PK
	   1) �߰�	: ALTER TABLE table_name ADD CONSTRAINT constraint_name PRIMARY KEY(column_name)
	   2) ����
	      (1) ALTER TABLE table_name DROP CONTRAINT constraint_name
	      (2) ALTER TABLE table_name DROP PRIMARY KEY
	2. FK
	   1) �߰�	: ALTER TABLE child_table_name ADD CONSTRAINT constraint_name FOREIGN KEY(column_name) REFERENCES parent_table_name(column_name) [options]
	   2) ����	: ALTER TABLE table_name DROP CONSTRAINT constraint_name
	   3) ��Ȱ��ȭ	: ALTER TABLE table_name DISABLE CONTRAINT constraint_name
	   4) Ȱ��ȭ	: ALTER TABLE table_name ENABLE CONSTRAINT constraint_name
*/

-- FK_CUSTOMER_BANK �������� ��Ȱ��ȭ
ALTER TABLE CUST_T DISABLE CONSTRAINT FK_CUSTOMER_BANK;

-- insert invalid data
INSERT INTO CUST_T VALUES (1, "undefined", "000-0000-0000", "99", "12849");

-- FK_CUSTOMER_BANK �������� Ȱ��ȭ
ALTER TABLE CUST_T ENSABLE CONSTRAINT FK_CUSTOMER_BANK;
-- yields error: delete invalid data or make parent table satisfy constraints
