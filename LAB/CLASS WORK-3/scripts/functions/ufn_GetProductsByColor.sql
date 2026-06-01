/*
    Task 7 - Inline Table-Valued Function: Products by Color
*/

USE AdventureWorks2022;
GO

IF OBJECT_ID(N'OperationalReporting.ufn_GetProductsByColor', N'IF') IS NOT NULL
BEGIN
    DROP FUNCTION OperationalReporting.ufn_GetProductsByColor;
END
GO

CREATE FUNCTION OperationalReporting.ufn_GetProductsByColor
(
    @ProductColor NVARCHAR(15)
)
RETURNS TABLE
AS
RETURN
(
    SELECT
        ProductID,
        ProductName,
        Color,
        ListPrice
    FROM
    (
        SELECT TOP (2147483647)
            ProductID,
            Name AS ProductName,
            Color,
            ListPrice
        FROM Production.Product
        WHERE Color = @ProductColor
          AND Color IS NOT NULL
        ORDER BY Name
    ) AS OrderedProducts
);
GO
SELECT *
FROM OperationalReporting.ufn_GetProductsByColor(N'Red');