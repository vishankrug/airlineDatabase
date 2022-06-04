-- populating luggage stored procedure (Cynthia)

USE INFO_430_Proj_04
GO

CREATE OR ALTER PROCEDURE getLuggageTypeID
@LTName VARCHAR(100),
@LuggageTypeID INT OUTPUT
AS
SET @LuggageTypeID = (SELECT LuggageTypeID FROM tblLUGGAGE_TYPE WHERE LuggageTypeName = @LTName)
GO


CREATE OR ALTER PROCEDURE populateLuggageTable
@PFirst VARCHAR(100),
@PLast VARCHAR(100),
@Birth DATE,
@RtName1 VARCHAR(100),
@SName1 VARCHAR(50),

@LWeight INT,
@LugTypeName VARCHAR(100)

AS
DECLARE @B_ID INT, @LugTypeID INT

EXEC getBookingID
@F = @PFirst, 
@L = @PLast,
@DOB = @Birth,
@RtName = @RtName1,
@SName = @SName1,
@BookingID = @B_ID OUTPUT


IF @B_ID IS NULL
   BEGIN
       PRINT 'Error found';
       THROW 54665, 'The booking ID cannot be null, process is terminated', 1;
   END

EXEC getLuggageTypeID
@LTName = @LugTypeName,
@LuggageTypeID = @LugTypeID OUTPUT

IF @LugTypeID IS NULL
   BEGIN
       PRINT 'Error found';
       THROW 54665, 'The luggage ID cannot be null, process is terminated', 1;
   END

BEGIN TRANSACTION T1
INSERT INTO tblLUGGAGE(BookingID, LuggageWeight, LuggageTypeID)
VALUES(@B_ID, @LWeight, @LugTypeID)
IF @@ERROR <> 0
   BEGIN
       ROLLBACK TRANSACTION T1
   END
ELSE
COMMIT TRANSACTION T1




-- synthetic transaction to populate the rest of tblLUGGAGE
GO
CREATE OR ALTER PROCEDURE populateLuggageTable_wrapper
@RUN INT
AS
DECLARE 
@PFirst1 VARCHAR(100),
@PLast1 VARCHAR(100),
@Birth1 DATE,
@RtName2 VARCHAR(100),
@SName2 VARCHAR(50),

@LWeight1 INT,
@LTypeName1 VARCHAR(100)

DECLARE @P_RowCount INT = (SELECT COUNT(*) FROM tblPASSENGER)
DECLARE @S_RowCount INT = (SELECT COUNT(*) FROM tblSEAT)
DECLARE @R_RowCount INT = (SELECT COUNT(*) FROM tblROUTE)
DECLARE @LT_RowCount INT = (SELECT COUNT(*) FROM tblLUGGAGE_TYPE)


DECLARE @PassID INT, @RID INT, @SID INT, @LTID INT

WHILE @RUN > 0
    BEGIN
        SET @PassID = (SELECT RAND() * @P_RowCount + 1)
        SET @SID = (SELECT RAND() * @S_RowCount + 1)
        SET @RID = (SELECT RAND() * @R_RowCount + 1)
        SET @LTID = (SELECT RAND() * @LT_RowCount + 1)

        SET @PFirst1 = (SELECT PassengerFName FROM tblPASSENGER WHERE PassengerID = @PassID)
        SET @PLast1 = (SELECT PassengerLName FROM tblPASSENGER WHERE PassengerID = @PassID)
        SET @Birth1 = (SELECT PassengerDOB FROM tblPASSENGER WHERE PassengerID = @PassID)
        SET @RtName2 = (SELECT RouteName FROM tblROUTE WHERE RouteID = @RID)
        SET @SName2 = (SELECT SeatName FROM tblSEAT WHERE SeatID = @SID)
        SET @LWeight1 = (SELECT FLOOR(RAND() * 51))
        SET @LTypeName1 = (SELECT LuggageTypeName from tblLUGGAGE_TYPE WHERE LuggageTypeID = @LTID)

        EXEC populateLuggageTable
        @PFirst = @PFirst1,
        @PLast = @PLast1,
        @Birth = @Birth1,
        @RtName1 = @RtName2,
        @SName1 = @SName2,
        @LWeight = @LWeight1,
        @LugTypeName = @LTypeName1

        SET @RUN = @RUN - 1
    END
GO

EXEC populateLuggageTable_wrapper 100

--
EXEC populateLuggageTable
@PFirst = 'Karma',
@PLast = 'Greninger', 
@Birth  = '1994-07-15',
@RtName1 = 'FRA-HDF',
@SName1  = 99813,
@LWeight = 38,
@LugTypeName = 'Normal'



SELECT * FROM tblBOOKING
SELECT * FROM tblPASSENGER where PassengerID = 5114
SELECT * FROM tblROUTE where RouteID = 1411
SELECT * FROM tblSEAT where SeatID = 1076
SELECT * FROM tblLUGGAGE_TYPE
SELECT * FROM tblROUTE
SELECT * FROM tblLUGGAGE






