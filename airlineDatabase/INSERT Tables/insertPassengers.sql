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

CREATE OR ALTER PROCEDURE populatePassenger
@PassengerTypeName3 varchar(255),
@PassengerFName3 varchar(255),
@PassengerLName3 varchar(255),
@PassengerDOB3 Date,
@PassengerAddress3 varchar(255),
@PassengerCity3 varchar(255),
@PassengerState3 varchar(100),
@PassengerZIP3 varchar(50)

AS
DECLARE @PassengerTypeID3 INT

EXEC getPassengerTypeID
@PassengerTypeName1 = @PassengerTypeName3,
@PassengerTypeID = @PassengerTypeID3 OUTPUT

BEGIN TRANSACTION T1
INSERT INTO tblPASSENGER (PassengerTypeID, PassengerFname, PassengerLname, PassengerDOB, PassengerAddress, PassengerCity, PassengerState, PassengerZIP)
VALUES (@PassengerTypeID3, @PassengerFName3, @PassengerLName3, @PassengerDOB3, @PassengerAddress3, @PassengerCity3, @PassengerState3, @PassengerZIP3)
COMMIT TRANSACTION T1 

GO
CREATE OR ALTER PROCEDURE populatePassengerWrapper
@RUN INT
AS DECLARE @PassengerFName4 varchar(255), @PassengerLName4 varchar(255), @PassengerDOB4 DATE, @PassengerAddress4 varchar(255), @PassengerCity4 varchar(255), 
            @PassengerState4 varchar(100), @PassengerZIP4 varchar(50), @PassengerTypeName4 varchar(255)

DECLARE @C_RowCount INT = (SELECT COUNT(*) FROM PEEPS.dbo.tblCUSTOMER)

DECLARE @PassengerTypeID4 INT, @PassengerTypeCount INT, @CustomerID4 INT

SET @PassengerTypeCount = (SELECT COUNT(*) FROM tblPASSENGER_TYPE)

WHILE @RUN > 0
    BEGIN
        SET @PassengerTypeID4 = (SELECT RAND() * @PassengerTypeCount + 1)
        SET @CustomerID4 = (SELECT RAND() * @C_RowCount + 1)

        SET @PassengerFName4 = (SELECT CustomerFname FROM PEEPS.dbo.tblCUSTOMER WHERE CustomerID = @CustomerID4)
        SET @PassengerLName4 = (SELECT CustomerLname FROM PEEPS.dbo.tblCUSTOMER WHERE CustomerID = @CustomerID4)
        SET @PassengerDOB4 = (SELECT DateOfBirth FROM PEEPS.dbo.tblCUSTOMER WHERE CustomerID = @CustomerID4)
        SET @PassengerAddress4 = (SELECT CustomerAddress FROM PEEPS.dbo.tblCUSTOMER WHERE CustomerID = @CustomerID4)
        SET @PassengerCity4 = (SELECT CustomerState FROM PEEPS.dbo.tblCUSTOMER WHERE CustomerID = @CustomerID4)
        SET @PassengerState4 = (SELECT CustomerCity FROM PEEPS.dbo.tblCUSTOMER WHERE CustomerID = @CustomerID4)
        SET @PassengerZIP4 = (SELECT CustomerZip FROM PEEPS.dbo.tblCUSTOMER WHERE CustomerID = @CustomerID4)
        SET @PassengerTypeName4 = (SELECT PassengerTypeName FROM tblPASSENGER_TYPE WHERE PassengerTypeID = @PassengerTypeID4)

        EXEC populatePassenger
            @PassengerTypeName3 = @PassengerTypeName4,
            @PassengerFName3 = @PassengerFName4,
            @PassengerLName3 = @PassengerLName4,
            @PassengerDOB3 = @PassengerDOB4,
            @PassengerAddress3 = @PassengerAddress4,
            @PassengerCity3 = @PassengerCity4,
            @PassengerState3 = @PassengerState4,
            @PassengerZIP3 = @PassengerZIP4

        SET @RUN = @RUN - 1


    END
GO

EXEC populatePassengerWrapper
@RUN = 10000


-- DECLARE @PassengerTypeID3 INT, @PassengerTypeCount3 INT
-- SET @PassengerTypeCount3 = (SELECT COUNT(*) FROM tblPASSENGER_TYPE)
-- SET @PassengerTypeID3 = (SELECT RAND() * @PassengerTypeCount3 + 1)
-- INSERT INTO tblPASSENGER (PassengerTypeID, PassengerFName, PassengerLName, PassengerDOB, PassengerAddress, PassengerState, PassengerCity, PassengerZIP)
-- SELECT (SELECT RAND() * @PassengerTypeCount3 + 1), CustomerFname, CustomerLname, DateOfBirth, CustomerAddress, CustomerState, CustomerCity, CustomerZip
-- FROM PEEPS.dbo.tblCUSTOMER

-- SELECT * FROM PEEPS.dbo.tblCUSTOMER


-- DELETE FROM tblPASSENGER
-- WHERE PassengerID is not null

-- SELECT * FROM tblCLASS