CREATE TABLE STUDENT(USN VARCHAR(10) PRIMARY KEY,SNAME VARCHAR(20),ADDRESS VARCHAR(20),PHONE VARCHAR(10),GENDER CHAR(1));
CREATE TABLE SEMSEC(SSID VARCHAR(5) PRIMARY KEY,SEM INTEGER,SEC CHAR(1));
CREATE TABLE CLASS(USN VARCHAR(10),SSID VARCHAR(10),FOREIGN KEY(USN) REFERENCES STUDENT(USN) ON DELETE CASCADE,FOREIGN KEY(SSID) REFERENCES SEMSEC(SSID) ON DELETE CASCADE);
CREATE TABLE SUBJECT(SUBCODE VARCHAR(20) PRIMARY KEY,TITLE VARCHAR(20),SEM INTEGER,CREDITS INTEGER);
CREATE TABLE IAMARKS(USN VARCHAR(10),SUBCODE VARCHAR(20),SSID VARCHAR(5),TEST1 INTEGER,TEST2 INTEGER,TEST3 INTEGER,FINALIA INTEGER,
FOREIGN KEY(USN) REFERENCES STUDENT(USN) ON DELETE CASCADE,
FOREIGN KEY(SSID) REFERENCES SEMSEC(SSID) ON DELETE CASCADE,
FOREIGN KEY(SUBCODE) REFERENCES SUBJECT(SUBCODE) ON DELETE CASCADE
);

INSERT INTO STUDENT VALUES('1BI15CS101','Abhi','tumkur',9875692310,'M');
INSERT INTO STUDENT VALUES('1BI15CS102','amulya','tumkur',9875698210,'F');
INSERT INTO STUDENT VALUES('1BI16ME103','chetan','tumkur',9875698110,'M');
INSERT INTO STUDENT VALUES('1BI14EC104','raghavi','tumkur',9875698430,'F');
INSERT INTO STUDENT VALUES('1BI15EE105','sanjay','tumkur',9875698420,'M');
INSERT INTO STUDENT VALUES('1BI15CS106','Suresh','tumkur',9872698410,'M');

INSERT INTO SEMSEC VALUES('5A',5,'A');
INSERT INTO SEMSEC VALUES('3B',3,'B');
INSERT INTO SEMSEC VALUES('7A',7,'A');
INSERT INTO SEMSEC VALUES('2C',2,'C');
INSERT INTO SEMSEC VALUES('4B',4,'B');
INSERT INTO SEMSEC VALUES('4C',4,'C');

INSERT INTO CLASS VALUES('1BI15CS101','5A');
INSERT INTO CLASS VALUES('1BI15CS102','5A');
INSERT INTO CLASS VALUES('1BI16ME103','3B');
INSERT INTO CLASS VALUES('1BI14EC104','7A');
INSERT INTO CLASS VALUES('1BI15EE105','3B');
INSERT INTO CLASS VALUES('1BI15CS106','4C');

INSERT INTO SUBJECT VALUES('15cs53','DBMS',5,4);
INSERT INTO SUBJECT VALUES('15cs33','DS',3,4);
INSERT INTO SUBJECT VALUES('15cs34','CO',3,4);
INSERT INTO SUBJECT VALUES('15cs158','DBA',5,2);
INSERT INTO SUBJECT VALUES('10cs71','OOMD',7,4);

INSERT INTO IAMARKS VALUES('1BI15CS101','15cs53','5A',18,19,15,19);
INSERT INTO IAMARKS VALUES('1BI15CS102','15cs53','5A',15,16,14,16);
INSERT INTO IAMARKS VALUES('1BI16ME103','15cs33','3B',10,15,16,16);
INSERT INTO IAMARKS VALUES('1BI14EC104','10cs71','7A',18,20,21,21);
INSERT INTO IAMARKS VALUES('1BI15EE105','15cs33','3B',16,20,17,19);
INSERT INTO IAMARKS VALUES('1BI15CS106','15cs53','4C',19,20,18,20);


-- QUERY 1
SELECT S.USN,SNAME,ADDRESS,PHONE,GENDER,SS.SSID
FROM STUDENT S,CLASS C,SEMSEC SS
WHERE S.USN=C.USN AND SS.SSID=C.SSID AND SEC='C' AND SEM=4;

-- QUERY 2
SELECT SEM,SEC,GENDER,COUNT(*)
FROM SEMSEC SS,CLASS C,STUDENT S
WHERE S.USN=C.USN AND SS.SSID=C.SSID
GROUP BY SEM,SEC,GENDER
ORDER BY SEM;

-- QUERY 3
CREATE VIEW TEST1 AS
SELECT SUBCODE,TEST1
FROM IAMARKS
WHERE USN='1BI15CS101';

select * from TEST1;


-- QUERY 4
UPDATE IAMARKS
SET FINALIA=(
CASE
WHEN GREATEST(TEST1,TEST2)=GREATEST(TEST1,TEST3)
Then CEILING (GREATEST(TEST1,TEST3)/2+GREATEST(TEST3,TEST2)/2)
Else CEILING (GREATEST(TEST1,TEST3)/2+GREATEST(TEST1,TEST2)/2)
END);

SELECT * FROM IAMARKS;


-- QUERY 5
SELECT S.USN,SNAME,ADDRESS,GENDER,PHONE,
CASE 
WHEN FINALIA BETWEEN 30 AND 45 THEN 'OUTSTANDING'
WHEN FINALIA BETWEEN 18 AND 29 THEN 'AVERAGE'
ELSE 'WEAK'
END AS CAT
FROM STUDENT S,SEMSEC SS,IAMARKS IA,SUBJECT SUB
WHERE S.USN=IA.USN AND SS.SSID=IA.SSID
AND SUB.SUBCODE=IA.SUBCODE AND SUB.SEM=7;

