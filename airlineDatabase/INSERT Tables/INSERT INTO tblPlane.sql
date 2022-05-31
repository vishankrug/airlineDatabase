---- INSERT INTO tbl PLANE with using data
---- Brian
USE INFO_430_Proj_04
GO

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

(SELECT PlaneName, ICAO, IATA, Seats, CountryOrigin
FROM planeSeat$
WHERE PlaneName is not null
AND ICAO is not null
AND IATA is not null
AND Seats is not null
AND CountryOrigin is not null)


SELECT *
FROM planesSeatsDataPK
GO

CREATE OR ALTER PROCEDURE getPlaneID
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

SELECT * FROM tblPLANE
GO

SELECT * FROM tblPLANE_TYPE
GO


DECLARE @PT_ID INT, @PT_COUNT INT
SET @PT_COUNT = (SELECT COUNT(*) FROM tblPLANE_TYPE)
SET @PT_ID = (SELECT RAND() * @PT_COUNT + 1)
INSERT INTO tblPLANE(PlaneTypeID, PlaneName, ICAO, IATA, ModelOrigin, SeatCount)
SELECT @PT_ID, PlaneName, ICAO, IATA, CountryOrigin, Seats
FROM planesSeatsDataPK



SELECT *
FROM planesSeatsDataPK

SELECT *
FROM tblPLANE