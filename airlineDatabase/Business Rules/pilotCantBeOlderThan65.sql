-- Vishank
-- No pilot can be older than 65

USE INFO_430_Proj_04

GO

CREATE FUNCTION pilotCantBeOlderThan65()
RETURNS INT
AS
BEGIN
 
DECLARE @RET INTEGER = 0
IF EXISTS(
   SELECT *
   FROM tblEMPLOYEE E
   JOIN tblEMPLOYEE_FLIGHT EF ON EF.EmployeeID = E.EmployeeID
   JOIN tblROLE R ON R.RoleID = EF.RoleID
   JOIN tblFLIGHT F ON F.FlightID = EF.FlightID
   WHERE E.DateOfBirth < DATEADD(year, -65, GETDATE())
)
BEGIN
   SET @RET = 1
END
RETURN @RET
END
GO
 
ALTER TABLE tblFLIGHT
ADD Constraint pilotCantBeOlderThan65
CHECK (dbo.pilotCantBeOlderThan65() = 0)