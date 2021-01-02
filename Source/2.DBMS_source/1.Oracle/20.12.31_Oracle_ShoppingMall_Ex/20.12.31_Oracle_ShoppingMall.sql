-- 20.12.31 Oracle 쇼핑몰 마켓 DB 만들기 실습


-- 1. CUSTOMER TABLE 생성

DROP TABLE CUSTOMER; -- TABLE 생성 전 겹치는 테이블 삭제

CREATE TABLE CUSTOMER (
    cID         VARCHAR2(10),
    cNAME       VARCHAR2(50)  NOT NULL,    
    cTEL        VARCHAR2(30)  UNIQUE,
    cADDRESS    VARCHAR2(255) NOT NULL,
    cEMAIL      VARCHAR2(40)  UNIQUE,
    
    PRIMARY KEY (cID)
);

SELECT * FROM CUSTOMER; -- TABLE 생성 확인

-- KEY IN
INSERT INTO CUSTOMER (cID, cNAME, cTEL, cADDRESS, cEMAIL)
    VALUES ('ABC','홍길동','010-1111-1111','서울 마포구','ABC@GMAIL.COM');

INSERT INTO CUSTOMER (cID, cNAME, cTEL, cADDRESS, cEMAIL)
    VALUES ('DEF','김길동','010-2222-2222','서울 서대문구','DEF@GMAIL.COM');

INSERT INTO CUSTOMER (cID, cNAME, cTEL, cADDRESS, cEMAIL)
    VALUES ('GHY','이길동','010-3333-3333','경기도 고양시','GHY@GMAIL.COM');

SELECT * FROM CUSTOMER; -- TABLE KEY IN 확인


-- 2. GOODS TABLE 생성

DROP TABLE GOODS; -- TABLE 생성 전 겹치는 테이블 삭제
    
CREATE TABLE GOODS (
    gCODE       VARCHAR2(10),
    gNAME       VARCHAR2(50)  UNIQUE,
    gPRICE      NUMBER(10)    NOT NULL,
    gSTOCK      NUMBER(5)     NOT NULL,
    
    PRIMARY KEY(gCODE) 
);

SELECT * FROM GOODS; -- TABLE 생성 확인

-- TABLE KEY IN
INSERT INTO GOODS (gCODE, gNAME, gPRICE, gSTOCK)
    VALUES ('A1','맥주', 2000, 1000);
    
INSERT INTO GOODS (gCODE, gNAME, gPRICE, gSTOCK)
    VALUES ('A2','소주', 1500, 1000);
    
INSERT INTO GOODS (gCODE, gNAME, gPRICE, gSTOCK)
    VALUES ('B1','땅콩', 3000, 1500);

INSERT INTO GOODS (gCODE, gNAME, gPRICE, gSTOCK)
    VALUES ('B2','오징어', 5000, 2000);

INSERT INTO GOODS (gCODE, gNAME, gPRICE, gSTOCK)
    VALUES ('C1','기저귀', 7000, 8000);

INSERT INTO GOODS (gCODE, gNAME, gPRICE, gSTOCK)
    VALUES ('C2','분유', 10000, 5000);

SELECT * FROM GOODS; -- KEY IN 확인


-- 3. BASKET TABLE 생성 (bNUM SEQUENCE 생성)

DROP TABLE BASKET; -- TABLE 생성 전 겹치는 테이블 삭제
    
CREATE TABLE BASKET (
    bNUM        NUMBER(10), 
    cID         VARCHAR2(10) NOT NULL,
    gCODE       VARCHAR2(10) NOT NULL,
    QTY         NUMBER(10)   NOT NULL,
    COST        NUMBER(10)   NOT NULL,
    
    PRIMARY KEY(bNUM),
    FOREIGN KEY(cID)   REFERENCES CUSTOMER(cID),
    FOREIGN KEY(gCODE) REFERENCES GOODS(gCODE)
);

SELECT * FROM BASKET;       -- BASKET TABLE 생성 확인

DROP TABLE BASKET_SEQ;      -- TABLE 생성 전 겹치는 테이블 삭제

CREATE SEQUENCE BASKET_SEQ  -- SEQUENCE로 BASKET 번호를 자동생성
    MAXVALUE 999999 NOCYCLE NOCACHE;

-- TABLE KEY IN --

-- ID 'ABC' 고객 주문 1.
INSERT INTO BASKET (bNUM, cID, gCODE, QTY, COST)
    VALUES (BASKET_SEQ.NEXTVAL, 'ABC', 'A1', 3, 6000);

INSERT INTO BASKET
    VALUES (BASKET_SEQ.NEXTVAL, 'ABC', 'B1', 1, 3000);

INSERT INTO BASKET 
    VALUES (BASKET_SEQ.NEXTVAL, 'ABC', 'A2', 2, 3000);
    
INSERT INTO BASKET 
    VALUES (BASKET_SEQ.NEXTVAL, 'ABC', 'B2', 1, 5000);

-- ID 'DEF'고객 주문   
INSERT INTO BASKET (bNUM, cID, gCODE, QTY, COST)
    VALUES (BASKET_SEQ.NEXTVAL, 'DEF', 'A2', 2, 3000);

INSERT INTO BASKET
    VALUES (BASKET_SEQ.NEXTVAL, 'DEF', 'B2', 1, 5000);

INSERT INTO BASKET 
    VALUES (BASKET_SEQ.NEXTVAL, 'DEF', 'C1', 1, 7000);

-- ID 'ABC' 고객주문 2.
INSERT INTO BASKET (bNUM, cID, gCODE, QTY, COST)
    VALUES (BASKET_SEQ.NEXTVAL, 'ABC', 'A1', 3, 6000);

