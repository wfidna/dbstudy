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
       ORDER_NO		NUMBER			NOT NULL	PRIMARY KEY,
       MEMBER_ID	VARCHAR2(100 BYTE)	NOT NULL,
       PRODUCT_NO	NUMBER	     		REFERENCES PRODUCT_T (PRODUCT_NO),
       ORDERED_AT	DATE			NOT NULL
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
          basically "basic key", any unique keys

    when is referential integrity violated?
      think about a situation when some member sign out your website.

    solutions?
      1. delete only foreign key (then the items in the child table remain)
       : ON DELETE SET NULL
      2. delete both (delete both items in both table)
       : ON DELETE SET CASCADE
*/

/*
    one to N relationship
    1. most of relationships relating two tables
    2. 1 : N = PK : FK
    3. parent table must be created before creating child table
       - child table must be deleted before deleting parent
*/
