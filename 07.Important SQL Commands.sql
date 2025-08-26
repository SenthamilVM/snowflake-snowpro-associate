--Use LA_DB.--
USE DATABASE LA_DB;

--Use account admin role and WH
USE ROLE ACCOUNTADMIN;
USE WAREHOUSE COMPUTE_WH;

/*Create employee table with id, name, department and salary. If schema is not selected, by default the table will be created in public schema*/
CREATE TABLE EMPLOYEE 
(
id INT,
name VARCHAR(35),
department VARCHAR (100),
salary DECIMAL
)

--Insert records into employee table
INSERT INTO EMPLOYEE (id, name, department, salary)
VALUES
(1, 'Alice', 'Engineering', 80000),
(2, 'Bob', 'HR', 60000),
(3, 'Charlie', 'Engineering', 90000),
(4, 'Diana', 'Marketing', 75000)


--Select all data from the table
SELECT * FROM EMPLOYEE;


--Select all data from the table but limit to 2 records
SELECT * FROM EMPLOYEE LIMIT 2;

--calculate the total salary from the employees table
SELECT SUM(salary) AS TotalSalary
FROM EMPLOYEE;


--Select all columns and order by salary in descending order
SELECT *
FROM EMPLOYEE
ORDER BY salary DESC;


--Group by department and calculate the average salary for each department
SELECT DEPARTMENT, AVG(SALARY) FROM
EMPLOYEE
GROUP BY DEPARTMENT;


--Select all columns except the excluded one (department)
SELECT * EXCLUDE department
FROM EMPLOYEE


----Select all columns except the excluded ones (department and name)
SELECT * EXCLUDE (DEPARTMENT, NAME) 
FROM EMPLOYEE
