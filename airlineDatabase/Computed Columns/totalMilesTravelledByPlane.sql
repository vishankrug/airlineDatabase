
USE INFO_430_Proj_04

GO 

-- How many miles a plane have traveled (total miles traveled) in tblPLANE

CREATE FUNCTION totalMilesTravelledByPlane(@PK INT)
    RETURNS INT
    AS BEGIN
        DECLARE @RET INT = (
            SELECT PL.PlaneID, SUM(F.Miles) as TotalMilesTravelled
            FROM tblPLANE PL
            JOIN tblSEAT S ON PL.PlaneID = S.PlaneID
            JOIN tblBOOKING B ON S.SeatID = B.SeatID
            JOIN tblROUTE R ON B.RouteID = R.RouteID
            JOIN tblROUTE_FLIGHTS RT ON R.RouteID = RT.RouteID
            JOIN tblFLIGHT F ON RT.FlightID = F.FlightID
            WHERE PL.PlaneID = @PK
            GROUP BY PL.PlaneID
        )
        RETURN @RET
    END
GO

ALTER TABLE tblPLANE
ADD totalMilesTravelledByPlane AS (dbo.totalMilesTravelledByPlane(PL.PlaneID))
