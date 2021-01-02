-- 20.12.30 Oracle DDL, DML, DCL --

-- [VII] DDL, DML, DCL
/*
 SQL = DDL(���̺�����, ����, ��������, ���̺� ����������)
       DML(SELECT, INSERT, UPDATE, DELETE)
       DCL(����ڰ�������, ����ڿ��Ա��Ѻο�, ���ѹ�Ż, Ʈ�����Ǹ��ɾ�)
*/

--  DDL  --

-- 1. ���̺� ���� (CREATE TABLE)
CREATE TABLE BOOK(
    BOOKID    NUMBER(4),   -- ������ȣ
    BOOKNAME  VARCHAR2(20),-- �����̸�
    PUBLISHER VARCHAR2(20),-- ���ǻ�
    RDATE     DATE,        -- ������
    PRICE     NUMBER(8),   -- ����
    PRIMARY KEY(BOOKID)-- ���̺� �� ��Ű(PRIMARY KEY) = ����, NOT NULL
);

DROP TABLE BOOK; -- BOOK ���̺� ����

CREATE TABLE BOOK(
    BOOKID    NUMBER(4) PRIMARY KEY,
    BOOKNAME  VARCHAR2(20),
    PUBLISHER VARCHAR2(20),
    RDATE     DATE,
    PRICE     NUMBER(8)
);

SELECT * FROM BOOK;

-- EMP�� ������ EMP01 : EMPNO(����4), ENAME(����-20), SAL(����7,2)
CREATE TABLE EMP01(
    EMPNO NUMBER(4),
    ENAME VARCHAR2(20),
    SAL   NUMBER(7,2)
);
SELECT * FROM EMP01;
DESC EMP01;

-- DEPT01 - DEPTNO(����2), DNAME(����14), LOC(����13)
CREATE TABLE DEPT01(
    DEPTNO NUMBER(2),
    DNAME VARCHAR2(14),
    LOC VARCHAR2(13)
);

SELECT * FROM DEPT01;

-- ���������� �̿��� ���̺� ����
CREATE TABLE EMP02
    AS
    SELECT * FROM EMP; --�������� ����� EMP02(���������� ������)
SELECT * FROM EMP02;
INSERT INTO EMP02 (EMPNO, ENAME, DEPTNO) VALUES (7369, 'HONG', 90);

-- EMP03 ; EMP���̺����� EMPNO, ENAME, DEPTNO�� ����
CREATE TABLE EMP03
    AS
    SELECT EMPNO, ENAME, DEPTNO FROM EMP;
SELECT * FROM EMP03;

-- EMP04 ; EMP���̺����� 10�� �μ��� ����
CREATE TABLE EMP04
    AS
    SELECT * FROM EMP WHERE DEPTNO=10;
SELECT * FROM EMP04;

-- EMP05 ; EMP���̺��� ������ ����
CREATE TABLE EMP05
    AS
    SELECT * FROM EMP WHERE 1=0;
SELECT * FROM EMP05;


-- 2. ���̺� ���� ���� (ALTER TABLE)
-- ALTER TABLE ���̺� ��
-- ADD || MODIFY || DROP ~

--(1) �ʵ� �߰� (ADD)
SELECT * FROM EMP03;
ALTER TABLE EMP03 ADD (JOB VARCHAR2(10), SAL NUMBER(7,2));
SELECT * FROM EMP03;
ALTER TABLE EMP03 ADD (MGR NUMBER(4));

--(2) �ʵ� Ÿ�� ���� (MODIFY)
ALTER TABLE EMP03 MODIFY(EMPNO VARCHAR2(5)); -- ���ڵ����Ͱ� ����ִ� ����
ALTER TABLE EMP03 MODIFY(JOB VARCHAR2(5)); -- NULL�̸� �� �ٲ�
ALTER TABLE EMP03 MODIFY(ENAME VARCHAR2(200));
ALTER TABLE EMP03 MODIFY(ENAME VARCHAR2(5));--6byte�ڷ� �־� �Ұ�

--(3) �ʵ� ���� (DROP)
SELECT * FROM EMP03;
ALTER TABLE EMP03 DROP COLUMN JOB;
SELECT * FROM EMP03;
ALTER TABLE EMP03 DROP COLUMN DEPTNO; -- ������ ���� �Ұ�
SELECT * FROM EMP03;

