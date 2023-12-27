-- single line comment
/*
    multiline comment
*/
/*
    sys accounts
    1. 오라클 관리자 계정.
    2. 일반 사용자를 만드는 역할로 국한해서 사용.
    3. 시스 계정으로 일반 쿼리 작업을 수행하지 않도록 주의.
*/
/*
    create new user
    1. execute query statement
       CREATE USER account_name IDENTIFIED BY password;
       * query statement
    2. endow permission
       1) access permission
          GRANT CONNECT TO account_name;
       2) access and usage permission
          GRANT CONNECT, RESOURCE TO account_name;
       3) admin permission
          GRANT DBA to account_name;
	  *** needed in this lecture

    uppercase is default.
*/

/*
    how to execute query statements
    1. put cursor on a statement and press ctrl+enter: only the statement cursor on is executed
    2. put block on statements and press ctrl+enter
    3. press f5: execute whole
*/

--  since version 11, user name must be preceeded by "C##" --

-- create user and give permission
CREATE USER C##GD IDENTIFIED BY epdlxk;
GRANT DBA TO C##GD;

/*
    delete account
    1. case where there is a database object
       DROP USER account_name CASCADE;
    2. case where there is no database object
       DROP USER account_name;
*/

DROP USER C##GD;
