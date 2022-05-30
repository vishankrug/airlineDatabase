 -- INSERT INTO tblPlaneMaintenance
USE INFO_430_Proj_04

GO
----------------- Brian ------------------

SELECT *
FROM tblMAINTENANCE
GO


CREATE PROCEDURE getPlaneID
@PlaneName VARCHAR(50),
@ICAO VARCHAR(50),
@Plane_ID INT OUTPUT
AS

SET @PLANE_ID = (SELECT PlaneID FROM tblPLANE WHERE PlaneName = @PlaneName AND ICAO = @ICAO)
GO


CREATE PROCEDURE getMaintenanceID
@MainName VARCHAR(50),
@Main_ID INT OUTPUT
AS

SET @Main_ID = (SELECT MaintenanceID FROM tblMAINTENANCE WHERE MaintenanceName = @MainName)
GO


CREATE OR ALTER PROCEDURE popPlaneMaintenance
@Mname VARCHAR(50),
@Pname VARCHAR(50),
@Pname VARCHAR(50)
AS
DECLARE @P_ID INT, @M_ID INT, @M_Date Date

DECLARE @FromDate Date = '2020-01-01'
DECLARE @ToDate Date = getdate()

SET @M_Date = (SELECT dateadd(day, 
               rand(checksum(newid()))*(1+datediff(day, @FromDate, @ToDate)), 
               @FromDate))

EXEC getPlaneID
@PlaneName = @Pname,
@ICAO = @ICAO1,
@Plane_ID = @P_ID OUTPUT

IF @Pname IS NULL
	BEGIN
		PRINT 'hey @Pname is NULL...';
		THROW 55656, '@Pname cannot be null; process is terminating', 1;
	END

EXEC getMaintenanceID
@MainName = @Mname,
@Main_ID = @M_ID OUTPUT

IF @Mname IS NULL
	BEGIN
		PRINT 'hey @Mname is NULL...';
		THROW 55656, '@Mname cannot be null; process is terminating', 1;
	END

BEGIN TRANSACTION T1
INSERT INTO tblPLANE_MAINTENANCE (MaintenanceDate, PlaneID, MaintenanceID)
VALUES(@M_Date, @P_ID, @M_ID)
IF @@ERROR <> 0
	Begin
		PRINT 'Something wrong .. rolling back T1'
		ROLLBACK TRANSACTION T1
	End
ELSE
	COMMIT TRANSACTION T1
GO


CREATE OR ALTER PROCEDURE wrapper_popPlaneMaintenance
@RUN INT
AS
DECLARE @Mname1 VARCHAR(50), @Pname1 VARCHAR(50), @ICAO2 VARCHAR(50)

DECLARE @PlaneRowCount INT = (SELECT COUNT(*) FROM tblPLANE)
DECLARE @MainRowCount INT = (SELECT COUNT(*) FROM tblMAINTENANCE)
DECLARE @P_PK INT, @M_PK INT

WHILE @RUN > 0
	BEGIN
		SET @P_PK = (SELECT RAND() * @PlaneRowCount + 1)
		SET @M_PK = (SELECT RAND() * @MainRowCount + 1)


		SET @Mname1 = (SELECT MaintenanceName FROM tblMAINTENANCE WHERE MaintenanceID = @M_PK)
		SET @Pname1 = (SELECT PlaneName FROM tblPLANE WHERE PlaneID = @P_PK)
		SET @ICAO2 = (SELECT ICAO FROM tblPLANE WHERE PlaneID = @P_PK)

		EXEC popPlaneMaintenance
		@Mname = @Mname1,
		@Pname = @Pname1,
		@ICAO1 = @ICAO2

		SET @RUN = @RUN - 1

	END
GO

EXEC wrapper_popPlaneMaintenance
@RUN = 10000


SELECT * FROM tblPLANE_MAINTENANCE


GO

SELECT * FROM tblPLANE