---- INSERT INTO tbl PLANE with using data
---- Brian


SELECT * FROM planeSeat$


CREATE TABLE planesSeatsDataPK (
	PlaneID INT IDENTITY(1,1) primary key,
	PlaneName varchar(100) not null,
	ICAO varchar(50) not null,
	IATA varchar(50) not null,
	Seats INT,
	CountryOrigin varchar(50) not null
)

INSERT INTO planesSeatsDataPK (PlaneName, ICAO, IATA, Seats, CountryOrigin)

(SELECT PlaneName, ICAO, IATA, TotalSeats, CountryOrigin
FROM planeSeat$
WHERE PlaneName is not null
AND ICAO is not null
AND IATA is not null
AND TotalSeats is not null
AND CountryOrigin is not null)


SELECT *
FROM planesSeatsDataPK

CREATE PROCEDURE getPlaneID
@PlaneName Varchar(100),
@P_ID INT OUTPUT
AS
SET @P_ID = (SELECT PlaneID FROM planesSeatsDataPK WHERE PlaneName = @PlaneName)
GO

CREATE PROCEDURE getPlaneTypeID
@PTName Varchar(100),
@PT_ID INT OUTPUT
AS
SET @PT_ID = (SELECT PlaneTypeID FROM tblPLANE_TYPE WHERE PlaneTypeName = @PTName)
GO


-- (PlaneName, SeatCount, PlaneTypeID, ModelOrigin, ICAO, IATA)
CREATE PROCEDURE insertPlanes
@PlaneName1 VARCHAR(100),
@Seat INT,
@PTypeName VARCHAR(100),
@MOrigin VARCHAR(50),
@ICAO VARCHAR(10),
@IATA VARCHAR(10)
AS

DECLARE @Plane_ID INT, @PType_ID INT

EXEC getPlaneID
@PlaneName = @PlaneName1,
@P_ID = @Plane_ID OUTPUT

IF @PlaneName1 is null
	BEGIN
		PRINT '@PlaneName1 cannot be null';
		THROW 55665, '@PlaneName1 cannot be null; process is terminating', 1;
	END


EXEC getPlaneTypeID
@PTName = @PTypeName,
@PT_ID = @PType_ID OUTPUT

IF @PTypeName is null
	BEGIN
		PRINT '@TypeName cannot be null';
		THROW 55665, '@PTypeName cannot be null; process is terminating', 1;
	END

BEGIN TRANSACTION T1
INSERT INTO tblPLANE (PlaneID, PlaneName, SeatCount, PlaneTypeID, ModelOrigin, ICAO, IATA)
VALUES (@Plane_ID, @PlaneName1, @Seat, @PType_ID, @MOrigin, @ICAO, @IATA)
IF @@ERROR <> 0
	Begin
		PRINT 'Something wrong .. rolling back T1'
		ROLLBACK TRANSACTION T1
	End
ELSE
	COMMIT TRANSACTION T1
GO


EXEC insertPlanes
@PlaneName1 = 'Boeing 747SP',
@Seat = '316',
@PTypeName = 'Intercontinental',
@MOrigin = 'United States',
@ICAO = 'N74S',
@IATA = '74L'