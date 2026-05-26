/*
    Task 3 – Basic Data Retrieval Operations

*/

USE AdventureWorks2022;
GO

-- =============================================================================
-- 3.1 Products with ListPrice greater than 1000
-- =============================================================================
SELECT
    p.ProductID         AS ProductID,
    p.Name              AS ProductName,
    p.ProductNumber     AS ProductNumber,
    p.ListPrice         AS ListPrice,
    p.Color             AS Color
FROM Production.Product AS p
WHERE p.ListPrice > 1000
ORDER BY p.ListPrice DESC;
GO

-- =============================================================================
-- 3.2 Employees hired after January 1, 2010
-- =============================================================================
SELECT
    e.BusinessEntityID  AS EmployeeID,
    e.JobTitle          AS JobTitle,
    e.HireDate          AS HireDate,
    e.MaritalStatus     AS MaritalStatus,
    e.VacationHours     AS VacationHours
FROM HumanResources.Employee AS e
WHERE e.HireDate > '2010-01-01'
ORDER BY e.HireDate;
GO

-- =============================================================================
-- 3.3 Vendors with CreditRating equal to 1 (excellent)
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
-- 3.4 Products sorted by highest ListPrice
-- =============================================================================
SELECT
    p.ProductID         AS ProductID,
    p.Name              AS ProductName,
    p.ListPrice         AS ListPrice,
    p.StandardCost      AS StandardCost
FROM Production.Product AS p
WHERE p.ListPrice IS NOT NULL
ORDER BY p.ListPrice DESC;
GO

-- =============================================================================
-- 3.5 Customers ordered alphabetically (by person name)
-- =============================================================================
SELECT
    c.CustomerID        AS CustomerID,
    p.FirstName         AS FirstName,
    p.LastName          AS LastName,
    p.PersonType        AS PersonType,
    c.AccountNumber     AS AccountNumber
FROM Sales.Customer AS c
INNER JOIN Person.Person AS p
    ON c.PersonID = p.BusinessEntityID
ORDER BY p.LastName, p.FirstName;
GO
