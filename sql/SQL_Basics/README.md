# Parks and Recreation SQL Database
## Project Overview

This project creates a sample MySQL relational database called
`parks_and_recreation`.

The database is designed to practice SQL concepts including:

- Database creation
- Table relationships
- Filtering
- Aggregations
- Joins
- Subqueries
- Window functions
- CTEs
- Triggers
- Events

## Tech Stack

- Database: MySQL
- Language: SQL
- Project Type: Learning Database

# Database Setup

## Step 1: `DROP` DATABASE

```sql
DROP DATABASE IF EXISTS Parks_and_Recreation;
```

Deletes the existing database if it already exists to ensure a clean setup.

---

## Step 2: `CREATE` DATABASE

```sql
CREATE DATABASE Parks_and_Recreation;
```

Creates a new database.

---

## Step 3: `USE` DATABASE

```sql
USE Parks_and_Recreation;
```

Makes the newly created database the active database.

---

## Step 4: `Create Tables`

Creates the following tables:

- employee_demographics
- employee_salary
- parks_departments

Each table is designed with appropriate data types and primary keys.

---

# Database Schema
## 1. employee_demographics

Stores the personal details of employees.

| Column | Data Type | Description |
|---------|----------|-------------|
| employee_id | INT | Primary Key |
| first_name | VARCHAR(50) | Employee's first name |
| last_name | VARCHAR(50) | Employee's last name |
| age | INT | Employee's age |
| gender | VARCHAR(10) | Employee's gender |
| birth_date | DATE | Employee's birth date |

**Primary Key**

- `employee_id`

---

## 2. employee_salary

Stores employment-related information.

| Column | Data Type | Description |
|---------|----------|-------------|
| employee_id | INT | Employee ID |
| first_name | VARCHAR(50) | First name |
| last_name | VARCHAR(50) | Last name |
| occupation | VARCHAR(50) | Job title |
| salary | INT | Annual salary |
| dept_id | INT | Department ID |



## 3. parks_departments

Stores department information.

| Column | Data Type | Description |
|---------|----------|-------------|
| department_id | INT | Primary Key (Auto Increment) |
| department_name | VARCHAR(50) | Department Name |

Departments include:

- Parks and Recreation
- Animal Control
- Public Works
- Healthcare
- Library
- Finance

---

## Table of Contents

# Basic SQL Queries
## Example : 

```sql
SELECT
    first_name,
    last_name,
    birth_date,
    age,
    (age + 10) * 10 + 10
FROM parks_and_recreation.employee_demographics;
```

## Explanation

- Retrieves employee details: `first_name`, `last_name`, `birth_date`, and `age`.
- Calculates a new value using:
  ```sql
  (age + 10) * 10 + 10
  ```
- The expression does **not** change the stored data; it only displays a calculated result.

## PEMDAS (Order of Operations)

SQL follows the standard order of operations:

1. **P** – Parentheses `()`
2. **E** – Exponents
3. **M/D** – Multiplication and Division (left to right)
4. **A/S** – Addition and Subtraction (left to right)


## Example : 

```sql
SELECT DISTINCT first_name, gender
FROM parks_and_recreation.employee_demographics;
```

## Explanation

This SQL query retrieves a list of **unique combinations** of employee first names and their gender from the `employee_demographics` table.

## What is `DISTINCT`?

`DISTINCT` is an SQL keyword used to **remove duplicate rows** from the result set. It ensures that only **unique values** are returned.


# SQL `LIMIT` & `Aliasing`

`LIMIT` is used to restrict the number of rows returned by a query.  
Aliasing allows you to give a table or column a temporary name using `AS`.

## Syntax

```sql
SELECT column_name
FROM table_name AS alias_name
ORDER BY column_name
LIMIT number_of_rows;
```

## Example : 

```sql
SELECT *
FROM employee_demographics AS emp1
ORDER BY age DESC
LIMIT 2, 1
;
``` 

# SQL `WHERE` Clause

## What is the WHERE Clause?

The `WHERE` clause is used in SQL to **filter records** from a table based on a specified condition.

It allows you to retrieve only the rows that match a given condition instead of returning all records from the table.

## Syntax

```sql
SELECT column_name
FROM table_name
WHERE condition;
```

### SQL Query Clauses

