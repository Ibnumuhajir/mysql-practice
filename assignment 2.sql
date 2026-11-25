#1
CREATE DATABASE SALE;
USE SALE;
CREATE TABLE CUSTOMER(CUSTOMER_ID INT AUTO_INCREMENT PRIMARY KEY,FULL_NAME VARCHAR(50) NOT NULL,EMAIL VARCHAR(50) UNIQUE NOT NULL,PHONE INT UNIQUE,AGE INT CHECK(AGE>=18),CITY VARCHAR(50) DEFAULT 'KOCHI');
CREATE TABLE PRODUCT(PRODUCT_ID INT AUTO_INCREMENT PRIMARY KEY,PRODUCT_NAME VARCHAR(50) NOT NULL,SERIAL_NUMBER INT UNIQUE,BRAND VARCHAR(50) DEFAULT 'DELL',PRICES INT CHECK(PRICES>0),STOCK_QTY INT CHECK(STOCK_QTY>0));
CREATE TABLE SALES_ORDER(ORDER_ID INT AUTO_INCREMENT PRIMARY KEY,CUSTOMER_ID INT NOT NULL,ORDER_DATE DATE DEFAULT (CURRENT_DATE()),STATUS VARCHAR(50) DEFAULT 'PENDING' CHECK(STATUS IN ('PENDING','SHIPPED','DELIVERED','CANCELLED')),FOREIGN KEY (CUSTOMER_ID) REFERENCES CUSTOMER(CUSTOMER_ID) ON DELETE CASCADE);
CREATE TABLE ORDER_ITEM(ORDER_ID INT ,PRODUCT_ID INT,QUANTITY INT CHECK(QUANTITY>0),UNIT_PRICE INT CHECK(UNIT_PRICE>0), PRIMARY KEY (ORDER_ID,PRODUCT_ID),FOREIGN KEY (ORDER_ID) REFERENCES SALES_ORDER(ORDER_ID) ON DELETE CASCADE,FOREIGN KEY (PRODUCT_ID) REFERENCES PRODUCT(PRODUCT_ID) ON DELETE CASCADE);
ALTER TABLE ORDER_ITEM ADD DISCOUNT_PERCENT INT DEFAULT (0) CHECK(DISCOUNT_PERCENT BETWEEN 0 AND 50);
ALTER TABLE CUSTOMER ADD CUSTOMER_PHONE INT  CHECK(CUSTOMER_PHONE BETWEEN 0 AND 10);
ALTER TABLE PRODUCT DROP INDEX SERIAL_NUMBER;
SELECT* FROM ORDER_ITEM;
SELECT* FROM PRODUCT;
INSERT INTO CUSTOMER(FULL_NAME,EMAIL,PHONE,AGE,CITY) VALUES ('IBNU','IBNU@GMAIL.COM',9645506865,22,'TIRUR'),('ADHIL','ADHIL@GMAIL.COM',8086964572,54,'MALAPPURAM'),('SHANIB','SHANIB@GMAIL.COM',4578253697,26,'MANNARKAD'),('SHAJAL','SHAJAL@GMAIL.COM',4219513479,24,'KOTTAKKAL'),('SUKU','SUKU@GMAIL.COM',5236974821,29,'PERINTHALMANNA');
SELECT * FROM CUSTOMER;
ALTER TABLE CUSTOMER CHANGE PHONE  PHONE VARCHAR(15);
INSERT INTO CUSTOMER(FULL_NAME,EMAIL,PHONE,AGE) VALUES ('KATHALE','KATHALE@123',4523697842,29);
INSERT INTO PRODUCT(PRODUCT_NAME,SERIAL_NUMBER,BRAND,PRICES,STOCK_QTY) VALUES('LAPTOP',111,'HP',5500,3),('MOUSE',112,'LOGITECK',1200,5),('KEYBOARD',113,'DELL',2500,8),('MONITOR',114,'ASUSE',5000,4),('CPU',115,'LENOVA',4588,1);
INSERT INTO PRODUCT(PRODUCT_NAME,SERIAL_NUMBER,PRICES,STOCK_QTY) VALUES('CHIP',116,2000,6);
INSERT INTO SALES_ORDER(CUSTOMER_ID,ORDER_DATE,STATUS) VALUES(1,'2026-10-02','DELIVERED'),(1,'2026-10-04','SHIPPED'),(2,'2026-10-05','DELIVERED'),(3,'2026-10-07','PENDING'),(4,'2026-10-10','CANCELLED'),(2,'2026-10-12','PENDING');
SELECT * FROM SALES_ORDER;
INSERT INTO ORDER_ITEM(ORDER_ID,PRODUCT_ID,QUANTITY,UNIT_PRICE) VALUES (1,1,1,5500),(1,6,2,1200),(1,2,2,2000),(2,3,1,5944),(3,2,3,2500),(3,3,1,7000),(4,4,2,6000),(5,1,1,6500);
SELECT*FROM ORDER_ITEM;
UPDATE PRODUCT SET PRICES=PRICES*1.10 WHERE BRAND='DELL';
UPDATE SALES_ORDER SET STATUS='SHIPPED'WHERE ORDER_ID=4;
SELECT*FROM SALES_ORDER;
INSERT INTO CUSTOMER(FULL_NAME,EMAIL,PHONE,AGE,CITY)VALUES('ABHIJITH','ABHIJITH@123',5246971234,32,NULL);
UPDATE CUSTOMER SET CITY='TRIVANDRUM' WHERE CITY IS NULL;
DELETE FROM ORDER_ITEM WHERE ORDER_ID=4 AND PRODUCT_ID=4;
DELETE FROM SALES_ORDER WHERE STATUS='CANCELLED';
SELECT * FROM Sales_Order WHERE Customer_ID = 1;
SELECT * FROM Order_Item  WHERE Order_ID IN (1,2);
DELETE FROM Customer WHERE Customer_ID = 1;
SELECT * FROM Sales_Order WHERE Customer_ID = 1; 
SELECT * FROM Order_Item  WHERE Order_ID IN (1,2);
DELETE FROM Product WHERE Product_ID = 2;
TRUNCATE TABLE Customer;
DROP TABLE Customer;
CREATE TABLE Product_Backup LIKE Product;
INSERT INTO Product_Backup SELECT * FROM Product;
DELETE FROM Product_Backup;
DROP TABLE Order_Item;       
DROP TABLE Sales_Order;      
DROP TABLE Customer;
DROP TABLE Product;
DROP TABLE Product_Backup;
-- Super keys (any set containing a candidate key; any 5 correct ones): {CustomerID}, {Email}, {Phone},
-- {CustomerID, FullName}, {Email, Age}, {Phone, City}, {CustomerID, Email}, {Email, Phone}, {CustomerID,
-- Email, Phone}, {CustomerID, FullName, Age, City}.
-- Candidate keys (minimal super keys): {CustomerID}, {Email}, {Phone}.
-- Primary key: CustomerID. It is short, numeric, auto-generated, never NULL and never changes. Email
-- and Phone can change over time, and Phone is nullable, so they are better kept as alternate keys with
-- UNIQUE.
-- Non-prime attributes (not part of any candidate key): FullName, Age, City
-- Q17. Composite key in OrderItem [1.5 marks]
-- OrderID alone fails because one order can contain several products: order 1 has two rows (1,1) and (1,2),
-- so OrderID repeats. ProductID alone fails because one product is sold in many orders: product 2 appears
-- in orders 1, 3 and 6, so ProductID repeats. Only the pair (OrderID, ProductID) is unique, and it also stops
-- the same product being added twice to one order, so a composite key is the right choice.
-- Q18. Yes or No [1.5 marks]
-- (a) Yes. Customer has three candidate keys: CustomerID, Email and Phone.
-- (b) No. A table has only one primary key, although that single key can be composite, as in
-- OrderItem(OrderID, ProductID).
-- (c) Yes. OrderItem has two foreign keys: OrderID to SalesOrder and ProductID to Product.
-- (d) Yes. A foreign key may reference any UNIQUE key of the parent. For example, a table could reference
-- Product(SerialNumber). Referencing the primary key is the recommended practice.
-- Q19. Foreign key vs primary key [1 mark]
-- Foreign key: can contain NULL (if the column allows it, meaning no parent) and can contain duplicates.
-- For example, many orders can share one CustomerID. Non-NULL values must exist in the parent table.
-- Primary key: can never contain NULL and can never contain duplicates, since it identifies each row



