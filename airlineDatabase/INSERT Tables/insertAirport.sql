---- INSERT INTO tblAirport, city, state, country, region  using data

------------------------- Brian --------------------------
USE INFO_430_Proj_04
GO

SELECT * FROM airport_data$

CREATE TABLE AiportPK (
	AirportID INT IDENTITY(1,1) primary key,
	AirportName VARCHAR(255),
	AirportTypeName  VARCHAR(255),
	ACity VARCHAR(255),
	AState VARCHAR(255),
	ACountry VARCHAR(255),
	ARegion VARCHAR(255),
)
 
INSERT INTO AiportPK(AirportName, AirportTypeName, ACity, AState, ACountry, ARegion)

(SELECT AirportName, AirportType, City, [State], Country_ISO, Region_ISO
FROM airport_data$
WHERE AirportName is not null
AND AirportType is not null
AND	City is not null)


DELETE FROM AiportPK
WHERE AirportID is not null

DROP TABLE AiportPK


DROP TABLE airport_data$

SELECT * FROM airport_data$