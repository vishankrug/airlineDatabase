USE INFO_430_Proj_04

GO

--- INSERT tblEmployee

------------ BRIAN ----------------

SELECT * FROM tblEMPLOYEE
GO

CREATE PROCEDURE getEmployeeTypeID
@ETName VARCHAR(50),
@ET_ID INT OUTPUT
AS
SET @ET_ID = (SELECT EmployeeTypeID FROM tblEMPLOYEE_TYPE WHERE EmployeeTypeName = @ETName)
GO

DECLARE @EmployeeTypeID INT, @ETypeCount INT, @StartDate Date, @EndDate Date


DECLARE @FromDate1 Date = '2000-01-01'
DECLARE @ToDate1 Date = getdate()

SET @StartDate = (SELECT dateadd(day, 
               rand(checksum(newid()))*(1+datediff(day, @FromDate1, @ToDate1)), 
               @FromDate1))

DECLARE @FromDate2 Date = '2018-01-01'
DECLARE @ToDate2 Date = getdate()

SET @EndDate = (SELECT dateadd(day, 
               rand(checksum(newid()))*(1+datediff(day, @FromDate2, @ToDate2)), 
               @FromDate2))



SET @ETypeCount = (SELECT COUNT(*) FROM tblEMPLOYEE_TYPE)
SET @EmployeeTypeID = (SELECT RAND() * (SELECT COUNT(*) FROM tblEMPLOYEE_TYPE) + 1)
INSERT INTO tblEMPLOYEE (EmployeeTypeID, FName, LNAME, DateOfBirth, StartDate, EndDate)
SELECT TOP 10 @EmployeeTypeID, CustomerFname, CustomerLname, DateOfBirth, @StartDate, @EndDate
FROM PEEPS.dbo.tblCUSTOMER


SELECT * FROM tblEMPLOYEE

DELETE FROM tblEMPLOYEE
WHERE EmployeeID is not null