INSERT INTO BASKET
    VALUES (BASKET_SEQ.NEXTVAL, 'ABC', 'B1', 1, 3000);

INSERT INTO BASKET 
    VALUES (BASKET_SEQ.NEXTVAL, 'ABC', 'C1', 1, 7000);
    
SELECT * FROM BASKET; -- TABLE KEY IN 확인 


-- 4. ORDER TABLE 생성

DROP TABLE ORDER_INFO;  -- TABLE 생성 전 겹치는 테이블 삭제

CREATE TABLE ORDER_INFO (
    oiNUM           NUMBER(10),
    cID             VARCHAR2(10)  NOT NULL,         
    oADDRESS        VARCHAR2(255) NOT NULL,
    oTEL            VARCHAR2(30)  NOT NULL,
    oDATE           DATE          NOT NULL,
    
    PRIMARY KEY(oiNUM),
    FOREIGN KEY(cID) REFERENCES CUSTOMER(cID) 
);

SELECT * FROM ORDER_INFO;  -- TABLE 생성 확인

-- TABLE KEY IN --

-- ID 'ABC' 고객 주문 1.
INSERT INTO ORDER_INFO (oiNUM, cID, oADDRESS, oTEL, oDATE)
    VALUES (20122701, 'ABC', '서울 마포구', '010-1111-1111', SYSDATE);

--  ID 'DEF' 고객주문
INSERT INTO ORDER_INFO (oiNUM, cID, oADDRESS, oTEL, oDATE)
    VALUES (20122702, 'DEF', '서울 서대문구', '010-2222-2222', SYSDATE);

-- ID 'ABC' 고객주문 2.
INSERT INTO ORDER_INFO (oiNUM, cID, oADDRESS, oTEL, oDATE)
    VALUES (20123001, 'ABC', '경기도 과천', '02-716-1006', SYSDATE);
    
SELECT * FROM ORDER_INFO; -- TABLE KEY IN 확인


-- 5. ORDER_LIST TABLE 생성

DROP TABLE ORDER_LIST; -- TABLE 생성 전 겹치는 테이블 삭제

CREATE TABLE ORDER_LIST (
    olNUM       NUMBER(6),
    oiNUM       NUMBER(10)   NOT NULL,
    gCODE       VARCHAR2(10) NOT NULL,
    QTY         NUMBER(5)    NOT NULL,
    COST        NUMBER(10)   NOT NULL,
    
    PRIMARY KEY(olNUM),
    FOREIGN KEY(oiNUM)  REFERENCES ORDER_INFO(oiNUM),
    FOREIGN KEY(gCODE)  REFERENCES GOODS(gCODE)
);

SELECT * FROM ORDER_LIST; -- TABLE 생성 확인

DROP SEQUENCE ORDER_LIST_SEQ; -- TABLE 생성 전 겹치는 테이블 삭제

CREATE SEQUENCE ORDER_LIST_SEQ -- SEQUENCE로 ORDER_LIST 번호를 자동생성
    MAXVALUE 999999 NOCYCLE NOCACHE;
    
-- TABLE KEY IN

-- ID 'ABC' 고객주문 1.
INSERT INTO ORDER_LIST (olNUM, oiNUM, gCODE, QTY, COST)
    VALUES (ORDER_LIST_SEQ.NEXTVAL, 20122701, 'A1', 3, 6000);
    
INSERT INTO ORDER_LIST (olNUM, oiNUM, gCODE, QTY, COST)
    VALUES (ORDER_LIST_SEQ.NEXTVAL, 20122701, 'B1', 1, 3000);

INSERT INTO ORDER_LIST (olNUM, oiNUM, gCODE, QTY, COST)
    VALUES (ORDER_LIST_SEQ.NEXTVAL, 20122701, 'A2', 2, 3000);

INSERT INTO ORDER_LIST (olNUM, oiNUM, gCODE, QTY, COST)
    VALUES (ORDER_LIST_SEQ.NEXTVAL, 20122701, 'B2', 1, 5000);

-- ID 'DEF' 고객주문
INSERT INTO ORDER_LIST (olNUM, oiNUM, gCODE, QTY, COST)
    VALUES (ORDER_LIST_SEQ.NEXTVAL, 20122702, 'A2', 2, 3000);

INSERT INTO ORDER_LIST (olNUM, oiNUM, gCODE, QTY, COST)
    VALUES (ORDER_LIST_SEQ.NEXTVAL, 20122702, 'B2', 1, 5000);
    
INSERT INTO ORDER_LIST (olNUM, oiNUM, gCODE, QTY, COST)
    VALUES (ORDER_LIST_SEQ.NEXTVAL, 20122702, 'C1', 1, 7000);

-- ID 'ABC' 고객주문 2.
INSERT INTO ORDER_LIST (olNUM, oiNUM, gCODE, QTY, COST)
    VALUES (ORDER_LIST_SEQ.NEXTVAL, 20123001, 'A1', 3, 6000);

INSERT INTO ORDER_LIST (olNUM, oiNUM, gCODE, QTY, COST)
    VALUES (ORDER_LIST_SEQ.NEXTVAL, 20123001, 'B1', 3, 3000);

INSERT INTO ORDER_LIST (olNUM, oiNUM, gCODE, QTY, COST)
    VALUES (ORDER_LIST_SEQ.NEXTVAL, 20123001, 'C1', 3, 7000);

SELECT * FROM ORDER_LIST; -- TABLE KEY IN 확인
    
COMMIT; -- 생성된 모든자료 DB에 저장






    