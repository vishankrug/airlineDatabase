---- People under 18 cannot order alcohol  ----
---- Brian ------------------------------
USE INFO_430_Proj_04
GO

CREATE FUNCTION fn_noPassengerUnder18Order_Alcohol()
RETURNS INTEGER
AS
BEGIN

DECLARE @RET INT = 0
IF EXISTS (SELECT * FROM tblPASSENGER P
						JOIN tblBOOKING B on P.PassengerID = B.PassengerID
						JOIN tblORDER O on B.BookingID = O.BookingID
						JOIN tblORDER_PRODUCT OP on O.OrderID = OP.OrderID
						JOIN tblPRODUCT PR on OP.ProductID = PR.ProductID
						JOIN tblPRODUCT_TYPE PT on PR.ProductTypeID = PT.ProductTypeID
					WHERE PT.ProductTypeName = 'Spirits' OR PT.ProductTypeName = 'Wine'
					AND P.PassengerDOB > DATEADD(year, -18, GETDATE()))
SET @RET = 1
RETURN @RET
END
GO

ALTER TABLE tblORDER
ADD CONSTRAINT noUnder18AlcOrders
CHECK (dbo.fn_noPassengerUnder18Order_Alcohol() = 0)



SELECT * FROM tblORDER

DELETE FROM tblORDER
WHERE OrderID is not null