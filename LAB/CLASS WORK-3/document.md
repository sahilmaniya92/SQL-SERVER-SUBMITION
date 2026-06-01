# Step-by-Step Screenshot Documentation

**Lab 4 — Introduction to T-SQL Scripting, Variables, Stored Procedures, Functions, and SQLCMD Automation**

| Field | Value |
| --- | --- |
| **Student Name** | SAHIL MANIYA   , PARTH PATEL |
| **Student Number** | N01769967 ,  N01769967  |

Use this document as your checklist when capturing proof of execution. Save every screenshot in the `screenshots/` folder using the suggested file names below.

For lab overview, script locations, and execution instructions, see [README.md](README.md).

---

---

## Task 1 — Create Operational Reporting Schema

**Script:** `scripts/schema/create_schema.sql`  
**Screenshot:** ![Alt Text](/screenshots/TASK-1.png)


---

## Task 2 — T-SQL Variables and Dynamic Reporting Filters

**Script:** `scripts/variables/variable_examples.sql` (first section only, or full script)  
**Screenshots:** ![Alt Text](/screenshots/TASK-2.1.png)

![Alt Text](/screenshots/TASK-2.2.png)




---

## Task 3 — Conditional Business Logic (IF…ELSE)

**Script:** `scripts/variables/variable_examples.sql` (Task 3 section)  
**Screenshots:** ![Alt Text](/screenshots/TASK-3.png)




---

## Task 4 — Employee Stored Procedure

**Script:** `scripts/procedures/usp_GetEmployeesByJobTitle.sql`  
**Screenshots:** ![Alt Text](/screenshots/TASK-4.png)


---

## Task 5 — Inventory Analysis Stored Procedure

**Script:** `scripts/procedures/usp_GetInventoryAnalysis.sql`  
**Screenshots:** ![Alt Text](/screenshots/TASK-5.png)




---

## Task 6 — Scalar-Valued Function

**Script:** `scripts/functions/ufn_GetFullName.sql`  
**Screenshots:** ![Alt Text](/screenshots/TASK-6.png)



```sql
SELECT OperationalReporting.ufn_GetFullName(N'John', NULL) AS FullName;
SELECT OperationalReporting.ufn_GetFullName(NULL, N'Smith') AS FullName;
```

---

## Task 7 — Inline Table-Valued Function

**Script:** `scripts/functions/ufn_GetProductsByColor.sql`  
**Screenshots:** ![Alt Text](/screenshots/TASK-7.png)


```sql
SELECT *
FROM OperationalReporting.ufn_GetProductsByColor(N'Red');
```

---

## Task 8 — Execute and Validate Reporting Functions
**Screenshots:** ![Alt Text](/screenshots/TASK-8.png)



```sql
SELECT OperationalReporting.ufn_GetFullName(N'John', N'Smith');

SELECT *
FROM OperationalReporting.ufn_GetProductsByColor(N'Red');
```

---

## Task 9 — SQLCMD Variables and Parameterized Execution

**Script:** `scripts/variables/sqlcmd_examples.sql`  
**Screenshots:** ![Alt Text](/screenshots/TASK-9.png)



---

## Task 10 — SQLCMD Deployment Automation

**Script:** `scripts/deployment/deploy_all.sql`  
**Screenshots:** ![Alt Text](/screenshots/task-10.1.png)

**Screenshots:** ![Alt Text](/screenshots/TASK-10.2.png)




---

