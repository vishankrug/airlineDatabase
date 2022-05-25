-- Computed Column: Next maintenance date = past mainDate + 1 year -- 

Use INFO_430_Proj_04;

GO
CREATE OR ALTER FUNCTION fn_CalcNextMaintenaceDate (@PK INT)
RETURNS INT
AS 
BEGIN
DECLARE @RET INT = (SELECT YEAR(PM.MaintenanceDate) + 1 AS NextMaintenaceDate
                                    FROM tblPLANE_MAINTENANCE PM
                                    JOIN tblPLANE P ON P.PlaneID = PM.PlaneID
                                WHERE P.PlaneID = @PK)
RETURN @RET
END
GO

ALTER TABLE tblPLANE
ADD NextMaintenanceDue AS (dbo.fn_CalcNextMaintenaceDate(PlaneID))
