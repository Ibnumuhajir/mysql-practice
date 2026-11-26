USE IBNU;
CREATE TABLE Sales (
SaleID INT,
Salesperson VARCHAR(30),
City VARCHAR(30),
Amount INT
);

INSERT INTO Sales VALUES
(1, 'Rahul', 'Kochi', 5000),
(2, 'Sneha', 'Chennai', 7000),
(3, 'Arjun', 'Kochi', 9000),
(4, 'Priya', 'Bengaluru', 4000),
(5, 'Kiran', 'Chennai', 8000),
(6, 'Anu', 'Kochi', 6000),
(7, 'Vishnu', 'Bengaluru', 10000);
-- Q1)Display the details of salespersons who made sales in Kochi.
SELECT * 
FROM Sales 
WHERE City = 'Kochi';
-- 2)Display the sales details of salespersons whose sales amount is greater than ANY sales amount recorded in Chennai.
SELECT * 
FROM Sales 
WHERE Amount > ANY (
    SELECT Amount 
    FROM Sales 
    WHERE City = 'Chennai'
);
-- 3)Display the sales details of salespersons whose sales amount is greater than ALL sales amounts recorded in Bengaluru.
SELECT * 
FROM Sales 
WHERE Amount > ALL (
    SELECT Amount 
    FROM Sales 
    WHERE City = 'Bengaluru'
);

#SELF JOIN 
CREATE TABLE EMPP (
    EmpID INT PRIMARY KEY,
    Name VARCHAR(50),
    Salary INT,
    ManagerID INT
);
INSERT INTO EMPP (EmpID, Name, Salary, ManagerID) VALUES
(1, 'Arun', 90000, NULL),
(2, 'Meera', 60000, 1),
(3, 'Rahul', 50000, 1),
(4, 'Anu', 65000, 2),
(5, 'John', 40000, 2);

#Q1
SELECT 
    e.Name AS Employee_Name, 
    m.Name AS Manager_Name
FROM Empp e
JOIN Empp m ON e.ManagerID = m.EmpID;
#q2
SELECT 
    e.Name AS Employee_Name, 
    COALESCE(m.Name, 'NULL') AS Manager_Name
FROM Empp e
LEFT JOIN Empp m ON e.ManagerID = m.EmpID;
#q3
SELECT 
    e.Name AS Employee_Name, 
    e.Salary AS Employee_Salary, 
    m.Name AS Manager_Name, 
    m.Salary AS Manager_Salary
FROM Empp e
JOIN Empp m ON e.ManagerID = m.EmpID
WHERE e.Salary > m.Salary;

#cross join
CREATE TABLE colors(color_id INT, color_name VARCHAR(20)); 
INSERT INTO colors VALUES (1,'Red'),(2,'Blue'),(3,'Black'); 
CREATE TABLE sizes(size_id INT, size_name VARCHAR(5)); 
INSERT INTO sizes VALUES (1,'S'),(2,'M'),(3,'L');

CREATE TABLE students(student_id INT, student_name VARCHAR(30)); 
INSERT INTO students VALUES (101,'Anu'),(102,'Ravi'),(103,'Meera');
CREATE TABLE subjects(subject_id INT, subject_name VARCHAR(30)); 
INSERT INTO subjects VALUES (1,'Maths'),(2,'Science'),(3,'English');

#full join
CREATE TABLE Student (
    StudentID INT PRIMARY KEY,
    StudentName VARCHAR(50),
    CourseID INT
);

INSERT INTO Student VALUES
(1, 'Aisha', 201),
(2, 'Arjun', 202),
(3, 'Diya', 203),
(4, 'Rahul', 204),
(5, 'Sneha', NULL);


### 2. Create Course Table

CREATE TABLE Course (
    CourseID INT PRIMARY KEY,
    CourseName VARCHAR(50)
);

INSERT INTO Course VALUES
(201, 'Python'),
(202, 'Data Science'),
(203, 'SQL'),
(205, 'Power BI'),
(206, 'Machine Learning');


### 3. Display Both Tables
SELECT * FROM Student;
SELECT * FROM Course;

### 4. Assignment Questions

-- *Q1.* Display all students and all courses, including records that do not have matching values in both tables.
SELECT 
    s.StudentID,
    s.StudentName,
    c.CourseID,
    c.CourseName
FROM Student s
 JOIN Course c 
    ON s.CourseID = c.CourseID;
-- *Q2.* Display StudentID, StudentName, CourseID and CourseName.
SELECT 
    s.StudentID,
    s.StudentName,
    s.CourseID,
    c.CourseName
FROM Student s
LEFT JOIN Course c 
    ON s.CourseID = c.CourseID;
-- *Q3.* Write a query to achieve FULL OUTER JOIN using LEFT JOIN, RIGHT JOIN and UNION.
SELECT 
    s.StudentID,
    s.StudentName,
    c.CourseID,
    c.CourseName
FROM Student s
LEFT JOIN Course c 
    ON s.CourseID = c.CourseID

UNION

SELECT 
    s.StudentID,
    s.StudentName,
    c.CourseID,
    c.CourseName
FROM Student s
RIGHT JOIN Course c 
    ON s.CourseID = c.CourseID;



