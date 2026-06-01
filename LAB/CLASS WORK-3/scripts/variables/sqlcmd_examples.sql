/*
    Task 9 - SQLCMD Variables and Parameterized Deployment Execution
    Enable SQLCMD Mode in SSMS before executing this script.
*/

:setvar ProductColor Red
:setvar MinPrice 1000

USE AdventureWorks2022;
GO

/*
    Retrieve products filtered by SQLCMD variables:
    - Product color must match $(ProductColor)
    - List price must exceed $(MinPrice)
*/
PRINT N'--- SQLCMD Product Reporting ---';
PRINT N'Product Color: $(ProductColor)';
PRINT N'Minimum List Price: $(MinPrice)';

SELECT
    ProductID,
    Name AS ProductName,
    Color,
    ListPrice
FROM Production.Product
WHERE Color = N'$(ProductColor)'
  AND ListPrice > $(MinPrice)
ORDER BY ListPrice DESC;
GO

