create database ibnu;
use ibnu;
create table details(id int auto_increment primary key,name varchar(50) not null,email varchar(50) unique,age int check(age>18),city varchar(50) default"kochi");
#id is auto increment
insert into details(name,email,age,city) values ('ibnu','ibnu@gmail.com',19,null),('suku','suku@gmail.com',22,null);
#default city
INSERT INTO details (Name, Email, Age)
		VALUES ('Vishnu P', 'vishnu@gmail.com', 26);
#To check NOTNULL constraints
INSERT INTO details (Name, Email, Age, City)
    VALUES (NULL, 'test@gmail.com', 25, 'Kochi');
#To Test UNIQUE constraint
INSERT INTO details (Name, Email, Age, City)
VALUES ('Anu K', 'arun@gmail.com', 24, 'Kochi');
#To Test CHECK constraint
INSERT INTO details (Name, Email, Age, City)
VALUES ('Ravi K', 'ravi@gmail.com', 16, 'Kochi');


select * from details

