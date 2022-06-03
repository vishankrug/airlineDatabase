CREATE OR ALTER PROCEDURE 

GO


CREATE PROCEDURE getRouteID
@RouteName1 VARCHAR(50),
@RouteID1 INT OUTPUT 
AS 
SET @RouteID1 = (SELECT RouteID FROM tblRoute WHERE RouteName = @RouteName1)
GO

-- getBookingID stored procedure
CREATE OR ALTER PROCEDURE getBookingID
@F VARCHAR(100),
@L VARCHAR(100),
@DOB DATE,
@RtName varchar(50),
@SName varchar(10),
@BookingID INT OUTPUT

AS

DECLARE @P_ID INT, @R_ID INT, @S_ID INT

EXEC getPassengerID
@PassengerFName1 = @F,
@PassengerLName1 = @L,
@PassengerDOB1 = @DOB,
@PassengerID = @P_ID OUTPUT

EXEC getRouteID
@RouteName1 = @RtName,
@RouteID1 = @R_ID OUTPUT


EXEC getSeatID
@SeatName1 = @SName,
@SeatID = @S_ID OUTPUT

SET @BookingID = (SELECT BookingID from tblBOOKING WHERE PassengerID = @P_ID AND RouteID = @R_ID AND SeatID = @S_ID)