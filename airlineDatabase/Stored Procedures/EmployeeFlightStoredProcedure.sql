USE INFO_430_Proj_04
GO


------------- Romil --------------


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

CREATE PROCEDURE populateEmployeeFlight
@FName2 VARCHAR(50),
@LName2 VARCHAR(50),
@DOB2 DATE,
@FlightName2 VARCHAR(50),
@RoleName2 VARCHAR(50)
AS
DECLARE @EmpID2 INT, @FlightID2 INT, @RoleID2 INT 

EXEC getEmployeeID
@Fname1 = @FName2,
@LName1 = @LName2,
@DOB1 = @DOB2,
@EmpID1 = @EmpID2 OUTPUT

IF @EmpID2 IS NULL 
    BEGIN
        PRINT 'EmployeeID IS NULL';
        THROW 54565, 'Employee ID cannot be null, process is terminating', 1; 
    END

EXEC getFlightID
@FlightName1 = @FlightName2,
@FlightID1 = @FlightID2 OUTPUT

IF @FlightID2 IS NULL
    BEGIN
        PRINT 'Flight ID IS NULL';
        THROW 54566, 'Flight ID cannot be null, process is terminating', 1;
    END

EXEC getRoleID
@RoleName1 = @RoleName2,
@RoleID1 = @RoleID2 OUTPUT

IF @RoleID2 IS NULL
    BEGIN
        PRINT 'Role ID is null';
        THROW 54567, 'Role ID cannot be null, process is terminating' 1; 
    END

BEGIN TRANSACTION T1
    INSERT INTO tblEMPLOYEE_FLIGHT(FlightID, EmployeeID, RoleID)
    VALUES (@FlightID2, @EmpID2, @RoleID2)
    IF @@ERROR <> 0
        BEGIN 
            PRINT 'There is an error, rolling back transaction T1';
            ROLLBACK TRANSACTION T1
        END
    ELSE 
        COMMIT TRANSACTION T1

GO

-- synthetic transaction

CREATE PROCEDURE wrapper_populateEmployeeFlight
@RUN INT 

AS 

DECLARE @FName3 VARCHAR(50), @LName3 VARCHAR(50), @DOB3 DATE, @FlightName3 VARCHAR(50), @RoleName3 VARCHAR(50)

DECLARE @Flight_RowCount INT = (SELECT COUNT(*) FROM tblFlight)
DECLARE @Employee_RowCount INT = (SELECT COUNT(*) FROM tblEMPLOYEE)
DECLARE @Role_RowCount INT = (SELECT COUNT(*) FROM tblRole)

DECLARE @FlightID3 INT, @EmpID3 INT, @RoleID3 INT 

WHILE @RUN > 0
BEGIN 
    SET @FlightID3 = (SELECT RAND() * @Flight_RowCount + 1)
    SET @EmpID3 = (SELECT RAND() * @Employee_RowCount + 1)
    SET @RoleID3 = (SELECT RAND() * @Role_RowCount + 1)

    SET @FName3 = (SELECT FName FROM tblEMPLOYEE WHERE EmployeeID = @EmpID3)
    SET @LName3 = (SELECT LName FROM tblEMPLOYEE WHERE EmployeeID = @EmpID3)
    SET @DOB3 =  (SELECT DOB FROM tblEMPLOYEE WHERE EmployeeID = @EmpID3)

    SET @FlightName3 = (SELECT FlightName FROM tblFLIGHT WHERE FlightID = @FlightID3)
    SET @RoleName3 = (SELECT RoleName FROM tblRole WHERE RoleID = @RoleID3)


    EXEC populateEmployeeFlight
    @FName2 = @FName3,
    @LName2 = @LName3,
    @DOB2 = @DOB3,
    @FlightName2 = @FlightName3,
    @RoleName2 = @RoleName3

    SET @RUN = @RUN - 1
END

GO

-- running synthetic transaction

EXEC wrapper_populateEmployeeFlight 5000
