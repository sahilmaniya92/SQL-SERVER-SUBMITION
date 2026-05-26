/*
    Task 4 – Aggregate Functions and Business Analytics
    Functions: COUNT, AVG, MIN, MAX, SUM, GROUP BY
*/

USE AdventureWorks2022;
GO

-- =============================================================================
-- 4.1 Total number of products
-- =============================================================================
SELECT
    COUNT(*) AS TotalProducts
FROM Production.Product;
GO

-- =============================================================================
-- 4.2 Average product price (ListPrice)
-- =============================================================================
SELECT
    AVG(p.ListPrice) AS AverageListPrice
FROM Production.Product AS p
WHERE p.ListPrice IS NOT NULL;
GO

-- =============================================================================
-- 4.3 Highest and lowest product prices
-- =============================================================================
SELECT
    MIN(p.ListPrice) AS LowestListPrice,
    MAX(p.ListPrice) AS HighestListPrice
FROM Production.Product AS p
WHERE p.ListPrice IS NOT NULL;
GO

-- =============================================================================
-- 4.4 Total number of employees
-- =============================================================================
SELECT
    COUNT(*) AS TotalEmployees
FROM HumanResources.Employee;
GO

-- =============================================================================
-- 4.5 Number of vendors per CreditRating
-- =============================================================================
SELECT
    v.CreditRating              AS CreditRating,
    COUNT(*)                    AS VendorCount
FROM Purchasing.Vendor AS v
GROUP BY v.CreditRating
ORDER BY v.CreditRating;
GO

-- =============================================================================
-- 4.6 Total sales orders by customer
-- =============================================================================
SELECT
    soh.CustomerID              AS CustomerID,
    COUNT(soh.SalesOrderID)     AS OrderCount,
    SUM(soh.TotalDue)           AS TotalAmountDue
FROM Sales.SalesOrderHeader AS soh
GROUP BY soh.CustomerID
ORDER BY OrderCount DESC, TotalAmountDue DESC;
GO