-- ���������� Ư�� �ʵ带 ���� ���ϵ��� (��)
ALTER TABLE EMP03 SET UNUSED (SAL);
SELECT * FROM EMP03;

-- ���������� ���� �Ұ��ߴ� �ʵ带 ����(����)
ALTER TABLE EMP03 DROP UNUSED COLUMNS; -- ������ ������ ���̺� �׼��� �Ұ�

-- 3. ���̺� ����(DROP TABLE)
DROP TABLE EMP01;
SELECT * FROM EMP01;
DROP TABLE DEPT; -- �ٸ� ���̺����� �����ϴ� �����Ͱ� ���� ��� DROP �Ұ�

-- 4. ���̺� ���� ������ �� �� ����(TRUNCATE TABLE)
SELECT * FROM EMP02;
TRUNCATE TABLE EMP02; -- DDL���ɾ�� ��� �Ұ�

-- 5. ���̺� �̸� ����(RENAME)
SELECT * FROM EMP03;
RENAME EMP03 TO EMP3; -- EMP03�� EMP3���� ���̺� �̸� ����

-- 6. �����͵�ųʸ�(���ٺҰ�) -> �����͵�ųʸ���(����� ���ٿ�)
/*
  DBA_TABLES, DBA_INDEXES, DBA_CONSTRAINTS, DBA_VIEWS;
  USER_TABLES, USER_INDEXES, USER_CONSTRAINTS, USER_VIEWS;
  ALL_TABLES, ALL_INDEXES, ALL_CONSTRAINTS, ALL_VIEWS;
*/

-- USER_xxx ; SCOTT�� ������ ��ü(���̺�, �ε���, ..) ���� ��ȸ
SHOW USER;
SELECT * FROM USER_TABLES;
SELECT * FROM USER_INDEXES;
SELECT * FROM USER_CONSTRAINTS;
SELECT * FROM USER_VIEWS;
DROP TABLE BOOK;
CREATE TABLE BOOK(
    BOOKID NUMBER(4) CONSTRAINT BP PRIMARY KEY,
    BOOKNAME VARCHAR2(100),
    PUBLISHER VARCHAR2(100),
    RDATE     DATE,
    PRICE     NUMBER(8)
);

-- DBA_xxx ; DBA������ ���� ����ڸ� ���� ������ ��ü ����
SELECT TABLE_NAME, OWNER FROM DBA_TABLES;
SELECT * FROM DBA_INDEXES;
SELECT * FROM DBA_CONSTRAINTS;
SELECT * FROM DBA_VIEWS;

-- ALL_xxx ; SCOTT�� ������ ��ü�� ������ �ο��� ��ü
SELECT * FROM ALL_TABLES;
SELECT * FROM ALL_CONSTRAINTS;
SELECT * FROM ALL_INDEXES;
SELECT * FROM ALL_VIEWS;


-- DML --

-- 7. DML ; SELECT, INSERT, UPDATE, DELETE
/*
 (1) INSERT INTO ���̺��̸� (�ʵ��1, �ʵ��2, ..)
               VALUES (��1, ��2, ...);
     INSERT INTO ���̺��̸� VALUES (��1, ��2, ...);
*/

SELECT * FROM DEPT01;

INSERT INTO DEPT01 (DEPTNO, DNAME, LOC) 
    VALUES (10, 'ACCOUNTING','NEW YORK');
    
INSERT INTO DEPT01 (DNAME, LOC, DEPTNO)
    VALUES ('SALES', 'BOSTON', 20);
    
INSERT INTO DEPT01 (DEPTNO, DNAME, LOC)
    VALUES (30, 'IT', NULL);
    
-- NULL�� �Է��� �Է����� ������ NULL�� �ڵ� �Է�
INSERT INTO DEPT01 (DEPTNO, DNAME) VALUES (40, 'OPERATION');
SELECT * FROM DEPT01;

-- INSERT������ �ʵ�� ������ �ݵ�� 3�� �ʵ尪�� �� �;� ��.
INSERT INTO DEPT01 VALUES (50, '����','����');
SELECT * FROM DEPT01;
DESC DEPT01; -- PK ���� DEPT01

-- DEPT01���̺��� DEPT���̺� 10~30���μ����� ������ INSERT
INSERT INTO DEPT01 SELECT * FROM DEPT WHERE DEPTNO<40;
SELECT * FROM DEPT01;