| Clause | Description |
|--------|-------------|
| `SELECT` | Specifies the columns you want to retrieve from a table. |
| `FROM` | Specifies the table from which the data is retrieved. |
| `WHERE` | Applies a filtering condition to return only matching rows. |
| `condition` | The rule or criteria that determines which rows are returned. |

## Example : 

```sql
SELECT *
FROM employee_salary
WHERE first_name = 'Leslie';

SELECT *
FROM employee_salary
WHERE salary <= 50000;

SELECT *
FROM employee_demographics
WHERE birth_date > '1985-01-01';

```
# SQL Logical Operators (`AND`, `OR`, `NOT`)

Logical operators are used in the `WHERE` clause to combine multiple conditions when filtering data.

### Logical Operators

| Operator | Description |
|----------|-------------|
| `AND` | Returns rows only if **all** conditions are true. |
| `OR` | Returns rows if **at least one** condition is true. |
| `NOT` | Reverses a condition and returns rows where the condition is false. |

---

## Example :

```sql
SELECT *
FROM employee_demographics
WHERE birth_date > '1985-01-01'
OR NOT gender = 'male';

SELECT *
FROM employee_demographics
WHERE (first_name = 'Leslie' AND age = 44) OR age > 55;
```

## Operator Precedence

SQL evaluates logical operators in the following order:

1. `NOT`
2. `AND`
3. `OR`

> **Tip:** Use parentheses `()` to group conditions and improve readability.

# SQL `LIKE` Statement

## What is LIKE?

The `LIKE` operator is used in SQL to **search for a specific pattern** in a column. It is commonly used with the `WHERE` clause to filter text values when the exact value is not known.

### Wildcards Used with LIKE

| Wildcard | Description |
|----------|-------------|
| `%` | Represents zero or more characters |
| `_` | Represents exactly one character |

---

## Example:


```sql
SELECT *
FROM employee_demographics
WHERE first_name LIKE 'Jer%';

SELECT *
FROM employee_demographics
WHERE first_name LIKE 'a__';
```


## Sorting and Aggregation


# SQL `GROUP BY`

The `GROUP BY` clause groups rows that have the same values in one or more columns. It is commonly used with aggregate functions such as `COUNT()`, `SUM()`, `AVG()`, `MIN()`, and `MAX()`.

## Syntax

```sql
SELECT column_name, aggregate_function(column_name)
FROM table_name
GROUP BY column_name;
```

---

## Example : 

```sql
-- GROUP BY
SELECT gender
FROM employee_demographics
GROUP BY gender;

SELECT gender , AVG(age), MAX(age), MIN(age), COUNT(age)
FROM employee_demographics
GROUP BY gender;
```

> **Note:** Every column in the `SELECT` list must either be included in the `GROUP BY` clause or be used inside an aggregate function.

# SQL `ORDER BY`

The `ORDER BY` clause is used to **sort the result of a query** based on one or more columns. It arranges the rows in ascending order (`ASC`) by default or descending order (`DESC`) when specified.

## Syntax

```sql
SELECT column_name
FROM table_name
ORDER BY column_name ASC | DESC;
```

## Example : 

```sql
SELECT *
FROM employee_demographics
ORDER BY gender
;
```

# SQL `HAVING` vs `WHERE`

`WHERE` and `HAVING` are both used to filter data, but they work at different stages of a query.

- `WHERE` filters **individual rows before grouping**.
- `HAVING` filters **groups after aggregate functions are calculated**.

## Syntax

```sql
SELECT column_name, aggregate_function(column_name)
FROM table_name
WHERE condition
GROUP BY column_name
HAVING aggregate_condition;
```

## Example : 

```sql
SELECT gender , AVG(age)
FROM employee_demographics
GROUP BY gender
HAVING AVG(age) > 40
;
```

```sql
SELECT occupation , AVG(salary)
FROM employee_salary
WHERE occupation LIKE '%manager%'
GROUP BY occupation
HAVING AVG(salary) > 75000
;
```


# SQL `Joins`

## 1. `INNER JOIN`
Returns only the rows where matching values exist in both tables.

```sql
SELECT *
FROM employee_demographics
INNER JOIN employee_salary
	ON employee_demographics.employee_id = employee_salary.employee_id;
```

**Explanation:** Retrieves employees who have records in both `employee_demographics` and `employee_salary`.

---

## 2. `LEFT JOIN`
Returns all rows from the left table and matching rows from the right table. If no match exists, `NULL` values are returned for the right table.

