# Lab 4 — Introduction to T-SQL Scripting, Variables, Stored Procedures, Functions, and SQLCMD Automation

## Student Information

| Field | Value |
| --- | --- |
| **Student Name** | _[SAHIL MANIYA]_   ,   _[PARTH PATEL]_   |
| **Student Number** | _[N01769967]_  ,   _[N01769967]_   |
| **Course** | SQL Server Developer |
| **Delivery Type** | Group of 2 students |

## Lab Overview

This lab implements reusable T-SQL operational reporting and SQLCMD deployment automation against the **AdventureWorks2022** database. All custom database objects are created in the **OperationalReporting** schema and include:

- Idempotent schema creation
- Variable-based reporting scripts
- Conditional business logic with `IF...ELSE`
- Parameterized stored procedures
- Scalar-valued and inline table-valued functions
- SQLCMD variable examples
- Modular master deployment script


## Folder Structure

```text
scripts/
├── schema/
│   └── create_schema.sql
├── variables/
│   ├── variable_examples.sql
│   └── sqlcmd_examples.sql
├── procedures/
│   ├── usp_GetEmployeesByJobTitle.sql
│   └── usp_GetInventoryAnalysis.sql
├── functions/
│   ├── ufn_GetFullName.sql
│   └── ufn_GetProductsByColor.sql
└── deployment/
    └── deploy_all.sql
screenshots/
README.md
document.md
```


## Screenshot Documentation

Step-by-step screenshot instructions for all lab tasks (Tasks 1–10) are in **[document.md](document.md)**.


Save all screenshots in the `screenshots/` folder.

