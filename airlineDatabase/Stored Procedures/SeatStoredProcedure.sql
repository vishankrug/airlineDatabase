USE INFO_430_Proj_04
GO

--------- POPULATE tblSEAT --------------

-------- BRIAN -----------------------

SELECT * FROM tblSEAT
GO

SELECT * FROM tblPLANE
GO

SELECT * FROM tblCLASS
GO

CREATE PROCEDURE getPlaneID
@PlaneName VARCHAR(50),
@ICAO VARCHAR(50),
@Plane_ID INT OUTPUT
AS

SET @PLANE_ID = (SELECT PlaneID FROM tblPLANE WHERE PlaneName = @PlaneName AND ICAO = @ICAO)
GO

CREATE or ALTER PROCEDURE getClassID
@CName VARCHAR(50),
@Class_ID INT OUTPUT
AS

SET @Class_ID = (SELECT ClassID FROM tblCLASS WHERE ClassName = @CName)
GO


CREATE OR ALTER PROCEDURE popSeat
@Pname VARCHAR(50),
@ICAO1 VARCHAR(50),
@CName1 VARCHAR(50)
AS

DECLARE @P_ID INT, @CL_ID INT, @SeatName INT

SET @SeatName = (SELECT FLOOR(RAND()*(300-100+1))+100)

EXEC getPlaneID
@PlaneName = @Pname,
@ICAO = @ICAO1,
@Plane_ID = @P_ID OUTPUT

IF @P_ID IS NULL
	BEGIN
		PRINT 'hey @P_ID is NULL...';
		THROW 55656, '@P_ID cannot be null; process is terminating', 1;
	END

EXEC getClassID
@CName = @CName1,
@Class_ID = @CL_ID OUTPUT

BEGIN TRANSACTION T1
INSERT INTO tblSEAT(ClassID, PlaneID, SeatName)
VALUES(@CL_ID, @P_ID, @SeatName)
IF @@ERROR <> 0
	Begin
		PRINT 'Something wrong .. rolling back T1'
		ROLLBACK TRANSACTION T1
	End
ELSE
	COMMIT TRANSACTION T1
GO


CREATE OR ALTER PROCEDURE wrapper_popSEAT
@RUN INT
AS
DECLARE @Pname2 VARCHAR(50), @ICAO2 VARCHAR(50), @CName2 VARCHAR(50)

DECLARE @PlaneRowCount INT = (SELECT COUNT(*) FROM tblPLANE)
DECLARE @ClassRowCount INT = (SELECT COUNT(*) FROM tblClass)
DECLARE @P_PK INT, @C_PK INT

WHILE @RUN > 0
	BEGIN
		SET @P_PK = (SELECT RAND() * @PlaneRowCount + 1)
		SET @C_PK = (SELECT RAND() * @ClassRowCount + 1)

		SET @Pname2 = (SELECT PlaneName FROM tblPLANE WHERE PlaneID = @P_PK)
		SET @ICAO2 = (SELECT ICAO FROM tblPLANE WHERE PlaneID = @P_PK)
		SET @CName2 = (SELECT ClassName FROM tblCLASS WHERE ClassID = @C_PK)

		EXEC popSeat
		@Pname = @Pname2,
		@ICAO1  = @ICAO2,
		@CName1 = @CName2

		SET @RUN = @RUN - 1
	END
GO

EXEC wrapper_popSEAT
@RUN = 100

SELECT * FROM tblSEAT


DELETE FROM tblSEAT 
WHERE PlaneID is not null