```sql
SELECT *
FROM employee_demographics
LEFT JOIN employee_salary
ON employee_demographics.employee_id = employee_salary.employee_id;
```

**Explanation:** Shows all employees from `employee_demographics`, even if salary information is missing.

---

## 3. `RIGHT JOIN`
Returns all rows from the right table and matching rows from the left table. If no match exists, `NULL` values are returned for the left table.

```sql
SELECT *
FROM employee_demographics
RIGHT JOIN employee_salary
ON employee_demographics.employee_id = employee_salary.employee_id;
```

**Explanation:** Shows all salary records, even if employee demographic details are missing.

---

## 4. SELF JOIN
Joins a table with itself using different aliases.

```sql
SELECT
    emp1.employee_id AS emp_santa,
    emp1.first_name AS first_name_santa,
    emp1.last_name AS last_name_santa,
    emp2.employee_id AS emp,
    emp2.first_name AS first_name,
    emp2.last_name AS last_name
FROM employee_salary emp1
JOIN employee_salary emp2
ON emp1.employee_id + 1 = emp2.employee_id;
```

**Explanation:** Matches each employee with the employee whose `employee_id` is one greater.

---

## 5. Multiple Table JOIN
Joins more than two tables in a single query.

```sql
SELECT *
FROM employee_demographics AS dem
INNER JOIN employee_salary AS sal
ON dem.employee_id = sal.employee_id
INNER JOIN parks_departments AS pd
ON sal.dept_id = pd.department_id;
```

**Explanation:** Combines employee demographics, salary, and department information into one result.

---

### Summary

| JOIN Type | Description |
|-----------|-------------|
| `INNER JOIN` | Returns matching rows from both tables. |
| `LEFT JOIN` | Returns all rows from the left table and matching rows from the right. |
| `RIGHT JOIN` | Returns all rows from the right table and matching rows from the left. |
| `SELF JOIN` | Joins a table with itself. |
| `Multiple JOIN` | Combines data from three or more tables. |

# SQL UNION Example
## UNION

`UNION` combines the results of two or more `SELECT` statements into a single result set. It removes duplicate rows by default.

```sql
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
ORDER BY first_name, last_name;
```

## Explanation
- The first `SELECT` returns males older than 40 and labels them as **"old man"**.
- The second `SELECT` returns females older than 40 and labels them as **"old lady"**.
- The third `SELECT` returns employees earning more than **70,000** and labels them as **"highly paid employee"**.
- `UNION` merges all three result sets and removes duplicate rows.
- `ORDER BY` sorts the final output by **first_name** and **last_name**.

## Note
- All `SELECT` statements must return the **same number of columns**.
- The corresponding columns must have **compatible data types**.
- Use `UNION ALL` if you want to **keep duplicate rows**.

### Summary

| Keyword | Description |
|---------|-------------|
| `UNION` | Combines multiple `SELECT` results and removes duplicates. |
| `UNION ALL` | Combines multiple `SELECT` results and keeps duplicates. |
| `ORDER BY` | Sorts the final combined result. |


## String Functions

String functions are used to manipulate and retrieve information from text values.

## 1. `LENGTH`()
Returns the number of characters in a string.

```sql
SELECT LENGTH('skyfall');
```

**Explanation:** Returns the length of `"skyfall"` (8).

---

## 2. `UPPER`()
Converts all characters to uppercase.

```sql
SELECT UPPER('skyfall');
```

**Explanation:** Returns `SKYFALL`.

---

## 3. `LOWER`()
Converts all characters to lowercase.

```sql
SELECT LOWER('Skyfall');
```

**Explanation:** Returns `skyfall`.

---

## 4. `TRIM`()
Removes leading and trailing spaces.

```sql
SELECT TRIM('    skyfall      ');
```

**Explanation:** Returns `skyfall`.

---

## 5. `LTRIM`()
Removes spaces from the left side only.

```sql
SELECT LTRIM('   skyfall  ');
```

**Explanation:** Returns `skyfall  ` (right spaces remain).

---

## 6. `RTRIM`()
Removes spaces from the right side only.

```sql
SELECT RTRIM('   skyfall  ');
```

**Explanation:** Returns `   skyfall` (left spaces remain).

---

## 7. `LENGTH`() with Table Data

```sql
SELECT first_name, LENGTH(first_name)
FROM employee_demographics
ORDER BY 2;
```

