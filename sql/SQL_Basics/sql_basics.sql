SELECT *
FROM parks_departments.employee_demographics;

SELECT first_name,
last_name,
birth_date,
age,
(age + 10) * 10 +10 
FROM parks_and_recreation.employee_demographics;
#PEMDAS

SELECT DISTINCT  first_name , gender 
FROM parks_and_recreation.employee_demographics;


-- WHERE Clause

SELECT *
FROM employee_salary
WHERE first_name = 'Leslie'
;

SELECT *
FROM employee_salary
WHERE salary <= 50000
;


SELECT *
FROM employee_demographics
WHERE birth_date > '1985-01-01'
;

-- AND OR NOT -- logical oprators 
SELECT *
FROM employee_demographics
WHERE birth_date > '1985-01-01'
OR NOT gender = 'male'
;

SELECT *
FROM employee_demographics
WHERE (first_name = 'Leslie' AND age = 44) OR age > 55
;

-- LIKE Statement
-- %  _
SELECT *
FROM employee_demographics
WHERE first_name LIKE 'Jer%'
;
SELECT *
FROM employee_demographics
WHERE first_name LIKE 'a__'
;

-- GROUP BY
SELECT gender
FROM employee_demographics
GROUP BY gender
;

SELECT gender , AVG(age), MAX(age), MIN(age), COUNT(age)
FROM employee_demographics
GROUP BY gender
;

-- ORDER BY
SELECT *
FROM employee_demographics
ORDER BY gender
;

-- HAVING vs WHERE 
SELECT gender , AVG(age)
FROM employee_demographics
GROUP BY gender
HAVING AVG(age) > 40
;

SELECT occupation , AVG(salary)
FROM employee_salary
WHERE occupation LIKE '%manager%'
GROUP BY occupation
HAVING AVG(salary) > 75000
;

-- LIMIT & Aliasing
SELECT *
FROM employee_demographics AS emp1
ORDER BY age DESC
LIMIT 2, 1
;

-- JOIN
SELECT *
FROM employee_demographics
INNER JOIN employee_salary
	ON employee_demographics.employee_id = employee_salary.employee_id
;

-- OUTER JOIN
SELECT *
FROM employee_demographics
LEFT JOIN employee_salary
	ON employee_demographics.employee_id = employee_salary.employee_id
;

SELECT *
FROM employee_demographics
RIGHT JOIN employee_salary
	ON employee_demographics.employee_id = employee_salary.employee_id
;

-- Self JOIN
SELECT emp1.employee_id AS emp_santa,
emp1.first_name AS first_name_santa,
emp1.last_name AS last_name_santa,
emp2.employee_id AS emp,
emp2.first_name AS first_name,
emp2.last_name AS last_name
FROM employee_salary emp1
JOIN employee_salary emp2
	ON emp1.employee_id + 1 = emp2.employee_id
;

-- Joining multiple tables together
SELECT *
FROM employee_demographics AS dem
INNER JOIN employee_salary AS sal
	ON dem.employee_id = sal.employee_id
INNER JOIN parks_departments AS pd
	ON sal.dept_id = pd.department_id
;

-- Union
SELECT first_name, last_name, 'old man' AS label
FROM employee_demographics
WHERE age >  40 AND gender = 'male'
UNION
SELECT first_name, last_name, 'old lady' AS label
FROM employee_demographics
WHERE age >  40 AND gender = 'female' 
UNION
SELECT first_name,last_name, 'highly paid employee' AS label
FROM employee_salary
WHERE salary >  70000
ORDER BY first_name, last_name
;

-- String Functions 
SELECT LENGTH('skyfall');
SELECT UPPER('skyfall');
SELECT LOWER('Skyfall');
SELECT TRIM('    skyfall      ');
SELECT LTRIM('   skyfall  ');
SELECT RTRIM('   skyfall  ');

SELECT first_name, LENGTH(first_name)
FROM employee_demographics
ORDER BY 2;

