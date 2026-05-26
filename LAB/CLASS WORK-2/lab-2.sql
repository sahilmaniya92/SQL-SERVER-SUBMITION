USE AdventureWorks2022;
GO


CREATE TABLE SupplierQualityReview
(
    ReviewID BIGINT IDENTITY(1,1),

    VendorID INT ,

    ReviewDate DATE ,

    QualityRating TINYINT ,

    ComplianceLevel CHAR(1) ,

    ReviewComments NVARCHAR(MAX) ,

    IsApproved BIT DEFAULT 0,

  
    CONSTRAINT PK_SupplierQualityReview
        PRIMARY KEY (ReviewID),


    CONSTRAINT FK_SupplierQualityReview_Vendor
        FOREIGN KEY (VendorID)
        REFERENCES Purchasing.Vendor(BusinessEntityID),

    CONSTRAINT CK_SupplierQualityReview_Rating
        CHECK (QualityRating BETWEEN 1 AND 10),

  
    CONSTRAINT CK_SupplierQualityReview_Compliance
        CHECK (ComplianceLevel IN ('A', 'B', 'C', 'D'))
);