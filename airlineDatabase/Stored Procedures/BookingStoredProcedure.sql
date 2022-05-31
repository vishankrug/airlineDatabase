--Vishank

USE INFO_430_Proj_04

GO

CREATE OR ALTER PROCEDURE getRouteID
@RouteName1 varchar(50),
@RouteID INT OUTPUT --all parameters but one is an output parameter
AS
SET @RouteID = (SELECT RouteID FROM tblROUTE WHERE RouteName = @RouteName1)
 
GO

CREATE OR ALTER PROCEDURE getPassengerID
@PassengerFName1 varchar(255),
@PassengerLName1 varchar(255),
@PassengerDOB1 Date,
@PassengerID INT OUTPUT --all parameters but one is an output parameter
AS
SET @PassengerID = (SELECT PassengerID FROM tblPASSENGER WHERE PassengerFName = @PassengerFname1 AND PassengerLname = @PassengerLName1 AND PassengerDOB = @PassengerDOB1)
 
GO

CREATE OR ALTER PROCEDURE getSeatID
@SeatName1 varchar(10),
@SeatID INT OUTPUT --all parameters but one is an output parameter
AS
SET @SeatID = (SELECT SeatID FROM tblSEAT WHERE SeatName = @SeatName1)
 
GO

CREATE OR ALTER PROCEDURE populateBookingTable
@RouteName2 varchar(50),
@PassengerFName2 varchar(255),
@PassengerLName2 varchar(255),
@PassengerDOB2 Date,
@SeatName2 varchar(10)

AS
DECLARE @SeatID1 INT, @PassengerID1 INT, @RouteID1 INT, @SeatID4 INT, @SeatName4 INT
DECLARE @S_RowCount INT = (SELECT COUNT(*) FROM tblSEAT)

EXEC getRouteID
@RouteName1 = @RouteName2,
@RouteID = @RouteID1 OUTPUT

IF @RouteID1 IS NULL
   BEGIN
       PRINT 'Error found';
       THROW 54665, '@RouteID1 cannot be null, process is terminated', 1;
   END

EXEC getPassengerID
@PassengerFName1 = @PassengerFName2,
@PassengerLName1 = @PassengerLName2,
@PassengerDOB1 = @PassengerDOB2,
@PassengerID = @PassengerID1 OUTPUT

IF @PassengerID1 IS NULL
   BEGIN
       PRINT 'Error found';
       THROW 54666, '@PassengerID1 cannot be null, process is terminated', 1;
   END

EXEC getSeatID
@SeatName1 = @SeatName2,
@SeatID = @SeatID1 OUTPUT

IF @SeatID1 IS NULL
   BEGIN
		WHILE @SeatID1 IS NULL 
			SET @SeatID1 = (SELECT RAND() * @S_RowCount + 1)
			SET @SeatName4 = (SELECT SeatName FROM tblSEAT WHERE SeatID = @SeatID1)

			EXEC getSeatID
			@SeatName1 = @SeatName2,
			@SeatID = @SeatID1 OUTPUT
		
       --PRINT 'Error found';
       --THROW 54667, '@SeatID1 cannot be null, process is terminated', 1;
   END

BEGIN TRANSACTION T1
INSERT INTO tblBOOKING(PassengerID, RouteID, SeatID)
VALUES(@PassengerID1, @RouteID1, @SeatID1)
IF @@ERROR <> 0
   BEGIN
       ROLLBACK TRANSACTION T1
   END
ELSE
COMMIT TRANSACTION T1

GO

CREATE OR ALTER PROCEDURE populateBooking_wrapper
@RUN INT
AS
DECLARE @PassengerFName3 varchar(255), @PassengerLName3 varchar(255), @PassengerDOB3 Date, @RouteName3 varchar(50), @SeatName3 varchar(10)

DECLARE @P_RowCount INT = (SELECT COUNT(*) FROM tblPASSENGER)
DECLARE @S_RowCount INT = (SELECT COUNT(*) FROM tblSEAT)
DECLARE @R_RowCount INT = (SELECT COUNT(*) FROM tblROUTE)

DECLARE @PassengerID3 INT, @RouteID3 INT, @SeatID3 INT

WHILE @RUN > 0
    BEGIN
        SET @PassengerID3 = (SELECT RAND() * @P_RowCount + 1)
        SET @SeatID3 = (SELECT RAND() * @S_RowCount + 1)
        SET @RouteID3 = (SELECT RAND() * @R_RowCount + 1)

        SET @PassengerFName3 = (SELECT PassengerFName FROM tblPASSENGER WHERE PassengerID = @PassengerID3)
        SET @PassengerLName3 = (SELECT PassengerLName FROM tblPASSENGER WHERE PassengerID = @PassengerID3)
        SET @PassengerDOB3 = (SELECT PassengerDOB FROM tblPASSENGER WHERE PassengerID = @PassengerID3)
        SET @RouteName3 = (SELECT RouteName FROM tblROUTE WHERE RouteID = @RouteID3)
        SET @SeatName3 = (SELECT SeatName FROM tblSEAT WHERE SeatID = @SeatID3)

        EXEC populateBookingTable
        @RouteName2 = @RouteName3,
        @PassengerFName2 = @PassengerFName3,
        @PassengerLName2 = @PassengerLName3,
        @PassengerDOB2 = @PassengerDOB3,
        @SeatName2 = @SeatName3

        SET @RUN = @RUN - 1

    END
GO


EXEC populateBookingTable
@RouteName2 = "ASF-KZN",
@PassengerFName2 = "Jonah",
@PassengerLName2 = "Sumi",
@PassengerDOB2 = "1970-07-04",
@SeatName2 = "242"

EXEC populateBooking_wrapper
@RUN = 10000


SELECT * FROM tblBOOKING
SELECT * FROM tblROUTE

SELECT * FROM tblSEAT

SELECT * FROM tblPASSENGER