/*
    Task 5 – Relational Data Analysis Using JOIN Operations
    Technique: INNER JOIN with table aliases
*/

USE AdventureWorks2022;
GO

-- =============================================================================
-- 5.1 Product names with product categories
-- =============================================================================
SELECT
    p.Name                      AS ProductName,
    p.ProductNumber             AS ProductNumber,
    ps.Name                     AS SubcategoryName,
    pc.Name                     AS CategoryName
FROM Production.Product AS p
INNER JOIN Production.ProductSubcategory AS ps
    ON p.ProductSubcategoryID = ps.ProductSubcategoryID
INNER JOIN Production.ProductCategory AS pc
    ON ps.ProductCategoryID = pc.ProductCategoryID
ORDER BY pc.Name, ps.Name, p.Name;
GO

-- =============================================================================
-- 5.2 Employee information with department names
-- =============================================================================
SELECT
    e.BusinessEntityID          AS EmployeeID,
    p.FirstName                 AS FirstName,
    p.LastName                  AS LastName,
    e.JobTitle                  AS JobTitle,
    d.Name                      AS DepartmentName,
    edh.StartDate               AS DepartmentStartDate
FROM HumanResources.Employee AS e
INNER JOIN Person.Person AS p
    ON e.BusinessEntityID = p.BusinessEntityID
INNER JOIN HumanResources.EmployeeDepartmentHistory AS edh
    ON e.BusinessEntityID = edh.BusinessEntityID
INNER JOIN HumanResources.Department AS d
    ON edh.DepartmentID = d.DepartmentID
WHERE edh.EndDate IS NULL
ORDER BY d.Name, p.LastName, p.FirstName;
GO

-- =============================================================================
-- 5.3 Sales order details with customer information
-- =============================================================================
SELECT
    soh.SalesOrderID            AS SalesOrderID,
    soh.OrderDate               AS OrderDate,
    c.CustomerID                AS CustomerID,
    per.FirstName               AS CustomerFirstName,
    per.LastName                AS CustomerLastName,
    sod.ProductID               AS ProductID,
    sod.OrderQty                AS Quantity,
    sod.LineTotal               AS LineTotal
FROM Sales.SalesOrderHeader AS soh
INNER JOIN Sales.Customer AS c
    ON soh.CustomerID = c.CustomerID
INNER JOIN Person.Person AS per
    ON c.PersonID = per.BusinessEntityID
INNER JOIN Sales.SalesOrderDetail AS sod
    ON soh.SalesOrderID = sod.SalesOrderID
ORDER BY soh.OrderDate DESC, soh.SalesOrderID, sod.SalesOrderDetailID;
GO

-- =============================================================================
-- 5.4 Vendor information with purchase order details
-- =============================================================================
SELECT
    v.Name                      AS VendorName,
    v.CreditRating              AS CreditRating,
    poh.PurchaseOrderID         AS PurchaseOrderID,
    poh.OrderDate               AS OrderDate,
    poh.Status                  AS OrderStatus,
    poh.SubTotal                AS SubTotal,
    poh.TaxAmt                  AS TaxAmount,
    poh.Freight                 AS FreightAmount
FROM Purchasing.Vendor AS v
INNER JOIN Purchasing.PurchaseOrderHeader AS poh
    ON v.BusinessEntityID = poh.VendorID
ORDER BY v.Name, poh.OrderDate DESC;
GO
