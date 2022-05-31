USE INFO_430_Proj_04;
GO

-----------insert product and product type ------------
-----------Brian -------------------------

SELECT * FROM tblPRODUCT_TYPE
SELECT * FROM tblPRODUCT


DELETE FROM tblPRODUCT_TYPE
WHERE ProductTypeID is not null

SELECT * FROM food$


INSERT INTO tblPRODUCT_TYPE(ProductTypeName)
SELECT DISTINCT ProductTypeName
FROM food$
GO


INSERT INTO tblPRODUCT(ProductTypeID, ProductName, ProductPrice)
SELECT DISTINCT PT.ProductTypeID, F.ProductName, F.Price
FROM food$ F
	JOIN tblPRODUCT_TYPE PT on F.ProductTypeName = PT.ProductTypeName