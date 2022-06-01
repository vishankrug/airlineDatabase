-- Computed Column: How Many maintenances have been done for each type of maintenanace 

Use INFO_430_Proj_04;
GO
CREATE OR ALTER FUNCTION fn_CalcTotalMaintenance(@PK INT)
    RETURNS INT
    AS BEGIN
        DECLARE @RET INT = (
            SELECT SUM(M.MaintenanceID)
            FROM tblMAINTENANCE_TYPE MT
            JOIN tblMAINTENANCE M ON MT.MaintenanceTypeID = M.MaintenanceTypeID
            JOIN tblPLANE_MAINTENANCE PM ON M.MaintenanceID = PM.MaintenanceID
            WHERE M.MaintenanceID = @PK
            GROUP BY M.MaintenanceID
        )
        RETURN @RET
    END
GO

ALTER TABLE tblMAINTENANCE
ADD TotalMaintenances AS (dbo.fn_CalcTotalMaintenance(MaintenanceID))





-- SELECT * FROM tblPLANE
-- ALTER TABLE tblMAINTENANCE
-- DROP COLUMN TotalMaintenances

-- SELECT * FROM tblPLANE
-- SELECT * FROM tblPLANE_MAINTENANCE
-- SELECT * FROM tblMAINTENANCE
-- SELECT * FROM tblPLANE_MAINTENANCE
-- SELECT * FROM tblMAINTENANCE_TYPE
