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
GO


CREATE TABLE PassengerPK (
PassengerID INT IDENTITY(1,1) primary key.
PassengerFname varchar(100),
PassengerLname varchar(100)
)



CREATE PROCEDURE getPassengerID
@PFname varchar(50),
@PLname varchar(50),
@PDOB date,
@P_ID
AS

SET @P_ID = (SELECT CustomerID FROM PEEPS.dbo WHERE Custom)



INSERT INTO tblPASSENGER









DECLARE @PassengerTypeID3 INT, @PassengerTypeCount3 INT
DECLARE @CountRow INT

SET @CountRow = (SELECT COUNT(*) FROM PEEPS.dbo.tblCUSTOMER)

WHILE @CountRow > 0 (



@CountRow = @CountRow - 1
)

SELECT TOP 100000 CustomerFname, CustomerLname, DateOfBirth, CustomerAddress, CustomerState, CustomerCity, CustomerZip
INTO tempPassenger
FROM PEEPS.dbo.tblCUSTOMER

SELECT * 
FROM tempPassenger


CREATE PROCEDURE popPassenger
@fname varchar(100),
@lname varchar(100),
@dob varchar(100),
@pt_name varchar(100)
AS

DECLARE @PT_ID INT, @P_ID INT

EXEC getPassengerTypeID
@PassengerTypeName1 = @pt_name,
@PassengerTypeID =@PT_ID OUTPUT











SET @PassengerTypeCount3 = (SELECT COUNT(*) FROM tblPASSENGER_TYPE)
SET @PassengerTypeID3 = (SELECT RAND() * @PassengerTypeCount3 + 1)
INSERT INTO tblPASSENGER (PassengerTypeID, PassengerFName, PassengerLName, PassengerDOB, PassengerAddress, PassengerState, PassengerCity, PassengerZIP)
SELECT @PassengerTypeID3, CustomerFname, CustomerLname, DateOfBirth, CustomerAddress, CustomerState, CustomerCity, CustomerZip
FROM PEEPS.dbo.tblCUSTOMER
GO

SELECT * 
FROM tblPASSENGER_TYPE PT
	JOIN PEEPS.dbo.tblCUSTOMER C on 


SELECT * FROM tblPASSENGER


DELETE FROM tblPASSENGER
WHERE PassengerID is not null
