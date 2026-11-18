CREATE DATABASE PRACTICE;
USE PRACTICE;
SELECT * FROM STUDENT2;
SELECT * FROM ORDERS;
UPDATE STUDENT2 SET Email= NULL WHERE Email='';
SET SQL_SAFE_UPDATES = 0 ;
select count(*) from student2;
select count(*) from orders;
select count(*) from student2 where email is null;
# distinct means show unique  (DISTINCT)
select distinct city from student2;
#give temporary column name (AS)
select name as student_name from student2;
#used to show condition based (WHERE)
select * from student2 where age>18;
#add
select price * quantity as total_amount from orders;
select * from student2 where age>18 and city='kochi';
select * from student2 where city='kochi' or city='calicut';
select * from student2 where not city='kochi';
select * from student2 where email is null;
select * from student2 where age between 18 and 25;
select * from student2 where age not between 18 and 25;
select * from student2 WHERE name LIKE 'A%';
select * from student2 where name like '___ali';
select * from student2 where name not like'a%';