SELECT first_name,
LEFT(first_name, 4),
RIGHT (first_name, 4),
SUBSTRING(first_name, 3, 4),
birth_date,
SUBSTRING(birth_date,6,2) AS 'birth_month'
FROM employee_demographics
;


SELECT first_name, REPLACE(first_name ,'a' , 'z')
FROM employee_demographics;

SELECT LOCATE('x','Alexander');

SELECT first_name,last_name,
CONCAT(first_name, '  ',  last_name) AS full_name
FROM employee_demographics
;

-- Case Statements
SELECT first_name,
last_name
age,
CASE 
	WHEN age <= 30 THEN 'young'
    WHEN age BETWEEN 30 AND 50 THEN 'old'
    WHEN age > 50 THEN 'older'
END AS lable 
FROM employee_demographics
;

-- pay increment and bonus
-- < 50000 = 5%
-- > 50000 = 7%
-- Finance = 10% bonus

SELECT first_name, last_name, salary,
CASE 
	WHEN salary < 50000 THEN salary * 1.05
    WHEN salary > 50000 THEN salary * 1.07
END AS new_salary,
CASE
	WHEN dept_id = 6 THEN salary * .10
END AS bonus
FROM employee_salary
;

-- Subqueries
SELECT *
FROM employee_demographics
WHERE employee_id IN 
				(SELECT employee_id
                FROM employee_salary
                WHERE dept_id = 1)
;

SELECT first_name, salary, 
(SELECT AVG(salary)
FROM employee_salary)
FROM employee_salary;                

SELECT AVG(max_age)
FROM
(SELECT gender,
AVG(age) AS avg_age,
MAX(age) AS max_age,
MIN(age) AS min_age,
COUNT(age)
FROM employee_demographics
GROUP BY gender) AS agg_table
;

-- window function
SELECT dem.first_name, dem.last_name, gender, AVG(salary) OVER(PARTITION BY gender)
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id
;

SELECT dem.employee_id, dem.first_name, dem.last_name, gender, salary,
ROW_NUMBER() OVER(PARTITION BY gender ORDER BY salary DESC) AS row_num,
RANK() OVER(PARTITION BY gender ORDER BY salary DESC) AS rank_num,
DENSE_RANK() OVER(PARTITION BY gender ORDER BY salary DESC) AS dense_rank_num
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id
;

-- CTEs
WITH CTE_Example AS
(SELECT gender,AVG(salary) AS avg_sal,MAX(salary) AS max_sal,MIN(salary) AS min_sal, COUNT(salary) count_sal
FROM employee_demographics dem
JOIN employee_salary sal
	ON dem.employee_id = sal.employee_id
GROUP BY gender
)
SELECT AVG(avg_sal)
FROM CTE_Example
;

-- Temporary Tables
CREATE TEMPORARY TABLE temp_table
(first_name varchar(50),
last_name varchar(50),
favorite_movie varchar(100)
);

SELECT *
FROM temp_table;

INSERT INTO temp_table
VALUES
('Shin','Chan', 'Action Kamen'),
('Nobita','Nobi', 'Dinosaur');

SELECT *
FROM temp_table;

CREATE TEMPORARY TABLE salary_over_50k
SELECT *
FROM employee_salary
WHERE salary >= 50000;

SELECT *
FROM salary_over_50k;

-- TRIGGERS and Events

DELIMITER $$
CREATE TRIGGER employee_insert
	AFTER INSERT ON employee_salary
    FOR EACH ROW
BEGIN
INSERT  employee_demographics (employee_id, first_name, last_name)
VALUES(NEW.employee_id, NEW.first_name, NEW.last_name);
END $$
DELIMITER ;

INSERT INTO employee_salary (employee_id, first_name, last_name, occupation, salary, dept_id)
VALUES(13,'Light', 'Yagami', 'entertainment', 1000000, NULL);

SELECT *
FROM employee_salary;

SELECT *
FROM employee_demographics;

DELIMITER $$
CREATE EVENT delete_retairees
ON SCHEDULE EVERY 30 SECOND
DO
BEGIN
	DELETE
    FROM employee_demographics
    WHERE age >=60;
END $$
DELIMITER ;