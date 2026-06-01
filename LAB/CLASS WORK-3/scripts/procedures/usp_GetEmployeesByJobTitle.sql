/*
    Task 4 - Employee Operational Reporting Stored Procedure
*/

USE AdventureWorks2022;
GO

IF OBJECT_ID(N'OperationalReporting.usp_GetEmployeesByJobTitle', N'P') IS NOT NULL
BEGIN
    DROP PROCEDURE OperationalReporting.usp_GetEmployeesByJobTitle;
END
GO

CREATE PROCEDURE OperationalReporting.usp_GetEmployeesByJobTitle
    @JobTitle             NVARCHAR(50),
    @MinimumVacationHours SMALLINT
AS
BEGIN
    SET NOCOUNT ON;

    /* Parameter validation */
    IF @JobTitle IS NULL OR LTRIM(RTRIM(@JobTitle)) = N''
    BEGIN
        RAISERROR(N'Job title parameter is required.', 16, 1);
        RETURN;
    END

    IF @MinimumVacationHours IS NULL OR @MinimumVacationHours < -40 OR @MinimumVacationHours > 240
    BEGIN
        RAISERROR(N'Minimum vacation hours must be between -40 and 240.', 16, 1);
        RETURN;
    END

    /* Employee reporting query */
    SELECT
        e.BusinessEntityID AS EmployeeID,
        OperationalReporting.ufn_GetFullName(p.FirstName, p.LastName) AS EmployeeFullName,
        e.JobTitle,
        e.VacationHours
    FROM HumanResources.Employee AS e
    INNER JOIN Person.Person AS p
        ON e.BusinessEntityID = p.BusinessEntityID
    WHERE e.JobTitle = @JobTitle
      AND e.VacationHours > @MinimumVacationHours
    ORDER BY e.VacationHours DESC;
END
GO



EXEC OperationalReporting.usp_GetEmployeesByJobTitle
    @JobTitle = N'Sales Representative',
    @MinimumVacationHours = 30;