**Explanation:** Displays each employee's first name and its character length, then sorts by the length (column 2).

---

## 8. `LEFT`(), `RIGHT`(), `SUBSTRING`()

```sql
SELECT
    first_name,
    LEFT(first_name, 4),
    RIGHT(first_name, 4),
    SUBSTRING(first_name, 3, 4),
    birth_date,
    SUBSTRING(birth_date, 6, 2) AS birth_month
FROM employee_demographics;
```

**Explanation:**
- `LEFT(first_name, 4)` → First 4 characters.
- `RIGHT(first_name, 4)` → Last 4 characters.
- `SUBSTRING(first_name, 3, 4)` → 4 characters starting from position 3.
- `SUBSTRING(birth_date, 6, 2)` → Extracts the birth month from the date.

---

## 9. `REPLACE`()

```sql
SELECT first_name,
REPLACE(first_name, 'a', 'z')
FROM employee_demographics;
```

**Explanation:** Replaces every `'a'` with `'z'` in `first_name`.

---

## 10. `LOCATE`()

```sql
SELECT LOCATE('x', 'Alexander');
```

**Explanation:** Returns the position of `'x'` in `"Alexander"`.

---

## 11. `CONCAT`()

```sql
SELECT
    first_name,
    last_name,
    CONCAT(first_name, ' ', last_name) AS full_name
FROM employee_demographics;
```

**Explanation:** Combines `first_name` and `last_name` into a single `full_name`.

---

## Summary

| Function | Description |
|----------|-------------|
| `LENGTH()` | Returns the number of characters in a string. |
| `UPPER()` | Converts text to uppercase. |
| `LOWER()` | Converts text to lowercase. |
| `TRIM()` | Removes spaces from both ends. |
| `LTRIM()` | Removes leading spaces. |
| `RTRIM()` | Removes trailing spaces. |
| `LEFT()` | Returns characters from the left. |
| `RIGHT()` | Returns characters from the right. |
| `SUBSTRING()` | Extracts part of a string. |
| `REPLACE()` | Replaces specified text with new text. |
| `LOCATE()` | Finds the position of a substring. |
| `CONCAT()` | Combines multiple strings into one. |


# Advanced SQL
## SQL `CASE` Statements

## Overview
The `CASE` statement in SQL is used to add conditional logic to a query. It works similarly to an **if-else** statement in programming languages, allowing you to return different values based on specified conditions.

---

## Syntax
```sql
CASE
    WHEN condition1 THEN result1
    WHEN condition2 THEN result2
    ELSE default_result
END AS column_name;
```

## Example : 

```sql
SELECT 
    first_name,
    last_name,
    age,
    CASE
        WHEN age <= 30 THEN 'young'
        WHEN age BETWEEN 31 AND 50 THEN 'old'
        WHEN age > 50 THEN 'older'
    END AS label
FROM employee_demographics;
```

> **Note:** `BETWEEN` is inclusive. Using `BETWEEN 30 AND 50` would include age `30`, but the first condition already handles it. Using `BETWEEN 31 AND 50` avoids overlap.

---

## Example : 

```sql
SELECT
    first_name,
    last_name,
    salary,
    CASE
        WHEN salary < 50000 THEN salary * 1.05
        WHEN salary >= 50000 THEN salary * 1.07
    END AS new_salary,
    CASE
        WHEN dept_id = 6 THEN salary * 0.10
    END AS bonus
FROM employee_salary;
```
---

## Key Points
- `CASE` evaluates conditions **from top to bottom**.
- The **first matching condition** is returned.
- `END` closes the `CASE` statement.
- Use `AS` to assign a custom column name.
- An optional `ELSE` clause can provide a default value if no conditions match.

# SQL Subqueries

## Overview
A **subquery** is a query written inside another SQL query. The inner query executes first, and its result is used by the outer query. Subqueries can be used with `WHERE`, `FROM`, and `SELECT` clauses.

---

## Example :

```sql
SELECT *
FROM employee_demographics
WHERE employee_id IN
(
    SELECT employee_id
    FROM employee_salary
    WHERE dept_id = 1
);
```

---

## Example :

```sql
SELECT
    first_name,
    salary,
    (
        SELECT AVG(salary)
        FROM employee_salary
    ) AS avg_salary
FROM employee_salary;
```

---

## Example :