-- BOOK���̺��� 11��, '����������', �Ѽ�����, ������ ����, ������ 90000
SELECT * FROM BOOK;
INSERT INTO BOOK (BOOKID, BOOKNAME, PUBLISHER, RDATE, PRICE)
    VALUES (11, '����������', '�Ѽ�����', SYSDATE, 90000);
INSERT INTO BOOK VALUES (11,'����������','�Ѽ�����',SYSDATE,90000);

-- Ʈ������ ���ɾ�
COMMIT; -- DML ���ɾ�� Ʈ����� ������ ����. �� Ʈ�������� �۾��� �ݿ�
ROLLBACK; -- Ʈ������ �ȿ� �ִ� DML ���ɾ ���

-- PPT p.2 ��������
DROP TABLE SAM01;
CREATE TABLE SAM01(
    EMPNO NUMBER(4) CONSTRAINT C_SAM PRIMARY KEY,
    ENAME VARCHAR2(10),
    JOB VARCHAR2(9),
    SAL NUMBER(7,2));
    
SELECT * FROM USER_CONSTRAINTS;

DROP TABLE SAM01;

CREATE TABLE SAM01(
    EMPNO NUMBER(4) PRIMARY KEY,
    ENAME VARCHAR2(10),
    JOB VARCHAR2(9),
    SAL NUMBER(7,2));
    
SELECT * FROM USER_CONSTRAINTS;

DROP TABLE SAM01;

CREATE TABLE SAM01(
    EMPNO NUMBER(4),
    ENAME VARCHAR2(10),
    JOB VARCHAR2(9),
    SAL NUMBER(7,2),
    PRIMARY KEY(EMPNO));
    
INSERT INTO SAM01 (EMPNO, ENAME, JOB, SAL) 
    VALUES (1000,'APPLE','POLICE',10000);
    
INSERT INTO SAM01 VALUES (1010,'BANANA','NURSE',15000);

INSERT INTO SAM01 VALUES (1020,'ORANGE','DOCTOR',25000);

INSERT INTO SAM01 (EMPNO, ENAME, SAL) VALUES (1030,'VERY',25000);

INSERT INTO SAM01 VALUES (1040,'CAT',NULL, 2000);

INSERT INTO SAM01 
    SELECT EMPNO, ENAME, JOB, SAL FROM EMP WHERE DEPTNO=10;
    
SELECT * FROM SAM01;

-- (2) UPDATE ���̺��̸� SET �ʵ��1=��1[, �ʵ��2=��2,...] [WHERE ����];
DROP TABLE EMP01;

CREATE TABLE EMP01
    AS SELECT * FROM EMP;
    
SELECT * FROM EMP01;

-- �μ���ȣ�� 30���� ����
UPDATE EMP01 SET DEPTNO=30;
SELECT * FROM EMP01;

-- ��� ������ �޿��� 10%�λ��Ͻÿ�
UPDATE EMP01 SET SAL=SAL*1.1;
SELECT * FROM EMP01;
COMMIT;

-- Ư�� ���� �����͸� �����ϰ��� �� ���� WHERE �� �߰�
-- 10�� �μ� ������ �Ի����� ���÷�, �μ���ȣ�� 30�� �μ��� ����
UPDATE EMP01 SET HIREDATE=SYSDATE, DEPTNO=30
    WHERE DEPTNO=10;
SELECT * FROM EMP01;

-- SAL�� 3000�̻��� ����� �޿��� 10%�λ��Ͻÿ�
UPDATE EMP01 SET SAL=SAL*1.1 WHERE SAL>=3000;

--  'DALLAS'�� �ٺ��ϴ� �������� �޿��� 1000�λ�.
UPDATE EMP01 SET SAL=SAL+1000
    WHERE DEPTNO=(SELECT DEPTNO FROM DEPT WHERE LOC='DALLAS');
    
-- SCOTT����� �μ���ȣ�� 20���� JOB�� MANAGER�� �����ϴ� SQL
UPDATE EMP01 SET JOB='MANAGER',DEPTNO=20
    WHERE ENAME='SCOTT';
SELECT * FROM EMP01 WHERE ENAME='SCOTT';

