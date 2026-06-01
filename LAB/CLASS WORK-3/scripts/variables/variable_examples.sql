/*
    Task 2 - T-SQL Variables and Dynamic Reporting Filters
    Task 3 - Conditional Business Logic Using IF...ELSE
*/

USE AdventureWorks2022;
GO

/* -------------------------------------------------------------------------
   Task 2: Variable-based employee and product reporting
   ------------------------------------------------------------------------- */

DECLARE @EmployeeJobTitle       NVARCHAR(50) = N'';
DECLARE @MinimumVacationHours   SMALLINT     = 0;
DECLARE @ProductSafetyStockLevel SMALLINT    = 0;

SET @EmployeeJobTitle = N'Sales Representative';
SET @MinimumVacationHours = 40;
SET @ProductSafetyStockLevel = 500;

PRINT N'--- Employee Reporting Filter ---';
PRINT N'Job Title: ' + @EmployeeJobTitle;
PRINT N'Minimum Vacation Hours: ' + CAST(@MinimumVacationHours AS NVARCHAR(10));

SELECT
    e.BusinessEntityID AS EmployeeID,
    p.FirstName,
    p.LastName,
    e.JobTitle,
    e.VacationHours
FROM HumanResources.Employee AS e
INNER JOIN Person.Person AS p
    ON e.BusinessEntityID = p.BusinessEntityID
WHERE e.JobTitle = @EmployeeJobTitle
  AND e.VacationHours > @MinimumVacationHours
ORDER BY e.VacationHours DESC;

PRINT N'--- Product Safety Stock Reporting Filter ---';
PRINT N'Safety Stock Level Threshold: ' + CAST(@ProductSafetyStockLevel AS NVARCHAR(10));

SELECT
    ProductID,
    Name AS ProductName,
    SafetyStockLevel,
    ReorderPoint
FROM Production.Product
WHERE SafetyStockLevel > @ProductSafetyStockLevel
ORDER BY SafetyStockLevel DESC;
GO

/* -------------------------------------------------------------------------
   Task 3: Sales performance classification using IF...ELSE
   ------------------------------------------------------------------------- */

DECLARE @SalesAmount DECIMAL(18, 2) = 0;
DECLARE @SalesClassification NVARCHAR(20) = N'';

SET @SalesAmount = 3500.00;

IF @SalesAmount < 1000
BEGIN
    SET @SalesClassification = N'Low Sales';
END
ELSE IF @SalesAmount BETWEEN 1000 AND 5000
BEGIN
    SET @SalesClassification = N'Medium Sales';
END
ELSE
BEGIN
    SET @SalesClassification = N'High Sales';
END

PRINT N'Sales Amount: ' + CAST(@SalesAmount AS NVARCHAR(20));
PRINT N'Sales Classification: ' + @SalesClassification;
GO
