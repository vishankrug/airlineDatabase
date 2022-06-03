----------------- Romil -------------------

USE INFO_430_Proj_04;

GO 
-- Total weight of luggage of the flight

CREATE FUNCTION fn_totalWeightLuggage (@PK INT)
RETURNS INT
AS 
BEGIN 
DECLARE @RET INT = (SELECT SUM(L.LuggageWeight) AS totalLuggageWeight
                    FROM tblLuggage L 
                        JOIN tblBooking B ON L.BookingID = B.BookingID
                        JOIN tblRoute R ON B.RouteID = R.RouteID
                        JOIN tblROUTE_FLIGHTS RF ON R.RouteID = RF.RouteID
                        JOIN tblFLIGHT F ON RF.FlightID = F.FlightID
                    WHERE F.FlightID = @PK
                    GROUP BY F.FlightID)

RETURN @RET
END

GO

ALTER TABLE tblFlight 
ADD totalLuggageWeight AS (dbo.fn_totalWeightLuggage(FlightID))