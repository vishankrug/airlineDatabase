--------- POPULATE tblSEAT --------------

-------- BRIAN -----------------------

SELECT * FROM tblSEAT
GO

CREATE PROCEDURE getPlaneID
@PlaneName VARCHAR(50),
@ICAO VARCHAR(50),
@Plane_ID INT OUTPUT
AS

SET @PLANE_ID = (SELECT PlaneID FROM tblPLANE WHERE PlaneName = @PlaneName AND ICAO = @ICAO)
GO


CREATE PROCEDURE getClassID
@CName VARCHAR(50),
@C_ID INT OUTPUT
AS

SET @C_ID = (SELECT ClassID FROM tblCLASS WHERE ClassName = @CName)
GO

CREATE PROCEDURE popSeat
@Pname VARCHAR(50),
@Pname VARCHAR(50),
@CName VARCHAR(50)

