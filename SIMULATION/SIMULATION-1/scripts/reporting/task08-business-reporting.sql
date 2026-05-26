/*
    Task 8 – Business Reporting Queries
    Reports: top products, managers, vendors, monthly sales,
             inventory summary, customer purchasing summary
*/

USE AdventureWorks2022;
GO

-- =============================================================================
-- 8.1 Top 10 highest-priced products
-- =============================================================================
SELECT TOP 10
    p.ProductID         AS ProductID,
    p.Name              AS ProductName,
    p.ProductNumber     AS ProductNumber,
    p.ListPrice         AS ListPrice,
    p.Color             AS Color
FROM Production.Product AS p
WHERE p.ListPrice IS NOT NULL
ORDER BY p.ListPrice DESC;
GO

-- =============================================================================
-- 8.2 Employees with job titles containing "Manager"
-- =============================================================================
SELECT
    e.BusinessEntityID  AS EmployeeID,
    p.FirstName         AS FirstName,
    p.LastName          AS LastName,
    e.JobTitle          AS JobTitle,
    e.HireDate          AS HireDate,
    e.VacationHours     AS VacationHours
FROM HumanResources.Employee AS e
INNER JOIN Person.Person AS p
    ON e.BusinessEntityID = p.BusinessEntityID
WHERE e.JobTitle LIKE '%Manager%'
ORDER BY p.LastName, p.FirstName;
GO

-- =============================================================================
-- 8.3 Vendors with highest credit ratings (CreditRating = 1)
-- =============================================================================
SELECT
    v.BusinessEntityID  AS VendorID,
    v.Name              AS VendorName,
    v.CreditRating      AS CreditRating,
    v.PreferredVendorStatus AS PreferredVendor,
    v.ActiveFlag        AS IsActive
  
FROM Purchasing.Vendor AS v
WHERE v.CreditRating = 1
ORDER BY v.Name;
GO

-- =============================================================================
-- 8.4 Monthly sales summaries
-- =============================================================================
SELECT
    YEAR(soh.OrderDate)                     AS SalesYear,
    MONTH(soh.OrderDate)                    AS SalesMonth,
    DATENAME(MONTH, soh.OrderDate)          AS MonthName,
    COUNT(soh.SalesOrderID)                 AS OrderCount,
    SUM(soh.SubTotal)                       AS TotalSubTotal,
    SUM(soh.TaxAmt)                         AS TotalTax,
    SUM(soh.Freight)                        AS TotalFreight,
    SUM(soh.TotalDue)                       AS TotalSalesAmount
FROM Sales.SalesOrderHeader AS soh
GROUP BY YEAR(soh.OrderDate), MONTH(soh.OrderDate), DATENAME(MONTH, soh.OrderDate)
ORDER BY SalesYear, SalesMonth;
GO

-- =============================================================================
-- 8.5 Product inventory summaries
-- =============================================================================
SELECT
    p.ProductID             AS ProductID,
    p.Name                  AS ProductName,
    pm.Name                 AS ProductModel,
    i.LocationID            AS LocationID,
    i.Shelf                 AS Shelf,
    i.Bin                   AS Bin,
    i.Quantity              AS QuantityOnHand
FROM Production.ProductInventory AS i
INNER JOIN Production.Product AS p
    ON i.ProductID = p.ProductID
LEFT JOIN Production.ProductModel AS pm
    ON p.ProductModelID = pm.ProductModelID
ORDER BY i.Quantity DESC, p.Name;
GO

-- =============================================================================
-- 8.6 Customer purchasing summaries
-- =============================================================================
SELECT
    c.CustomerID            AS CustomerID,
    per.FirstName           AS CustomerFirstName,
    per.LastName            AS CustomerLastName,
    COUNT(soh.SalesOrderID) AS TotalOrders,
    SUM(soh.TotalDue)       AS TotalPurchaseAmount,
    MIN(soh.OrderDate)      AS FirstOrderDate,
    MAX(soh.OrderDate)      AS LastOrderDate
FROM Sales.Customer AS c
INNER JOIN Person.Person AS per
    ON c.PersonID = per.BusinessEntityID
INNER JOIN Sales.SalesOrderHeader AS soh
    ON c.CustomerID = soh.CustomerID
GROUP BY c.CustomerID, per.FirstName, per.LastName
ORDER BY TotalPurchaseAmount DESC;
GO
