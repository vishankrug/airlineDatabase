USE INFO_430_Proj_04;
GO

-----------insert product and product type ------------
-----------Brian -------------------------

SELECT * FROM tblPRODUCT_TYPE
SELECT * FROM tblPRODUCT


DELETE FROM tblPRODUCT_TYPE
WHERE ProductTypeID is not null

DBCC CHECKIDENT ('tblProduct_Type', RESEED, 0);
GO

DELETE FROM tblPRODUCT
WHERE ProductID is not null

DBCC CHECKIDENT ('tblProduct', RESEED, 0);
GO

SELECT * FROM Sheet1$


INSERT INTO tblPRODUCT_TYPE(ProductTypeName)
SELECT DISTINCT ProductTypeName
FROM Sheet1$
GO


INSERT INTO tblPRODUCT(ProductTypeID, ProductName, ProductPrice)
SELECT DISTINCT PT.ProductTypeID, F.ProductName, F.Price
FROM Sheet1$ F
	JOIN tblPRODUCT_TYPE PT on F.ProductTypeName = PT.ProductTypeName
WHERE ProductName != 'Evergreens Salad'