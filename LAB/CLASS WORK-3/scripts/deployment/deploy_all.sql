/*
    Task 10 - SQLCMD Master Deployment Script
    Automates deployment of all operational reporting components.


*/

:setvar DatabaseName AdventureWorks2022

/*
    Set ScriptsPath to the full path of your scripts folder.
    Example (update drive/path if yours differs):
    D:\ITS\SEM-2\SQL SERVER\SUBMITION\LAB\CLASS WORK-3\scripts
*/
:setvar ScriptsPath "D:\ITS\SEM-2\SQL SERVER\SUBMITION\LAB\CLASS WORK-3\scripts\"

USE $(DatabaseName);
GO

PRINT N'============================================================';
PRINT N'Operational Reporting Deployment - Stage 1: Schema';
PRINT N'============================================================';
:r "D:\ITS\SEM-2\SQL SERVER\SUBMITION\LAB\CLASS WORK-3\scripts\\schema\create_schema.sql"
GO

PRINT N'============================================================';
PRINT N'Operational Reporting Deployment - Stage 2: Functions';
PRINT N'============================================================';
:r "D:\ITS\SEM-2\SQL SERVER\SUBMITION\LAB\CLASS WORK-3\scripts\\functions\ufn_GetFullName.sql"
:r "D:\ITS\SEM-2\SQL SERVER\SUBMITION\LAB\CLASS WORK-3\scripts\\functions\ufn_GetProductsByColor.sql"
GO

PRINT N'============================================================';
PRINT N'Operational Reporting Deployment - Stage 3: Stored Procedures';
PRINT N'============================================================';
:r "D:\ITS\SEM-2\SQL SERVER\SUBMITION\LAB\CLASS WORK-3\scripts\procedures\usp_GetEmployeesByJobTitle.sql"
:r "D:\ITS\SEM-2\SQL SERVER\SUBMITION\LAB\CLASS WORK-3\scripts\procedures\usp_GetInventoryAnalysis.sql"
GO

PRINT N'============================================================';
PRINT N'Operational Reporting Deployment - Stage 4: Variable Scripts';
PRINT N'============================================================';
:r "D:\ITS\SEM-2\SQL SERVER\SUBMITION\LAB\CLASS WORK-3\scripts\variables\variable_examples.sql"
GO

PRINT N'============================================================';
PRINT N'Operational Reporting Deployment - Stage 5: SQLCMD Examples';
PRINT N'============================================================';
:r "D:\ITS\SEM-2\SQL SERVER\SUBMITION\LAB\CLASS WORK-3\scripts\variables\sqlcmd_examples.sql"
GO

PRINT N'============================================================';
PRINT N'Operational Reporting Deployment - Stage 6: Validation';
PRINT N'============================================================';

SELECT OperationalReporting.ufn_GetFullName(N'John', N'Smith') AS FullNameExample;
GO

SELECT
    ProductID,
    ProductName,
    Color,
    ListPrice
FROM OperationalReporting.ufn_GetProductsByColor(N'Red')
ORDER BY ProductName;
GO

EXEC OperationalReporting.usp_GetEmployeesByJobTitle
    @JobTitle = N'Sales Representative',
    @MinimumVacationHours = 30;
GO

EXEC OperationalReporting.usp_GetInventoryAnalysis
    @ReorderThreshold = 500;
GO

PRINT N'Operational Reporting deployment completed successfully.';
GO