```sql
SELECT AVG(max_age)
FROM
(
    SELECT
        gender,
        AVG(age) AS avg_age,
        MAX(age) AS max_age,
        MIN(age) AS min_age,
        COUNT(age) AS total_people
    FROM employee_demographics
    GROUP BY gender
) AS agg_table;
```

---

## Key Points
- A **subquery** is a query nested inside another query.
- Subqueries execute **from the inside out**.
- They can be used in:
  - `WHERE` → Filter rows based on another query.
  - `SELECT` → Return a calculated value.
  - `FROM` → Create a temporary table for further analysis.
- A subquery in the `SELECT` clause must return **only one value**.
- A subquery in the `FROM` clause **must have an alias** (e.g., `AS agg_table`).

---

# SQL Window Functions

## Overview
Window functions perform calculations across a set of rows related to the current row **without grouping the result into a single row**. Unlike `GROUP BY`, they keep every row while adding calculated values.

**Syntax**
```sql
function_name() OVER (
    PARTITION BY column_name
    ORDER BY column_name
)
```

- **`PARTITION BY`** → Divides rows into groups.
- **`ORDER BY`** → Defines the order within each partition.
- **`OVER()`** → Specifies the window over which the function operates.

---

## Example :

```sql
SELECT
    dem.first_name,
    dem.last_name,
    gender,
    AVG(salary) OVER(PARTITION BY gender) AS avg_salary
FROM employee_demographics dem
JOIN employee_salary sal
    ON dem.employee_id = sal.employee_id;
```

## Explanation
- Joins employee demographic and salary tables.
- `PARTITION BY gender` groups employees by gender.
- `AVG(salary)` calculates the average salary for each gender.
- Every employee remains in the result, with the average salary of their gender displayed.

---

## Example :

```sql
SELECT
    dem.employee_id,
    dem.first_name,
    dem.last_name,
    gender,
    salary,
    ROW_NUMBER() OVER(PARTITION BY gender ORDER BY salary DESC) AS row_num,
    RANK() OVER(PARTITION BY gender ORDER BY salary DESC) AS rank_num,
    DENSE_RANK() OVER(PARTITION BY gender ORDER BY salary DESC) AS dense_rank_num
FROM employee_demographics dem
JOIN employee_salary sal
    ON dem.employee_id = sal.employee_id;
```

### Window Functions Used

#### `ROW_NUMBER()`
- Assigns a **unique sequential number** to each row.
- No duplicate row numbers, even if salaries are the same.

#### `RANK()`
- Assigns the same rank to equal salaries.
- Skips the next rank after a tie.

#### `DENSE_RANK()`
- Assigns the same rank to equal salaries.
- Does **not** skip ranks after ties.

---

# SQL Common Table Expressions (CTEs)

## Overview
A **Common Table Expression (CTE)** is a temporary named result set created using the `WITH` keyword. It exists only for the duration of the query and helps make complex SQL queries more readable and maintainable.

**Syntax**
```sql
WITH cte_name AS
(
    SELECT ...
)
SELECT *
FROM cte_name;
```

- **`WITH`** → Defines the CTE.
- **`AS`** → Assigns the query to the CTE.
- The CTE can then be referenced like a temporary table in the main query.

---

## Example:

```sql
WITH CTE_Example AS
(
    SELECT
        gender,
        AVG(salary) AS avg_sal,
        MAX(salary) AS max_sal,
        MIN(salary) AS min_sal,
        COUNT(salary) AS count_sal
    FROM employee_demographics dem
    JOIN employee_salary sal
        ON dem.employee_id = sal.employee_id
    GROUP BY gender
)

SELECT AVG(avg_sal)
FROM CTE_Example;
```

## Why Use a CTE?

CTEs help to:

- Improve query readability.
- Break complex queries into smaller logical parts.
- Avoid repeating the same subquery multiple times.
- Make SQL easier to debug and maintain.
- Support recursive queries (advanced use case).

---

## CTE vs Subquery

| CTE | Subquery |
|-----|----------|
| Defined using `WITH` | Written inside another query |
| More readable for complex queries | Can become difficult to read when nested |
| Can be referenced multiple times in the same query | Usually referenced only once |
| Better for organizing complex logic | Better for simple one-time calculations |

---

## Key Points

- A CTE is created using the **`WITH`** keyword.
- It acts as a **temporary result set** available only during the execution of the query.
- CTEs improve **readability**, **reusability**, and **maintainability**.
- They are commonly used with:
  - Joins
  - Aggregations
  - Window functions
  - Recursive queries
