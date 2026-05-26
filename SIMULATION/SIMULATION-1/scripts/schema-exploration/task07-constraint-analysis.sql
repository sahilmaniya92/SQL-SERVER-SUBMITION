/*
    Task 7 – Data Validation and Constraint Analysis
    Tables: Production.Product, Sales.Customer, Purchasing.ProductVendor
    Objects: INFORMATION_SCHEMA.TABLE_CONSTRAINTS, sys.foreign_keys, sys.check_constraints
*/

USE AdventureWorks2022;
GO

-- =============================================================================
-- 7.1 Primary keys (INFORMATION_SCHEMA.TABLE_CONSTRAINTS)
-- =============================================================================
SELECT
    tc.TABLE_SCHEMA,
    tc.TABLE_NAME,
    tc.CONSTRAINT_NAME,
    tc.CONSTRAINT_TYPE,
    kcu.COLUMN_NAME
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS AS tc
INNER JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE AS kcu
    ON tc.CONSTRAINT_NAME = kcu.CONSTRAINT_NAME
   AND tc.TABLE_SCHEMA = kcu.TABLE_SCHEMA
   AND tc.TABLE_NAME = kcu.TABLE_NAME
WHERE tc.CONSTRAINT_TYPE = 'PRIMARY KEY'
  AND tc.TABLE_SCHEMA IN ('Production', 'Sales', 'Purchasing')
  AND tc.TABLE_NAME IN ('Product', 'Customer', 'ProductVendor')
ORDER BY tc.TABLE_SCHEMA, tc.TABLE_NAME;
GO

-- =============================================================================
-- 7.2 Foreign keys (sys.foreign_keys)
-- =============================================================================
SELECT
    OBJECT_SCHEMA_NAME(fk.parent_object_id)   AS ParentSchema,
    OBJECT_NAME(fk.parent_object_id)          AS ParentTable,
    fk.name                                     AS ForeignKeyName,
    COL_NAME(fkc.parent_object_id, fkc.parent_column_id) AS ParentColumn,
    OBJECT_SCHEMA_NAME(fk.referenced_object_id) AS ReferencedSchema,
    OBJECT_NAME(fk.referenced_object_id)      AS ReferencedTable,
    COL_NAME(fkc.referenced_object_id, fkc.referenced_column_id) AS ReferencedColumn
FROM sys.foreign_keys AS fk
INNER JOIN sys.foreign_key_columns AS fkc
    ON fk.object_id = fkc.constraint_object_id
WHERE OBJECT_SCHEMA_NAME(fk.parent_object_id) IN ('Production', 'Sales', 'Purchasing')
  AND OBJECT_NAME(fk.parent_object_id) IN ('Product', 'Customer', 'ProductVendor')
ORDER BY ParentSchema, ParentTable, ForeignKeyName;
GO

-- =============================================================================
-- 7.3 CHECK constraints (sys.check_constraints)
-- =============================================================================
SELECT
    OBJECT_SCHEMA_NAME(cc.parent_object_id) AS TableSchema,
    OBJECT_NAME(cc.parent_object_id)        AS TableName,
    cc.name                                 AS CheckConstraintName,
    cc.definition                           AS CheckDefinition
FROM sys.check_constraints AS cc
WHERE OBJECT_SCHEMA_NAME(cc.parent_object_id) IN ('Production', 'Sales', 'Purchasing')
  AND OBJECT_NAME(cc.parent_object_id) IN ('Product', 'Customer', 'ProductVendor')
ORDER BY TableSchema, TableName, CheckConstraintName;
GO

-- =============================================================================
-- 7.4 Default constraints (sys.default_constraints)
-- =============================================================================
SELECT
    OBJECT_SCHEMA_NAME(dc.parent_object_id) AS TableSchema,
    OBJECT_NAME(dc.parent_object_id)        AS TableName,
    dc.name                                 AS DefaultConstraintName,
    COL_NAME(dc.parent_object_id, dc.parent_column_id) AS ColumnName,
    dc.definition                           AS DefaultDefinition
FROM sys.default_constraints AS dc
WHERE OBJECT_SCHEMA_NAME(dc.parent_object_id) IN ('Production', 'Sales', 'Purchasing')
  AND OBJECT_NAME(dc.parent_object_id) IN ('Product', 'Customer', 'ProductVendor')
ORDER BY TableSchema, TableName, ColumnName;
GO

-- =============================================================================
-- 7.5 Combined constraint summary (all types via INFORMATION_SCHEMA)
-- =============================================================================
SELECT
    tc.TABLE_SCHEMA,
    tc.TABLE_NAME,
    tc.CONSTRAINT_NAME,
    tc.CONSTRAINT_TYPE
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS AS tc
WHERE tc.TABLE_SCHEMA IN ('Production', 'Sales', 'Purchasing')
  AND tc.TABLE_NAME IN ('Product', 'Customer', 'ProductVendor')
ORDER BY tc.TABLE_SCHEMA, tc.TABLE_NAME, tc.CONSTRAINT_TYPE, tc.CONSTRAINT_NAME;
GO
