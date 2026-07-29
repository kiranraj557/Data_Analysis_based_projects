# Parks and Recreation SQL Database

## Overview

This project creates a sample **MySQL relational database** named **Parks_and_Recreation**. It is designed as a practice database for learning SQL concepts such as database creation, table design, data insertion, joins, filtering, aggregation, and other SQL operations.

---

# Project Structure

The database contains **three tables**:

1. **employee_demographics**
2. **employee_salary**
3. **parks_departments**

These tables demonstrate how employee information can be separated into logical entities and connected using common fields.

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

# What the Script Does

The SQL script performs the following steps:

## Step 1: Remove Existing Database

```sql
DROP DATABASE IF EXISTS Parks_and_Recreation;
```

Deletes the existing database if it already exists to ensure a clean setup.

---

## Step 2: Create Database

```sql
CREATE DATABASE Parks_and_Recreation;
```

Creates a new database.

---

## Step 3: Select Database

```sql
USE Parks_and_Recreation;
```

Makes the newly created database the active database.

---

## Step 4: Create Tables

Creates the following tables:

- employee_demographics
- employee_salary
- parks_departments

Each table is designed with appropriate data types and primary keys.

---




