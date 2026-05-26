/*
    Task 2 – Table Structure and Metadata Analysis
    
*/

USE AdventureWorks2022;
GO

-- =============================================================================
-- Helper: Column metadata via INFORMATION_SCHEMA.COLUMNS
-- =============================================================================

-- Production.Product
SELECT
    c.TABLE_SCHEMA,
    c.TABLE_NAME,
    c.COLUMN_NAME,
    c.DATA_TYPE,
    c.CHARACTER_MAXIMUM_LENGTH,
    c.NUMERIC_PRECISION,
    c.NUMERIC_SCALE,
    c.IS_NULLABLE,
    c.COLUMN_DEFAULT
FROM INFORMATION_SCHEMA.COLUMNS AS c
WHERE c.TABLE_SCHEMA = 'Production'
  AND c.TABLE_NAME = 'Product'
ORDER BY c.ORDINAL_POSITION;
GO

-- Sales.SalesOrderHeader
SELECT
    c.TABLE_SCHEMA,
    c.TABLE_NAME,
    c.COLUMN_NAME,
    c.DATA_TYPE,
    c.CHARACTER_MAXIMUM_LENGTH,
    c.NUMERIC_PRECISION,
    c.NUMERIC_SCALE,
    c.IS_NULLABLE,
    c.COLUMN_DEFAULT
FROM INFORMATION_SCHEMA.COLUMNS AS c
WHERE c.TABLE_SCHEMA = 'Sales'
  AND c.TABLE_NAME = 'SalesOrderHeader'
ORDER BY c.ORDINAL_POSITION;
GO

-- HumanResources.Employee
SELECT
    c.TABLE_SCHEMA,
    c.TABLE_NAME,
    c.COLUMN_NAME,
    c.DATA_TYPE,
    c.CHARACTER_MAXIMUM_LENGTH,
    c.NUMERIC_PRECISION,
    c.NUMERIC_SCALE,
    c.IS_NULLABLE,
    c.COLUMN_DEFAULT
FROM INFORMATION_SCHEMA.COLUMNS AS c
WHERE c.TABLE_SCHEMA = 'HumanResources'
  AND c.TABLE_NAME = 'Employee'
ORDER BY c.ORDINAL_POSITION;
GO

-- Purchasing.Vendor
SELECT
    c.TABLE_SCHEMA,
    c.TABLE_NAME,
    c.COLUMN_NAME,
    c.DATA_TYPE,
    c.CHARACTER_MAXIMUM_LENGTH,
    c.NUMERIC_PRECISION,
    c.NUMERIC_SCALE,
    c.IS_NULLABLE,
    c.COLUMN_DEFAULT
FROM INFORMATION_SCHEMA.COLUMNS AS c
WHERE c.TABLE_SCHEMA = 'Purchasing'
  AND c.TABLE_NAME = 'Vendor'
ORDER BY c.ORDINAL_POSITION;
GO

-- =============================================================================
-- Primary key information via INFORMATION_SCHEMA.TABLE_CONSTRAINTS
-- =============================================================================
SELECT
    tc.TABLE_SCHEMA,
    tc.TABLE_NAME,
    tc.CONSTRAINT_NAME,
    tc.CONSTRAINT_TYPE,
    kcu.COLUMN_NAME,
    kcu.ORDINAL_POSITION
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS AS tc
INNER JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE AS kcu
    ON tc.CONSTRAINT_NAME = kcu.CONSTRAINT_NAME
   AND tc.TABLE_SCHEMA = kcu.TABLE_SCHEMA
   AND tc.TABLE_NAME = kcu.TABLE_NAME
WHERE tc.CONSTRAINT_TYPE = 'PRIMARY KEY'
  AND (
        (tc.TABLE_SCHEMA = 'Production' AND tc.TABLE_NAME = 'Product')
     OR (tc.TABLE_SCHEMA = 'Sales' AND tc.TABLE_NAME = 'SalesOrderHeader')
     OR (tc.TABLE_SCHEMA = 'HumanResources' AND tc.TABLE_NAME = 'Employee')
     OR (tc.TABLE_SCHEMA = 'Purchasing' AND tc.TABLE_NAME = 'Vendor')
      )
ORDER BY tc.TABLE_SCHEMA, tc.TABLE_NAME, kcu.ORDINAL_POSITION;
GO

