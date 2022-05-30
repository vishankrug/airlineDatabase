USE INFO_430_Proj_04
GO

-- Route Flight : RouteID, FlightID

CREATE PROCEDURE getFlightID
@FlightName1 VARCHAR(50),
@FlightID1 INT OUTPUT
AS 
SET @FlightID1 = (SELECT FlightID FROM tblFlight WHERE FlightName = @FlightName1)

GO

CREATE PROCEDURE getRouteID
@RouteName1 VARCHAR(50),
@RouteID1 INT OUTPUT 
AS 
SET @RouteID1 = (SELECT RouteID FROM tblRoute WHERE RouteName = @RouteName1)

GO

CREATE PROCEDURE populateRouteFlight
@FlightName2 VARCHAR(50),
@RouteName2 VARCHAR(50)
AS 
DECLARE @FlightID2 INT, @RouteID2 INT 

EXEC getFlightID 
@FlightName1 = @FlightName2,
@FlightID1 = @FlightID2 OUTPUT 

IF @FlightID2 IS NULL
    BEGIN
        PRINT 'Flight ID IS NULL';
        THROW 54566, 'Flight ID cannot be null, process is terminating', 1;
    END

EXEC getRouteID 
@RouteName1 = @RouteName2,
@RouteID1 = @RouteID2 OUTPUT 

IF @RouteID2 IS NULL
    BEGIN
        PRINT 'Route ID IS NULL';
        THROW 54567, 'Route ID cannot be null, process is terminating', 1;
    END

BEGIN TRANSACTION T1
    INSERT INTO tblROUTE_FLIGHTS(RouteID, FlightID)
    VALUES (@RouteID2, @FlightID2)
    IF @@ERROR <> 0 
        BEGIN 
            PRINT 'There is an error, rolling back transaction';
            ROLLBACK TRANSACTION T1
        END
    ELSE 
        COMMIT TRANSACTION T1

GO

-- synthetic transaction

CREATE PROCEDURE wrapper_populateRouteFlight
@RUN INT

AS 

DECLARE @RouteName3 VARCHAR(50), @FlightName3 VARCHAR(50)

DECLARE @Route_RowCount INT = (SELECT COUNT(*) FROM tblROUTE)
DECLARE @Flight_RowCount INT = (SELECT COUNT(*) FROM tblFLIGHT)

DECLARE @RouteID3 INT, @FlightID3 INT

WHILE @RUN > 0

    BEGIN 
        SET @FlightID3 = (SELECT RAND() * @Flight_RowCount + 1)
        SET @RouteID3 = (SELECT RAND() * @Route_RowCount + 1)

        SET @RouteName3 = (SELECT RouteName FROM tblRoute WHERE RouteID = @RouteID3)
        SET @FlightName3 = (SELECT FlightName FROM tblFlight WHERE FlightID = @FlightID3)

        EXEC populateRouteFlight
        @FlightName2 = @FlightName3,
        @RouteName2 = @RouteName3

        SET @RUN = @RUN - 1

    END
GO

EXEC wrapper_populateRouteFlight 5000


