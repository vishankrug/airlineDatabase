----------------- Romil -------------------

USE INFO_430_Proj_04;

GO 

-- Planes cannot fly if it has passed more than 30 days without a maintenance

CREATE FUNCTION fn_Passed_Maintenance_days()
RETURNS INTEGER
AS 
BEGIN
DECLARE @RET INTEGER = 0
IF EXISTS(SELECT * 
            FROM tblPLANE P
                JOIN tblPLANE_MAINTENANCE PM ON P.PlaneID = PM.PlaneID
                JOIN tblSEAT S ON S.PlaneID = P.PlaneID
                JOIN tblBooking B ON S.SeatID = B.SeatID
            GROUP BY P.PlaneID
            HAVING DateDiff(Day, MAX(PM.MaintenanceDate), GetDate()) > 30)
            BEGIN 
                 SET @RET = 1
            END
RETURN @RET
END

GO

ALTER TABLE tblPLANE WITH NOCHECK
ADD CONSTRAINT CK_No_Passed_Maintenance
CHECK (dbo.fn_Passed_Maintenance_days() = 0)