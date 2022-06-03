------- No pilots that started less than a year ago can fly an international flight
------ Brian ------------------------------------------------

USE INFO_430_Proj_04
GO

CREATE FUNCTION fn_noInternationalPilotOneYearExperience()
RETURNS INTEGER
AS
BEGIN

DECLARE @RET INT = 0
IF EXISTS (SELECT * FROM tblEMPLOYEE E
						JOIN tblEMPLOYEE_FLIGHT EF on E.EmployeeID = EF.EmployeeID
						JOIN tblROLE R on EF.RoleID = R.RoleID
						JOIN tblFLIGHT F on EF.FlightID = F.FlightID
						JOIN tblROUTE_FLIGHTS RF on F.FlightID = RF.FlightID
						JOIN tblROUTE RO on RF.RouteID = RO.RouteID
						JOIN tblBOOKING B on RO.RouteID = B.RouteID
						JOIN tblSEAT S on B.SeatID = S.SeatID
						JOIN tblPLANE P on S.PlaneID = P.PlaneID
						JOIN tblPLANE_TYPE PT on P.PlaneTypeID = PT.PlaneTypeID
					WHERE E.StartDate > DATEADD(year, -1, GETDATE())
					AND R.RoleName = 'Captain'
					AND PT.PlaneTypeName = 'Intercontinential')
SET @RET = 1
RETURN @RET
END
GO

ALTER TABLE tblEMPLOYEE_FLIGHT
ADD CONSTRAINT noInexperiencedInternationalPilot
CHECK (dbo.fn_noInternationalPilotOneYearExperience() = 0)