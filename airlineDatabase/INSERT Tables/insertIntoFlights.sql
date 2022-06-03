Use INFO_430_Proj_04;
GO

CREATE OR ALTER PROCEDURE getAirportID
@AirportName1 varchar(100),
@AirportID INT OUTPUT
AS
SET @AirportID = (SELECT TOP 1 AirportID FROM tblAIRPORT WHERE AirportName = @AirportName1)
GO

CREATE OR ALTER PROCEDURE getFlightTypeID
@FlightTypeName1 varchar(100),
@FlightTypeID INT OUTPUT
AS
SET @FlightTypeID = (SELECT FlightTypeID FROM tblFLIGHT_TYPE WHERE FlightTypeName = @FlightTypeName1)

GO

CREATE OR ALTER PROCEDURE populateFlights
@FlightName1 varchar(255),
@FlightTypeName2 varchar(100),
@AirportNameDeparture1 varchar(100),
@AirportNameArrival1 varchar(100),
@ArrivalTime1 datetime,
@DepartureTime1 datetime,
@Miles1 INT

AS
DECLARE @ArrivalID1 INT, @DepartureID INT, @FlightTypeID1 INT

EXEC getAirportID
@AirportName1 = @AirportNameDeparture1,
@AirportID = @DepartureID OUTPUT

IF @DepartureID IS NULL
    BEGIN
        PRINT '@DepartureID IS NULL';
        THROW 54567, '@DepartureID cannot be null, process is terminating', 1;
    END

EXEC getAirportID
@AirportName1 = @AirportNameArrival1,
@AirportID = @ArrivalID1 OUTPUT

IF @ArrivalID1 IS NULL
    BEGIN
        PRINT '@ArrivalID1 IS NULL';
        THROW 54568, '@ArrivalID1 cannot be null, process is terminating', 1;
    END

EXEC getFlightTypeID
@FlightTypeName1 = @FlightTypeName2,
@FlightTypeID = @FlightTypeID1 OUTPUT

IF @FlightTypeID1 IS NULL
    BEGIN
        PRINT '@FlightTypeID1 IS NULL';
        THROW 54569, '@FlightTypeID1 cannot be null, process is terminating', 1;
    END

BEGIN TRANSACTION T1
    INSERT INTO tblFLIGHT(FlightName, FlightTypeID, DepartureID, ArrivalID, ArrivalTime, DepartureTime, Miles)
    VALUES (@FlightName1, @FlightTypeID1, @DepartureID, @ArrivalID1, @ArrivalTime1, @DepartureTime1, @Miles1)
    IF @@ERROR <> 0 
        BEGIN 
            PRINT 'There is an error, rolling back transaction';
            ROLLBACK TRANSACTION T1
        END
    ELSE 
        COMMIT TRANSACTION T1


GO

CREATE OR ALTER PROCEDURE insert_into_flights
@RUN INT
AS

DECLARE @ArrivalID2 INT, @DepartureID2 INT, @Miles2 INT, @FlightName2 varchar(255), @FlightTypeID2 INT, @DepartureTime2 datetime, @ArrivalTime2 datetime, @RandomHours INT, 
        @AirportNameArrival varchar(100), @AirportDepartureName varchar(100), @FlightTypeName3 varchar(100)

DECLARE @AirportCount INT = (SELECT COUNT(*) FROM tblAIRPORT)

DECLARE @FlightTypeCount INT = (SELECT COUNT(*) FROM tblFLIGHT_TYPE)

Declare @DateStart	Date = '2010-01-01',
		@DateEnd	Date = '2020-01-01'

SET @AirportCount = (SELECT COUNT(*) FROM tblAIRPORT)

WHILE @RUN > 0
BEGIN

    DECLARE @fromDate datetime = (SELECT DateAdd(Day, Rand() * DateDiff(Day, @DateStart, @DateEnd), @DateStart))
    SET @RandomHours = (SELECT RAND() * 6 + 1)
    SET @FlightName2 = (SELECT NEWID())
    SET @ArrivalID2 = (SELECT RAND() * @AirportCount + 1)
    SET @DepartureID2 = (SELECT RAND() * @AirportCount + 1)
    SET @AirportNameArrival = (SELECT AirportName FROM tblAIRPORT WHERE AirportID = @ArrivalID2)
    SET @AirportDepartureName = (SELECT AirportName FROM tblAIRPORT WHERE AirportID = @DepartureID2)
    SET @Miles2 = (SELECT FLOOR(RAND()*(5000-100+1))+100)
    SET @FlightTypeID2 = (SELECT RAND() * @FlightTypeCount + 1)
    SET @FlightTypeName3 = (SELECT FlightTypeName FROM tblFLIGHT_TYPE WHERE FlightTypeID = @FlightTypeID2)

    SET @DepartureTime2 = (DATEADD(day, ROUND(DATEDIFF(day, @fromDate, @fromDate) 
    * RAND(CHECKSUM(NEWID())), 5),DATEADD(second, abs(CHECKSUM(NEWID())) % 86400, 
    @fromDate))) 

    SET @ArrivalTime2 = (SELECT dateadd(hour, @RandomHours, @DepartureTime2))

    EXEC populateFlights
    @FlightName1 = @FlightName2,
    @FlightTypeName2 = @FlightTypeName3,
    @AirportNameDeparture1 = @AirportDepartureName,
    @AirportNameArrival1 = @AirportNameArrival,
    @ArrivalTime1 = @ArrivalTime2,
    @DepartureTime1 = @DepartureTime2,
    @Miles1 = @Miles2

    SET @RUN = @RUN - 1
    END
GO

EXEC insert_into_flights
@RUN = 100000

SELECT * FROM tblFLIGHT