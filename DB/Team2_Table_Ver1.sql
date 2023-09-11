-- 테이블 드랍
DROP TABLE PLACE_ALL; --모든관광지
DROP TABLE MEMBER; --유저
DROP TABLE P_CONNECT; --총접속
DROP TABLE PLACE_REVIEW; --관광지후기
DROP TABLE PLACE_SELECT; --선택한관광지
DROP TABLE PLANNER; --플래너
DROP TABLE PP_HISTORY; --기록
DROP TABLE TRAVEL_LOCATION; --여행위치

-- 테이블 생성
CREATE TABLE PLACE_ALL( --모든관광지
    PA_NUM NUMBER NOT NULL PRIMARY KEY, --관광지번호 시퀀스
    PA_NAME VARCHAR2(30 CHAR), --관광지이름
    PA_LOCATION VARCHAR2(60 CHAR), --관광지위치 제주시 땡땡동,읍,면 333-33
    PA_CON VARCHAR2(500 CHAR), --관광지설명
    PA_PRICE NUMBER --관광지금액
    );
    

CREATE TABLE PLACE_SELECT( -- 선택한관광지
    PA_NUM NUMBER, --관광지번호 PK&FK 
    PLAN_NUM NUMBER,  --플래너번호 PK&FK 
    PS_DAY NUMBER, --관광날짜
    PS_TIME DATE, --관광시간
    PS_CON VARCHAR2(500 CHAR), --관광메모
    CONSTRAINT PLACE_SELECT PRIMARY KEY(PA_NUM, PLAN_NUM)
    );
    
CREATE TABLE PLANNER( -- 플래너
    PLAN_NUM NUMBER NOT NULL PRIMARY KEY, --플래너번호 시퀀스
    PLAN_TITLE VARCHAR2(50 CHAR), -- 플래너제목
    PLAN_DATE DATE, --여행날짜
    PLAN_DAYS NUMBER, --여행기간 1~7만 입력가능
    M_ID VARCHAR2(15 CHAR), --아이디 FK
    TL_NUM NUMBER  --위치번호 FK
    );

CREATE TABLE TRAVEL_LOCATION( --여행위치
    TL_NUM NUMBER NOT NULL PRIMARY KEY, -- 위치번호 시퀀스
    CITY VARCHAR2(30 CHAR), --시
    TOWN VARCHAR2(20 CHAR) --동읍리
    );

CREATE TABLE MEMBER (  --유저
    M_ID VARCHAR2(15 CHAR) NOT NULL PRIMARY KEY,  --아이디
    M_PW VARCHAR2(18 CHAR),  --비밀번호
    M_NAME VARCHAR2(10 CHAR),  --이름
    M_BIRTH DATE,  --생년월일 1998-04-26 
    M_EMAIL VARCHAR2(40 CHAR),  --이메일 dkdlel10111@gmail.com
    M_PHONE NUMBER,  --전화번호 01051283539 숫자만입력
    M_TERMS VARCHAR2(3 CHAR),  --약관동의 동의/비동의
    M_CLASS NUMBER,  --등급 0=관리자 1=일반유저 4=탈퇴유저
    M_LASTLOGIN DATE, --마지막접속날짜 sysdate
    DELETE_CON VARCHAR2(200 CHAR), --탈퇴사유
    DELETE_TIME DATE --탈퇴시간
    );
    
CREATE TABLE PLACE_REVIEW(  --관광지후기
    PR_RATING NUMBER(2,1),  --관광지평점 0.0~5.0
    PR_CON VARCHAR2(100 CHAR),  --후기내용
    M_ID  VARCHAR2(15 CHAR),  --아이디 FK
    PA_NUM NUMBER  --관광지번호 FK
    );

CREATE TABLE P_CONNECT(  --접속
    CONNECT_ALL NUMBER NOT NULL PRIMARY KEY  --총접속(처음시작할때 무조건 카운트)
    );
    
CREATE TABLE PP_HISTORY(  --기록
    HISTORY_NUM NUMBER NOT NULL PRIMARY KEY,  --기록번호
    HISTORY_VICTIM VARCHAR2(15 CHAR),  --피해자
    HISTORY_SUSPECT VARCHAR2(15 CHAR),  --피의자
    HISTORY_CON VARCHAR2(30 CHAR),  --기록내용
    HISTORY_TIME DATE -- 기록시간
    );
    
    
    --외래키 주기
ALTER TABLE PLACE_SELECT
ADD CONSTRAINT FK_PA_NUM FOREIGN KEY(PA_NUM) REFERENCES PLACE_ALL(PA_NUM);

