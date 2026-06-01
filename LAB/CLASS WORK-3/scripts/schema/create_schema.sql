/*
    Task 1 - Create Operational Reporting Schema
    Validates schema existence before creation for idempotent deployment.
*/

USE AdventureWorks2022;
GO

IF NOT EXISTS (
    SELECT 1
    FROM sys.schemas
    WHERE name = N'OperationalReporting'
)
BEGIN
    EXEC(N'CREATE SCHEMA OperationalReporting AUTHORIZATION dbo;');

    PRINT N'Schema [OperationalReporting] created successfully.';
END
ELSE
BEGIN
    PRINT N'Schema [OperationalReporting] already exists. No action required.';
END
GO


SELECT name
FROM sys.schemas
WHERE name = N'OperationalReporting';