- Once the query finishes, the CTE is automatically discarded.
 
# Database Automation
## SQL Temporary Tables, Triggers, and Events


# 1. Temporary Tables

## What is a Temporary Table?

A **Temporary Table** is a table that exists only for the current database session.

- It is automatically deleted when the session ends.
- It is useful for storing intermediate results.
- Other users cannot access your temporary table.

### Creating a Temporary Table

```sql
CREATE TEMPORARY TABLE temp_table
(
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    favorite_movie VARCHAR(100)
);
```
---

### View the Empty Table

```sql
SELECT *
FROM temp_table;
```

Since no records have been inserted yet, the result will be empty.

---

### Insert Data

```sql
INSERT INTO temp_table
VALUES
('Shin','Chan','Action Kamen'),
('Nobita','Nobi','Dinosaur');
```

Two records are inserted into the temporary table.

---

### View the Data

```sql
SELECT *
FROM temp_table;
```
---

# 2. Temporary Table from an Existing Table

Instead of defining columns manually, MySQL allows creating a temporary table directly from another table.

```sql
CREATE TEMPORARY TABLE salary_over_50k
SELECT *
FROM employee_salary
WHERE salary >= 50000;
```
---

### View the Temporary Table

```sql
SELECT *
FROM salary_over_50k;
```

This displays only employees earning **50,000 or more**.

---

# 3. Triggers

## What is a Trigger?

A **Trigger** is a stored program that automatically executes when a specific database event occurs.

Triggers can run:

- BEFORE INSERT
- AFTER INSERT
- BEFORE UPDATE
- AFTER UPDATE
- BEFORE DELETE
- AFTER DELETE

---

## Creating a Trigger

```sql
DELIMITER $$

CREATE TRIGGER employee_insert
AFTER INSERT ON employee_salary
FOR EACH ROW
BEGIN

INSERT INTO employee_demographics
(employee_id, first_name, last_name)

VALUES
(NEW.employee_id,
 NEW.first_name,
 NEW.last_name);

END $$

DELIMITER ;
```

---

## Explanation

This trigger executes **after** a new row is inserted into the `employee_salary` table.

Whenever a new employee is added:

1. MySQL automatically copies
   - employee_id
   - first_name
   - last_name

2. These values are inserted into the `employee_demographics` table.

### Understanding `NEW`

`NEW` refers to the row being inserted.

Example:

```sql
NEW.employee_id
```

means

> The employee_id of the newly inserted row.

Similarly,

```sql
NEW.first_name
NEW.last_name
```

retrieve the values from the new record.

---

## Insert a New Employee

```sql
INSERT INTO employee_salary
(employee_id,
 first_name,
 last_name,
 occupation,
 salary,
 dept_id)

VALUES
(13,
 'Light',
 'Yagami',
 'entertainment',
 1000000,
 NULL);
```

---

## What Happens?

The record is inserted into:

```text
employee_salary
```

Immediately afterward, the trigger automatically inserts

```text
employee_id
first_name
last_name
```

into

```text
employee_demographics
```

No additional INSERT statement is required.

---

## Verify the Result

```sql
SELECT *
FROM employee_salary;
```

and

```sql
SELECT *
FROM employee_demographics;
```

You'll notice the new employee exists in **both** tables.

---

# 4. Events

## What is an Event?

A **MySQL Event** is similar to a scheduled task (or cron job).

It runs automatically at a specified time or interval without user intervention.

Examples:

- Delete old records
- Archive data
- Update statistics
- Send reminders
- Clean logs

---

## Creating an Event

```sql
DELIMITER $$

CREATE EVENT delete_retairees

ON SCHEDULE EVERY 30 SECOND

DO

BEGIN

DELETE
FROM employee_demographics
WHERE age >= 60;

END $$

DELIMITER ;
```

---

## Explanation

This event executes every **30 seconds**.

Each time it runs, it deletes employees whose age is **60 or older**.

Equivalent SQL:

```sql
DELETE
FROM employee_demographics
WHERE age >= 60;
```

is executed automatically every 30 seconds.

---

# How Events Work

```text
Time = 0 sec
      ↓
Runs DELETE

30 sec later
      ↓
Runs DELETE again

30 sec later
      ↓
Runs DELETE again

Continues automatically...
```

---

## Project Summary