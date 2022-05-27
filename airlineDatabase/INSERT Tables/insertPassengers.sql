USE INFO_430_Proj_04

GO

CREATE OR ALTER PROCEDURE getProductID
@ProductName1 varchar(50),
@ProductID INT OUTPUT --all parameters but one is an output parameter
AS
SET @ProductID = (SELECT ProductID FROM tblPRODUCT WHERE ProductName = @ProductName1)
 
GO

CREATE OR ALTER PROCEDURE getProductTypeID
@ProductTypeName1 varchar(50),
@ProductTypeID INT OUTPUT --all parameters but one is an output parameter
AS
SET @ProductTypeID = (SELECT ProductTypeID FROM tblPRODUCT_Type WHERE ProductTypeName = @ProductTypeName1)
 
GO

CREATE OR ALTER PROCEDURE getPassengerTypeID
@PassengerTypeName1 varchar(50),
@PassengerTypeID INT OUTPUT --all parameters but one is an output parameter
AS
SET @PassengerTypeID = (SELECT PassengerTypeID FROM tblPASSENGER_TYPE WHERE PassengerTypeName = @PassengerTypeName1)


DECLARE @PassengerTypeID3 INT, @PassengerTypeCount3 INT
SET @PassengerTypeCount3 = (SELECT COUNT(*) FROM tblPASSENGER_TYPE)
SET @PassengerTypeID3 = (SELECT RAND() * @PassengerTypeCount3 + 1)
INSERT INTO tblPASSENGER (PassengerTypeID, PassengerFName, PassengerLName, PassengerDOB, PassengerAddress, PassengerCity, PassengerState, PassengerZIP)
SELECT @PassengerTypeID3, CustomerFname, CustomerLname, DateOfBirth, CustomerAddress, CustomerState, CustomerCity, CustomerZip
FROM PEEPS.dbo.tblCUSTOMER

SELECT * FROM tblPASSENGER

