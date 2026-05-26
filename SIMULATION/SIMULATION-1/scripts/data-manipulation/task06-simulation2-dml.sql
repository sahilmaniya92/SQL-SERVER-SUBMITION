/*
    Task 6 – Data Manipulation Operations
    Schema: Simulation2
    Tables: Simulation2.EmployeeTraining, Simulation2.ProductAudit
    Operations: CREATE SCHEMA/TABLES, INSERT, UPDATE, DELETE, verification
*/

USE AdventureWorks2022;
GO

-- =============================================================================
-- 6.1 Create Simulation2 schema and tables
-- =============================================================================
IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = 'Simulation2')
BEGIN
    EXEC('CREATE SCHEMA Simulation2');
END;
GO

IF OBJECT_ID('Simulation2.EmployeeTraining', 'U') IS NOT NULL
    DROP TABLE Simulation2.EmployeeTraining;
GO

IF OBJECT_ID('Simulation2.ProductAudit', 'U') IS NOT NULL
    DROP TABLE Simulation2.ProductAudit;
GO

CREATE TABLE Simulation2.EmployeeTraining
(
    TrainingID          INT IDENTITY(1,1) NOT NULL,
    EmployeeID          INT NOT NULL,
    TrainingName        NVARCHAR(100) NOT NULL,
    TrainingDate        DATE NOT NULL,
    CompletionStatus    NVARCHAR(20) NOT NULL
        CONSTRAINT CK_EmployeeTraining_Status
        CHECK (CompletionStatus IN ('Pending', 'In Progress', 'Completed')),
    HoursRequired       DECIMAL(5,2) NOT NULL DEFAULT 8.00,
    CONSTRAINT PK_EmployeeTraining PRIMARY KEY (TrainingID)
);
GO

CREATE TABLE Simulation2.ProductAudit
(
    AuditID             INT IDENTITY(1,1) NOT NULL,
    ProductID           INT NOT NULL,
    AuditDate           DATETIME2 NOT NULL DEFAULT SYSDATETIME(),
    PreviousListPrice   DECIMAL(19,4) NULL,
    NewListPrice        DECIMAL(19,4) NULL,
    AuditComments       NVARCHAR(500) NULL,
    AuditedBy           NVARCHAR(100) NOT NULL DEFAULT SUSER_SNAME(),
    CONSTRAINT PK_ProductAudit PRIMARY KEY (AuditID)
);
GO

-- =============================================================================
-- 6.2 INSERT – at least 5 records per table
-- =============================================================================
INSERT INTO Simulation2.EmployeeTraining
    (EmployeeID, TrainingName, TrainingDate, CompletionStatus, HoursRequired)
VALUES
    (1, 'SQL Server Fundamentals', '2025-01-15', 'Completed', 16.00),
    (2, 'Workplace Safety', '2025-02-01', 'In Progress', 8.00),
    (3, 'Leadership Essentials', '2025-02-10', 'Pending', 12.00),
    (4, 'Data Privacy Compliance', '2025-03-05', 'Completed', 4.00),
    (5, 'Inventory Management Systems', '2025-03-20', 'In Progress', 10.00),
    (6, 'Customer Service Excellence', '2025-04-01', 'Pending', 6.00);
GO

INSERT INTO Simulation2.ProductAudit
    (ProductID, AuditDate, PreviousListPrice, NewListPrice, AuditComments, AuditedBy)
VALUES
    (680, '2025-01-10 09:00:00', 1431.50, 1499.00, 'Annual price review – increase applied', 'Lab2Student'),
    (706, '2025-01-11 10:30:00', 35.00, 35.00, 'No change – price verified against catalog', 'Lab2Student'),
    (707, '2025-01-12 14:15:00', 33.64, 34.99, 'Minor adjustment for margin alignment', 'Lab2Student'),
    (708, '2025-01-13 11:00:00', 21.49, 21.49, 'Audit complete – no pricing action required', 'Lab2Student'),
    (709, '2025-01-14 16:45:00', 20.19, 19.99, 'Promotional discount recorded', 'Lab2Student'),
    (710, '2025-01-15 08:20:00', 4.99, 5.49, 'Cost increase passed to list price', 'Lab2Student');
GO

-- Verification after INSERT
SELECT 'EmployeeTraining after INSERT' AS VerificationStep;
SELECT * FROM Simulation2.EmployeeTraining ORDER BY TrainingID;

SELECT 'ProductAudit after INSERT' AS VerificationStep;
SELECT * FROM Simulation2.ProductAudit ORDER BY AuditID;
GO

-- =============================================================================
-- 6.3 UPDATE – training completion statuses and audit comments
-- =============================================================================
UPDATE Simulation2.EmployeeTraining
SET CompletionStatus = 'Completed'
WHERE TrainingName IN ('Workplace Safety', 'Inventory Management Systems');
GO

UPDATE Simulation2.EmployeeTraining
SET CompletionStatus = 'In Progress',
    HoursRequired = 14.00
WHERE TrainingName = 'Leadership Essentials';
GO

UPDATE Simulation2.ProductAudit
SET AuditComments = 'Reviewed and approved by purchasing manager'
WHERE ProductID IN (680, 707);
GO

UPDATE Simulation2.ProductAudit
SET AuditComments = 'Flagged for Q2 repricing review',
    NewListPrice = NewListPrice + 1.00
WHERE ProductID = 710;
GO

-- Verification after UPDATE
SELECT 'EmployeeTraining after UPDATE' AS VerificationStep;
SELECT TrainingID, EmployeeID, TrainingName, CompletionStatus, HoursRequired
FROM Simulation2.EmployeeTraining
ORDER BY TrainingID;

SELECT 'ProductAudit after UPDATE' AS VerificationStep;
SELECT AuditID, ProductID, NewListPrice, AuditComments
FROM Simulation2.ProductAudit
ORDER BY AuditID;
GO

-- =============================================================================
-- 6.4 DELETE – records based on business conditions
-- =============================================================================
-- Remove pending training records older than March 2025 (cleanup of stale enrollments)
DELETE FROM Simulation2.EmployeeTraining
WHERE CompletionStatus = 'Pending'
  AND TrainingDate < '2025-03-01';
GO

-- Remove audit rows with no price change and generic comment (noise reduction)
DELETE FROM Simulation2.ProductAudit
WHERE PreviousListPrice = NewListPrice
  AND AuditComments LIKE '%no pricing action%';
GO

-- Verification after DELETE
SELECT 'EmployeeTraining after DELETE' AS VerificationStep;
SELECT * FROM Simulation2.EmployeeTraining ORDER BY TrainingID;

SELECT 'ProductAudit after DELETE' AS VerificationStep;
SELECT * FROM Simulation2.ProductAudit ORDER BY AuditID;
GO
