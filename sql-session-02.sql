/*
	DQL: data query language

	����� �����Ϳ� ������ ���� ����
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

-- �μ� ���̺��� ��� Į�� ��ȸ
SELECT DEPT_NO, DEPT_NAME FROM DEPARTMENT_T;
SELECT * FROM DEPARTMENT_T; -- !!!!!!!!!!! �ǹ����� ��� ���� !!!!!!!!!!!!! ���ɿ� ���� ����

SELECT DEPARTMENT_T.DEPT_NO, DEPARTMENT_T.DEPT_NAME, DEPARTMENT_T.LOCALTION FROM DEPARTMENT_T;

SELECT D.DEPT_NO, D.DEPT_NAME, D.LOCALTION FROM DEPARTMENT_T D;

-- �μ� ���̺��� ��� Į�� ��ȸ. ��ȸ Į���� ����: '�μ���ȣ', '�μ���', '��ġ'
SELECT DEPT_NO AS �μ���ȣ,
       DEPT_NAME AS �μ���,
       LOCATION AS ��ġ
   FROM DEPARTMENT_T;

-- �μ� ���̺��� ��ġ Į���� �ߺ� �����Ͽ� ��ȸ
SELECT DISTINCT LOCATION
   FROM DEPARTMENT_T;

SELECT LOCATION
   FROM DEPARTMENT_T
  GROUP BY LOCATION;

/*
	�ֿ� ���ǽ� �ۼ� ���
	1. column = value
	2. column between value1 AND value2
	3. column IN(value1, value2)
	4. column IS NULL
	5. column IS NOT NULL
	6. column LIKE value -- depends on value/whether column value include value
*/

-- �μ� ���̺��� �μ���ȣ�� 1�� �μ� ���� ��ȸ
SELECT *
       FROM DEPARTMENT_T
      WHERE DEPT_NO = 1;

-- �μ� ���̺��� ������ '����'�� �μ� ������ ��ȸ
SELECT *
       FROM DEPARTMENT_T
      WHERE LOCATION = '����'; -- location Į���� unique ���� �ʤ��� ������ ��ȸ ����� �� �� �̻��� �� ����

-- ��� ���̺��� �⺻���� 3000000 �̻��� ��� ��ȸ
SELECT *
       FROM EMPLOYEE_T
      WHERE SALARY > 3000000;

-- ��� ���̺��� �⺻���� 2000000 ~ 3000000 ��� ��ȸ
SELECT *
       FROM EMPLOYEE_T
      WHERE SALARY BETWEEN 2000000 AND 3000000;

-- ��� ���̺��� ������ '���', '����'�� ��� ��ȸ
SELECT *
       FROM EMPLOYEE_T
      WHERE POSITION IN('���', '����');

/*
	WILD CARD: % (any length), _ (single character)
	examples: A%, _A%, %A, %A% ...
*/

-- ��� ���̺��� '��'�� ��ȸ
SELECT *
       FROM EMPLOYEE_T
      WHERE NAME LIKE '��%';

-- ��� ���̺��� 9�� �Ի� ��� ��ȸ
SELECT *
       FROM EMPLOYEE_T
      WHERE HIRE_DATE LIKE '%/09/%';
