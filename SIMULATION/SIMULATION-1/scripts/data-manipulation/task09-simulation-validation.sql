/*
    Task 9 – Simulation Validation Queries
    Validates Simulation2 schema, custom tables, DML results
    Objects: SELECT, sp_help, INFORMATION_SCHEMA.COLUMNS
*/

USE AdventureWorks2022;
GO

-- =============================================================================
-- 9.1 All tables created in Simulation2 schema
-- =============================================================================
SELECT
    s.name              AS SchemaName,
    t.name              AS TableName,
    t.create_date       AS CreatedDate,
    t.modify_date       AS ModifiedDate
FROM sys.tables AS t
INNER JOIN sys.schemas AS s
    ON t.schema_id = s.schema_id
WHERE s.name = 'Simulation2'
ORDER BY t.name;
GO

-- Alternative via INFORMATION_SCHEMA
SELECT
    TABLE_SCHEMA,
    TABLE_NAME,
    TABLE_TYPE
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_SCHEMA = 'Simulation2'
ORDER BY TABLE_NAME;
GO

-- =============================================================================
-- 9.2 All records in custom simulation tables
-- =============================================================================
SELECT 'Simulation2.EmployeeTraining' AS TableName;
SELECT * FROM Simulation2.EmployeeTraining ORDER BY TrainingID;

SELECT 'Simulation2.ProductAudit' AS TableName;
SELECT * FROM Simulation2.ProductAudit ORDER BY AuditID;
GO

-- =============================================================================
-- 9.3 Metadata for custom simulation tables (INFORMATION_SCHEMA.COLUMNS)
-- =============================================================================
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
WHERE c.TABLE_SCHEMA = 'Simulation2'
ORDER BY c.TABLE_NAME, c.ORDINAL_POSITION;
GO

-- =============================================================================
-- 9.4 sp_help for custom tables
-- =============================================================================
EXEC sp_help 'Simulation2.EmployeeTraining';
GO

EXEC sp_help 'Simulation2.ProductAudit';
GO

-- =============================================================================
-- 9.5 Verification of updated records (completion status / comments)
-- =============================================================================
SELECT
    TrainingID,
    TrainingName,
    CompletionStatus,
    HoursRequired
FROM Simulation2.EmployeeTraining
WHERE CompletionStatus IN ('Completed', 'In Progress')
ORDER BY TrainingID;

SELECT
    AuditID,
    ProductID,
    NewListPrice,
    AuditComments
FROM Simulation2.ProductAudit
WHERE AuditComments LIKE '%approved%'
   OR AuditComments LIKE '%repricing%'
ORDER BY AuditID;
GO

-- =============================================================================
-- 9.6 Verification of deleted records (should return zero rows)
-- =============================================================================
-- Pending training before March 2025 should no longer exist
SELECT COUNT(*) AS RemainingStalePendingTraining
FROM Simulation2.EmployeeTraining
WHERE CompletionStatus = 'Pending'
  AND TrainingDate < '2025-03-01';

-- Audit with "no pricing action" comment should no longer exist
SELECT COUNT(*) AS RemainingNoActionAudits
FROM Simulation2.ProductAudit
WHERE AuditComments LIKE '%no pricing action%';
GO

-- =============================================================================
-- 9.7 Row counts summary
-- =============================================================================
-- =========================================================
-- 9.7 Row counts summary
-- =========================================================

SELECT 
    
    COUNT(*) 
FROM Simulation2.EmployeeTraining

UNION ALL

SELECT 
   
    COUNT(*) 
FROM Simulation2.ProductAudit;
GO