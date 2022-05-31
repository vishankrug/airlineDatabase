Use INFO_430_Proj_04;
GO

CREATE PROCEDURE insert_into_flights
@RUN INT
AS

DECLARE @ArrivalID2 INT, @DepartureID2 INT, @Miles2 INT, @FlightName2 varchar(255), @FlightType2 INT, @DepartureTime2 datetime, @ArrivalTime2 datetime, @RandomHours INT

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
    SET @Miles2 = (SELECT FLOOR(RAND()*(5000-100+1))+100)
    SET @FlightType2 = (SELECT RAND() * @FlightTypeCount + 1)

    SET @DepartureTime2 = (DATEADD(day, ROUND(DATEDIFF(day, @fromDate, @fromDate) 
    * RAND(CHECKSUM(NEWID())), 5),DATEADD(second, abs(CHECKSUM(NEWID())) % 86400, 
    @fromDate))) 

    SET @ArrivalTime2 = (SELECT dateadd(hour, @RandomHours, @DepartureTime2))

    INSERT INTO tblFLIGHT(FlightName, FlightTypeID, DepartureID, ArrivalID, ArrivalTime, DepartureTime, Miles)
    VALUES (@FlightName2, @FlightType2, @DepartureID2, @ArrivalID2, @ArrivalTime2, @DepartureTime2, @Miles2)

    SET @RUN = @RUN - 1
    END
GO

EXEC insert_into_flights
@RUN = 5000

SELECT * FROM tblFLIGHT