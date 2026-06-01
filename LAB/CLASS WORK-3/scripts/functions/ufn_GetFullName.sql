/*
    Task 6 - Scalar-Valued Function: Full Name Formatter
*/

USE AdventureWorks2022;
GO
IF OBJECT_ID(N'OperationalReporting.ufn_GetFullName', N'FN') IS NOT NULL
BEGIN
    DROP FUNCTION OperationalReporting.ufn_GetFullName;
END
GO

CREATE FUNCTION OperationalReporting.ufn_GetFullName
(
    @FirstName NVARCHAR(50),
    @LastName  NVARCHAR(50)
)
RETURNS NVARCHAR(101)
AS
BEGIN
    RETURN LTRIM(RTRIM(
        CONCAT(
            ISNULL(@FirstName, N''),
            CASE
                WHEN ISNULL(@FirstName, N'') <> N'' AND ISNULL(@LastName, N'') <> N'' THEN N' '
                ELSE N''
            END,
            ISNULL(@LastName, N'')
        )
    ));
END
GO
SELECT OperationalReporting.ufn_GetFullName(N'John', N'Smith') AS FullName;
SELECT OperationalReporting.ufn_GetFullName(N'John', NULL) AS FullName;
SELECT OperationalReporting.ufn_GetFullName(NULL, N'Smith') AS FullName;