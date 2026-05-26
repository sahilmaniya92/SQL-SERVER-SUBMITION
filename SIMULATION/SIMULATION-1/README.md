# Lab 2 – AdventureWorks2022 SQL Server Simulation

## Student Information

| Field | Value |
|-------|-------|
| **Student Name** | *Sahil Maniya* |
| **Student Number** | *N01769967* |
| **Course** | SQL Server / Database Fundamentals |
| **Simulation** | Fundamentals of SQL Server Schema Exploration and Data Manipulation |

---

## Simulation Overview

This repository contains Transact-SQL scripts for a hands-on simulation using the **AdventureWorks2022** sample database on **Microsoft SQL Server 2022**. The work covers:

- Schema and metadata exploration (`sys` catalog views, `INFORMATION_SCHEMA`)
- Operational data retrieval with filtering and sorting
- Aggregate analytics and `INNER JOIN` reporting
- Controlled `INSERT`, `UPDATE`, and `DELETE` in a custom **Simulation2** schema
- Constraint analysis and business reporting queries

All scripts are intended for execution in **SQL Server Management Studio (SSMS)** only—no visual designers or ORMs.

---




## Repository Structure

```
LAB-2/
├── README.md                          # This file
├── scripts/
│   |
│   ├── schema-exploration/
│   │   ├── task01-database-schema-exploration.sql
│   │   ├── task02-table-structure-metadata.sql
│   │   └── task07-constraint-analysis.sql
│   ├── data-retrieval/
│   │   ├── task03-basic-data-retrieval.sql
│   │   ├── task04-aggregate-functions.sql
│   │   └── task05-inner-join-operations.sql
│   ├── data-manipulation/
│   │   ├── task06-simulation2-dml.sql
│   │   └── task09-simulation-validation.sql
│   └── reporting/
│       └── task08-business-reporting.sql
├── screenshots/                       # SSMS execution screenshots (add your own)
└── documentation/
    └── documentation.md             # Task-to-script mapping and screenshot checklist
```

---

## Query Explanations (Summary)

### Task 1 – Schema Exploration

Uses `sys.schemas` to list database schemas and `INFORMATION_SCHEMA.TABLES` to list base tables. A `GROUP BY` query counts tables per schema. Example filters show **Production** and **HumanResources** tables.

### Task 2 – Metadata Analysis

`INFORMATION_SCHEMA.COLUMNS` returns column names, data types, lengths, and nullability for four core business tables. Primary keys are resolved through `INFORMATION_SCHEMA.TABLE_CONSTRAINTS` joined to `KEY_COLUMN_USAGE`. `sp_help` provides extended property and index detail.

### Task 3 – Basic Retrieval

Demonstrates `WHERE` filtering (price, hire date, credit rating) and `ORDER BY` sorting. Customer names require a join to `Person.Person` because names are not stored on `Sales.Customer` directly.

### Task 4 – Aggregates

`COUNT`, `AVG`, `MIN`, and `MAX` summarize products and employees. `GROUP BY` breaks down vendor counts by credit rating and order totals by customer.

### Task 5 – JOIN Operations

`INNER JOIN` chains related tables: products to categories, employees to departments (current assignment where `EndDate IS NULL`), sales lines to customers, and vendors to purchase orders. Table aliases shorten query text and clarify column sources.

### Task 6 – Data Manipulation

Creates schema **Simulation2** with `EmployeeTraining` and `ProductAudit`. Inserts six rows per table, updates completion statuses and audit comments, then deletes rows matching business rules (stale pending training, unchanged price audits). Verification `SELECT` statements run after each DML phase.

### Task 7 – Constraints

Identifies primary keys, foreign keys, check constraints, and defaults on `Production.Product`, `Sales.Customer`, and `Purchasing.ProductVendor` using catalog views and `INFORMATION_SCHEMA`.

### Task 8 – Business Reporting

Produces top-priced products, manager job titles (`LIKE '%Manager%'`), best-rated vendors, monthly sales rollups, inventory by location, and per-customer purchase totals.

### Task 9 – Validation

Confirms `Simulation2` objects exist, lists remaining rows after DML, shows column metadata, and uses count queries to prove deleted rows no longer match delete criteria.

---





