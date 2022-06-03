----------------- Romil -------------------

USE INFO_430_Proj_04;

GO 

-- Num of employees per flight

CREATE FUNCTION fn_EmpCountPerFlight(@PK INT)
RETURNS INT 
AS 
BEGIN 

DECLARE @RET INT = (SELECT COUNT(EmployeeID) AS EmployeeCount
                    FROM tblEMPLOYEE_FLIGHT
                    WHERE FlightID = @PK
                    GROUP BY FlightID)

RETURN @RET
END

GO 

ALTER TABLE tblFlight
ADD EmployeeCount AS (dbo.fn_EmpCountPerFlight(FlightID))

