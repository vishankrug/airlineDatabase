USE INFO_430_Proj_04

GO

--- INSERT tblEmployee

------------ BRIAN ----------------

SELECT * FROM tblEMPLOYEE
GO

CREATE OR ALTER PROCEDURE getEmployeeTypeID
@ETName VARCHAR(100),
@ET_ID INT OUTPUT
AS
SET @ET_ID = (SELECT EmployeeTypeID FROM tblEMPLOYEE_TYPE WHERE EmployeeTypeName = @ETName)
GO

-- DECLARE @EmployeeTypeID INT, @ETypeCount INT, @StartDate Date, @EndDate Date


-- DECLARE @FromDate1 Date = '2000-01-01'
-- DECLARE @ToDate1 Date = getdate()

-- SET @StartDate = (SELECT dateadd(day, 
--                rand(checksum(newid()))*(1+datediff(day, @FromDate1, @ToDate1)), 
--                @FromDate1))
-- PRINT(@StartDate)

-- DECLARE @FromDate2 Date = '2018-01-01'
-- DECLARE @ToDate2 Date = getdate()

-- SET @EndDate = (SELECT dateadd(day, 
--                rand(checksum(newid()))*(1+datediff(day, @FromDate2, @ToDate2)), 
--                @FromDate2))

GO

CREATE OR ALTER PROCEDURE populateEmployee
@EmployeeTypeName3 varchar(100),
@EmployeeFName3 varchar(100),
@EmployeeLName3 varchar(100),
@EmployeeDOB3 Date,
@EmployeeStartDate3 DATE,
@EmployeeEndDate3 DATE

AS
DECLARE @EmployeeTypeID3 INT

EXEC getEmployeeTypeID
@ETName = @EmployeeTypeName3,
@ET_ID = @EmployeeTypeID3 OUTPUT

BEGIN TRANSACTION T1
INSERT INTO tblEMPLOYEE (EmployeeTypeID, FName, LNAME, DateOfBirth, StartDate, EndDate)
VALUES (@EmployeeTypeID3, @EmployeeFName3, @EmployeeLName3, @EmployeeDOB3, @EmployeeStartDate3, @EmployeeEndDate3)
COMMIT TRANSACTION T1 

GO
CREATE OR ALTER PROCEDURE populateEmployeeWrapper
@RUN INT
AS DECLARE @EmployeeFName4 varchar(100), @EmployeeLName4 varchar(100), @EmployeeDOB4 Date, @EmployeeStartDate4 DATE, @EmployeeEndDate4 DATE, @EmployeeTypeName4 varchar(100)

DECLARE @C_RowCount INT = (SELECT COUNT(*) FROM PEEPS.dbo.tblCUSTOMER)

DECLARE @EmployeeTypeID4 INT, @EmployeeTypeCount INT, @CustomerID4 INT, @StartDate Date

SET @EmployeeTypeCount = (SELECT COUNT(*) FROM tblEMPLOYEE_TYPE)

DECLARE @FromDate1 Date = '2000-01-01'
DECLARE @ToDate1 Date = getdate()

WHILE @RUN > 0
    BEGIN
        SET @StartDate = (SELECT dateadd(day, 
               rand(checksum(newid()))*(1+datediff(day, @FromDate1, @ToDate1)), 
               @FromDate1))

        SET @EmployeeTypeID4 = (SELECT RAND() * @EmployeeTypeCount + 1)
        SET @CustomerID4 = (SELECT RAND() * @C_RowCount + 1)

        SET @EmployeeFName4 = (SELECT CustomerFname FROM PEEPS.dbo.tblCUSTOMER WHERE CustomerID = @CustomerID4)
        SET @EmployeeLName4 = (SELECT CustomerLname FROM PEEPS.dbo.tblCUSTOMER WHERE CustomerID = @CustomerID4)
        SET @EmployeeDOB4 = (SELECT DateOfBirth FROM PEEPS.dbo.tblCUSTOMER WHERE CustomerID = @CustomerID4)
        SET @EmployeeStartDate4 = @StartDate
        SET @EmployeeEndDate4 = NULL
        SET @EmployeeTypeName4 = (SELECT EmployeeTypeName FROM tblEMPLOYEE_TYPE WHERE EmployeeTypeID = @EmployeeTypeID4)

        EXEC populateEmployee
            @EmployeeTypeName3 = @EmployeeTypeName4,
            @EmployeeFName3 = @EmployeeFName4,
            @EmployeeLName3 = @EmployeeLName4,
            @EmployeeDOB3 = @EmployeeDOB4,
            @EmployeeStartDate3 = @EmployeeStartDate4,
            @EmployeeEndDate3 = @EmployeeEndDate4

        SET @RUN = @RUN - 1


    END
GO

EXEC populateEmployeeWrapper
@RUN = 100



-- SET @ETypeCount = (SELECT COUNT(*) FROM tblEMPLOYEE_TYPE)
-- SET @EmployeeTypeID = (SELECT RAND() * (SELECT COUNT(*) FROM tblEMPLOYEE_TYPE) + 1)
-- INSERT INTO tblEMPLOYEE (EmployeeTypeID, FName, LNAME, DateOfBirth, StartDate, EndDate)
-- SELECT TOP 10 @EmployeeTypeID, CustomerFname, CustomerLname, DateOfBirth, @StartDate, @EndDate
-- FROM PEEPS.dbo.tblCUSTOMER


SELECT * FROM tblEMPLOYEE

DELETE FROM tblEMPLOYEE
WHERE EmployeeID is not null