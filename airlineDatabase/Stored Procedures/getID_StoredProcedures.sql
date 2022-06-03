----- get Stored Procedure ------

CREATE PROCEDURE getEmployeeID
@FName1 VARCHAR(50),
@LName1 VARCHAR(50),
@DOB1 DATE,
@EmpID1 INT OUTPUT
AS 
SET @EmpID1 = (SELECT EmployeeID FROM tblEMPLOYEE WHERE FName = @FName1 AND LName = @LName1 AND DOB = @DOB1)

GO

CREATE PROCEDURE getFlightID
@FlightName1 VARCHAR(50),
@FlightID1 INT OUTPUT
AS 
SET @FlightID1 = (SELECT FlightID FROM tblFlight WHERE FlightName = @FlightName1)

GO

CREATE PROCEDURE getRoleID 
@RoleName1 VARCHAR(50),
@RoleID1 INT OUTPUT 
AS 
SET @RoleID1 = (SELECT RoleID FROM tblROLE WHERE RoleName = @RoleName1)

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


CREATE OR ALTER PROCEDURE getLuggageTypeID
@LTName VARCHAR(100),
@LuggageTypeID INT OUTPUT
AS
SET @LuggageTypeID = (SELECT LuggageTypeID FROM tblLUGGAGE_TYPE WHERE LuggageTypeName = @LTName)
GO