-- SCOTT����� �Ի����� ���÷�, �޿��� 50, COMM�� 400 ����
UPDATE EMP01 SET HIREDATE=SYSDATE, SAL=50, COMM=400
    WHERE ENAME='SCOTT';
    
-- ���������� �̿��� UPDATE��
-- DEPT01���� 20������ �������� 40�� �μ��� ���������� ����
SELECT * FROM DEPT01;
UPDATE DEPT01 SET LOC='����' WHERE DEPTNO=40;

UPDATE DEPT01 SET DNAME=(SELECT DNAME FROM DEPT01 
                        WHERE DEPTNO=40)
                WHERE DEPTNO=20;
                
-- DEPT01���� 20������ �������� 40�� �μ��� �μ���, ���������� ����
UPDATE DEPT01 SET (DNAME,LOC)=(SELECT DNAME, LOC FROM DEPT01 
                        WHERE DEPTNO=40)
                WHERE DEPTNO=20;
                
SELECT * FROM DEPT01 WHERE DEPTNO IN (20,40);

-- EMP01���̺��� ��� ����� �޿��� �Ի����� 'KING'�� �޿��� �Ի��Ϸ� ����
UPDATE EMP01 SET (SAL, HIREDATE)=(SELECT SAL, HIREDATE FROM EMP01
                               WHERE ENAME='KING');
                               
-- cf. UPDATE ���̺��� SET �ʵ��=��, �ʵ��=��...
-- (3) DELETE FROM ���̺��� WHERE ����;
commit;

SELECT * FROM EMP01;

DELETE FROM EMP01;

ROLLBACK;

-- EMP01���̺����� 30�μ� ������ ����
DELETE FROM EMP01 WHERE DEPTNO=30;

-- SAM01���̺����� JOB�� �������� �ʴ� ����� ����
SELECT * FROM SAM01;

DELETE FROM SAM01 WHERE JOB IS NULL;

-- EMP01���̺����� �μ����� SALES�� ����� ����
DELETE FROM EMP01 
    WHERE DEPTNO=(SELECT DEPTNO FROM DEPT WHERE DNAME='SALES');
    
-- EMP01���̺����� RESEARCH �μ� �Ҽ��� ��� ����
DELETE FROM EMP01
    WHERE DEPTNO=(SELECT DEPTNO FROM DEPT WHERE DNAME='RESEARCH');
    
    
-- PPT P.1 �������� -- 

--1. ���̺� ����
DROP TABLE MY_DATA;
CREATE TABLE MY_DATA(
    ID NUMBER(4) PRIMARY KEY,
    NAME VARCHAR2(10),
    USERID VARCHAR2(30),
    SALARY NUMBER(10,2));
    
--2. ������ �Է�
INSERT INTO MY_DATA (ID, NAME, USERID, SALARY)
  VALUES (1, INITCAP('SCOTT'), 'sscott',10000.00);
INSERT INTO MY_DATA VALUES (2, 'Ford', 'fford',13000.00);
INSERT INTO MY_DATA 
  VALUES (3, 'Patel', 'ppatel',TO_NUMBER('33,000.00','99,999.99'));
INSERT INTO MY_DATA 
  VALUES (4,'Report','rreport',TO_NUMBER('23,500.00','00,000.00'));
INSERT INTO MY_DATA 
  VALUES (5, 'Good', 'ggood',TO_NUMBER('44,450.00','99,999.99'));
  
-- 3. �Է��� �ڷ� Ȯ��
SELECT * FROM MY_DATA;
SELECT ID, NAME, USERID, TO_CHAR(SALARY, '99,999.00') SALARY
    FROM MY_DATA;
    
-- 4. Ʈ������ �۾� �ݿ�
COMMIT;

-- 6.
UPDATE MY_DATA SET SALARY=65000.0 WHERE ID=3;
UPDATE MY_DATA SET SALARY=TO_NUMBER('65,000.00','99,999.99') 
    WHERE ID=3;
COMMIT;

-- 7. Ford ���� ����
DELETE FROM MY_DATA WHERE NAME='Ford';
DELETE FROM MY_DATA WHERE INITCAP(NAME)='Ford';
COMMIT;

-- 8. 
UPDATE MY_DATA SET SALARY = 15000
    WHERE SALARY <= 15000;

-- 9.
DROP TABLE MY_DATA;

