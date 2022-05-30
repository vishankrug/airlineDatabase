USE INFO_430_Proj_04

GO

CREATE OR ALTER PROCEDURE getProductID
@ProductName1 varchar(50),
@ProductID INT OUTPUT --all parameters but one is an output parameter
AS
SET @ProductID = (SELECT ProductID FROM tblPRODUCT WHERE ProductName = @ProductName1)
 
GO

CREATE PROCEDURE insert_order_product
@OrderDate2 Date,
@Quantity2 INT

AS
DECLARE @OrderID2 INT, @ProductID2 INT, @BookingID2 INT