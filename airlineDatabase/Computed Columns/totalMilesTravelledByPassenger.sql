
USE INFO_430_Proj_04

GO 

-- How many miles passengers have traveled (total miles traveled) in tblPASSENGER

CREATE OR ALTER FUNCTION totalMilesTravelledByPassenger(@PK INT)
    RETURNS INT
    AS BEGIN
        DECLARE @RET INT = (
            SELECT SUM(F.Miles) as TotalMilesTravelled
            FROM tblPASSENGER P
            JOIN tblBOOKING B ON P.PassengerID = B.PassengerID
            JOIN tblROUTE R ON B.RouteID = R.RouteID
            JOIN tblROUTE_FLIGHTS RT ON R.RouteID = RT.RouteID
            JOIN tblFLIGHT F ON RT.FlightID = F.FlightID
            WHERE P.PassengerID = @PK
            GROUP BY P.PassengerID
        )
        RETURN @RET
    END
GO

ALTER TABLE tblPASSENGER
ADD totalMilesTravelledByPassenger AS (dbo.totalMilesTravelledByPassenger(PassengerID))

SELECT * FROM tblPASSENGER