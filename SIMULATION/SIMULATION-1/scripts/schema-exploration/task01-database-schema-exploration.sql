/*
    Task 1 – Database and Schema Exploration

*/

USE AdventureWorks2022;
GO

-- =============================================================================
-- 1.1 Display all schemas alphabetically
-- =============================================================================
SELECT
    s.name              AS SchemaName,
    s.schema_id         AS SchemaID,
    USER_NAME(s.principal_id) AS SchemaOwner
FROM sys.schemas AS s
WHERE s.name NOT IN ('sys', 'INFORMATION_SCHEMA')
ORDER BY s.name;
GO

-- =============================================================================
-- 1.2 Display all tables within each schema (schema, table name)
-- =============================================================================
SELECT
    t.TABLE_SCHEMA      AS SchemaName,
    t.TABLE_NAME        AS TableName,
    t.TABLE_TYPE        AS TableType
FROM INFORMATION_SCHEMA.TABLES AS t
WHERE t.TABLE_TYPE = 'BASE TABLE'
ORDER BY t.TABLE_SCHEMA, t.TABLE_NAME;
GO

-- =============================================================================
-- 1.3 Total number of tables per schema
-- =============================================================================
SELECT
    t.TABLE_SCHEMA      AS SchemaName,
    COUNT(*)            AS TableCount
FROM INFORMATION_SCHEMA.TABLES AS t
WHERE t.TABLE_TYPE = 'BASE TABLE'
GROUP BY t.TABLE_SCHEMA
ORDER BY TableCount DESC, t.TABLE_SCHEMA;
GO

-- =============================================================================
-- Example: All Production schema tables
-- =============================================================================
SELECT
    t.TABLE_SCHEMA      AS SchemaName,
    t.TABLE_NAME        AS TableName
FROM INFORMATION_SCHEMA.TABLES AS t
WHERE t.TABLE_SCHEMA = 'Production'
  AND t.TABLE_TYPE = 'BASE TABLE'
ORDER BY t.TABLE_NAME;
GO

-- =============================================================================
-- Example: All HumanResources schema tables
-- =============================================================================
SELECT
    t.TABLE_SCHEMA      AS SchemaName,
    t.TABLE_NAME        AS TableName
FROM INFORMATION_SCHEMA.TABLES AS t
WHERE t.TABLE_SCHEMA = 'HumanResources'
  AND t.TABLE_TYPE = 'BASE TABLE'
ORDER BY t.TABLE_NAME;
GO
