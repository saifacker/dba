CREATE TABLE SALESMAN(SALESMAN_ID INT PRIMARY KEY,NAME VARCHAR(20),CITY VARCHAR(20),COMMISSION VARCHAR(20));
CREATE TABLE CUSTOMER(CUSTOMER_ID INT PRIMARY KEY,CUST_NAME VARCHAR(20),CITY VARCHAR(20),GRADE VARCHAR(20),SALESMAN_ID INT references SALESMAN(SALESMAN_ID));
CREATE TABLE ORDERS(ORD_NO INT,PURCHASE_AMT INT,ORD_DATE VARCHAR(20),CUSTOMER_ID INT references CUSTOMER(CUSTOMER_ID),SALESMAN_ID INT references SALESMAN(SALESMAN_ID)); 

INSERT INTO SALESMAN VALUES(1111,'JOHN','BANGALORE','25%');
INSERT INTO SALESMAN VALUES(2222,'RAVI','BANGALORE','20%');
INSERT INTO SALESMAN VALUES(3333,'KUMAR','MYSORE','15%');
INSERT INTO SALESMAN VALUES(4444,'SMITHA','DELHI','30%');
INSERT INTO SALESMAN VALUES(5555,'HARSHA','HYDERABAD','15%');

INSERT INTO CUSTOMER VALUES(11,'PREETI','BANGALORE','100',1111);
INSERT INTO CUSTOMER VALUES(12,'VIVEK','BANGALORE','300',1111);
INSERT INTO CUSTOMER VALUES(13,'BHASKAR','BANGALORE','400',2222);
INSERT INTO CUSTOMER VALUES(14,'CHETAN','BANGALORE','200',2222);
INSERT INTO CUSTOMER VALUES(15,'MAMTA','BANGALORE','400',3333);

INSERT INTO ORDERS VALUES(50,1000,'O4-MAY-17',11,1111);
INSERT INTO ORDERS VALUES(51,2000,'20-JAN-17',11,2222);
INSERT INTO ORDERS VALUES(52,400,'24-FEB-17',14,2222);
INSERT INTO ORDERS VALUES(53,2000,'13-APR-17',15,3333);
INSERT INTO ORDERS VALUES(54,1400,'O9-MAR-17',13,2222);

SELECT * FROM SALESMAN;
SELECT * FROM CUSTOMER;
select * FROM ORDERS;

SELECT GRADE,COUNT(DISTINCT CUSTOMER_ID)
FROM CUSTOMER
group by GRADE
HAVING GRADE>(SELECT AVG(GRADE)
FROM CUSTOMER
WHERE CITY='BANGALORE');

SELECT SALESMAN_ID,NAME 
FROM SALESMAN A
WHERE 1<(SELECT COUNT(*) FROM CUSTOMER
WHERE SALESMAN_ID=A.SALESMAN_ID);

SELECT SALESMAN.SALESMAN_ID,NAME,CUST_NAME,COMMISSION
FROM SALESMAN,CUSTOMER
WHERE SALESMAN.CITY=CUSTOMER.CITY
UNION
SELECT SALESMAN_ID,NAME,'NO MATCH',COMMISSION
FROM SALESMAN
WHERE NOT CITY=ANY(SELECT CITY FROM CUSTOMER)
ORDER BY 1 DESC;

DELETE FROM SALESMAN
WHERE SALESMAN_ID=1111;

SELECT * FROM SALESMAN;