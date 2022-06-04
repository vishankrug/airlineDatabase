-- Vishank
-- Minimum number of employees per flight is 10

USE INFO_430_Proj_04

GO 

CREATE OR ALTER FUNCTION minimumOf10EmployeesPerFlight()
RETURNS INT
AS
BEGIN
 
DECLARE @RET INTEGER = 0
IF EXISTS(
   SELECT *
   FROM tblFLIGHT F
   JOIN tblEMPLOYEE_FLIGHT EF ON EF.FlightID = F.FlightID
   HAVING COUNT(*) <= 10
)
BEGIN
   SET @RET = 1
END
RETURN @RET
END
GO
 
ALTER TABLE tblFLIGHT
ADD Constraint minimumOf10EmployeesPerFlight
CHECK (dbo.minimumOf10EmployeesPerFlight() = 0)