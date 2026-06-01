/*
    Task 5 - Inventory Analysis Stored Procedure
*/

USE AdventureWorks2022;
GO

IF OBJECT_ID(N'OperationalReporting.usp_GetInventoryAnalysis', N'P') IS NOT NULL
BEGIN
    DROP PROCEDURE OperationalReporting.usp_GetInventoryAnalysis;
END
GO

CREATE PROCEDURE OperationalReporting.usp_GetInventoryAnalysis
    @ReorderThreshold SMALLINT
AS
BEGIN
    SET NOCOUNT ON;

    /* Parameter validation */
    IF @ReorderThreshold IS NULL OR @ReorderThreshold < 0
    BEGIN
        RAISERROR(N'Reorder threshold must be zero or greater.', 16, 1);
        RETURN;
    END

    SELECT
        ProductID,
        Name AS ProductName,
        SafetyStockLevel,
        ReorderPoint
    FROM Production.Product
    WHERE ReorderPoint > @ReorderThreshold
    ORDER BY ReorderPoint DESC;
END
GO

EXEC OperationalReporting.usp_GetInventoryAnalysis
    @ReorderThreshold = 500;