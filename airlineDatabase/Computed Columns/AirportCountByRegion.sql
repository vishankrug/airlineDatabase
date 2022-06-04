-- computed column: Number of airports in a given region (Cynthia)
Use INFO_430_Proj_04;

GO
CREATE OR ALTER FUNCTION fn_CalcAirportsByRegion (@PK INT)
RETURNS INT
AS 
BEGIN
DECLARE @RET INT = (SELECT COUNT(A.AirportID) AS TotalAirports
                    FROM tblREGION R
                    JOIN tblCOUNTRY C ON C.RegionID = R.RegionID
                    JOIN tblCITY CT ON C.CountryID = CT.CountryID
                    JOIN tblAIRPORT A ON CT.CityID = A.CityID
                    WHERE R.RegionID = @PK
                    GROUP BY R.RegionID)
RETURN @RET
END
GO

ALTER TABLE tblREGION
ADD TotalAirports AS (dbo.fn_CalcAirportsByRegion(RegionID))

-- ALTER TABLE tblREGION
-- DROP COLUMN TotalAirports