ALTER TABLE PLACE_SELECT
ADD CONSTRAINT FK_PLAN_NUM FOREIGN KEY(PLAN_NUM) REFERENCES PLANNER(PLAN_NUM);

ALTER TABLE PLANNER
ADD CONSTRAINT FK_M_ID FOREIGN KEY(M_ID) REFERENCES MEMBER(M_ID);

ALTER TABLE PLANNER
ADD CONSTRAINT FK_TL_NUM FOREIGN KEY(TL_NUM) REFERENCES TRAVEL_LOCATION(TL_NUM);


-- FK_이름 중복오류
ALTER TABLE PLACE_REVIEW
ADD CONSTRAINT FK_M_ID_REVIEW FOREIGN KEY(M_ID) REFERENCES MEMBER(M_ID);

ALTER TABLE PLACE_REVIEW
ADD CONSTRAINT FK_PA_NUM_REVIEW FOREIGN KEY(PA_NUM) REFERENCES PLACE_ALL(PA_NUM);

-- 시퀀스
CREATE SEQUENCE PA_NUM_SEQ INCREMENT BY 1 START WITH 1 MINVALUE 1 MAXVALUE 9999 NOCYCLE NOCACHE NOORDER;
CREATE SEQUENCE PLAN_NUM_SEQ INCREMENT BY 1 START WITH 1 MINVALUE 1 MAXVALUE 9999 NOCYCLE NOCACHE NOORDER;
CREATE SEQUENCE TL_NUM_SEQ INCREMENT BY 1 START WITH 1 MINVALUE 1 MAXVALUE 9999 NOCYCLE NOCACHE NOORDER;
CREATE SEQUENCE HISTORY_NUM_SEQ INCREMENT BY 1 START WITH 1 MINVALUE 1 MAXVALUE 9999 NOCYCLE NOCACHE NOORDER;
CREATE SEQUENCE DM_NUM_SEQ INCREMENT BY 1 START WITH 1 MINVALUE 1 MAXVALUE 9999 NOCYCLE NOCACHE NOORDER;
CREATE SEQUENCE CONNECT_ALL_SEQ INCREMENT BY 1 START WITH 1 MINVALUE 1 MAXVALUE 9999 NOCYCLE NOCACHE NOORDER;

-- INSERT
INSERT INTO MEMBER
VALUES('root','1111', '관리자', '19910405','admin@gmail.com',01012345678,'yes',0, sysdate,null,null);
INSERT INTO MEMBER 
VALUES('shl','1111', '이수환', '19980415','shlee8405@gmail.com',01076482257,'yes',0,'20230623',null,null);
INSERT INTO MEMBER
VALUES('kjun','1111', '권연준', '19980405','kjun@gmail.com',01033382257,'yes',1,'20230622',null,null);
INSERT INTO MEMBER
VALUES('jayk','1111', '김지수', '19920405','kjs@gmail.com',01031234357,'yes',1,'20230623',null,null);
INSERT INTO MEMBER
VALUES('lily','1111', '김민지', '19910405','kmj@gmail.com',01032313257,'yes',1,'20230623',null,null);
INSERT INTO MEMBER
VALUES('cindy','1111', '김신실', '19910405','kss@gmail.com',01032313257,'yes',1,'20230623',null,null);
INSERT INTO MEMBER
VALUES('princess','1111', '소앵', '19910405','soangrybird@gmail.com',01032313257,'yes',1,'20230623',null,null);
INSERT INTO MEMBER
VALUES('del','1111', '탈퇴유저', '19910405','soangrybird@gmail.com',01032313257,'yes',4,'20230623',null,null);

INSERT INTO PLACE_ALL
VALUES(1,'두물머리해수욕장','서귀포','군부대옆에있는해수욕장',20000);
INSERT INTO PLACE_ALL
VALUES(2,'중국성','휘포리','자장면이 맛있는 중국집',10000);
INSERT INTO PLACE_ALL
VALUES(3,'과테말라카페','서귀포','과테말라 안티구아 커피가 맛있는 카페',2000);

INSERT INTO PLACE_REVIEW
VALUES(5,'진짜 너무너무 좋네요!!!', 'shlee8405',3);
INSERT INTO PLACE_REVIEW
VALUES(1,'별루', 'shlee8405',1);
INSERT INTO PLACE_REVIEW
VALUES(2,'커피가 비림; 가지마셈', 'kjs0000',3);

COMMIT;