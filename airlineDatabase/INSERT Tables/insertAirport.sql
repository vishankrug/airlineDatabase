---- INSERT INTO tblAirport, city, state, country, region  using data

------------------------- Brian --------------------------
USE INFO_430_Proj_04
GO
DROP TABLE airport_data$
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


SELECT * FROM airport_data$

-- insert tblREGION
INSERT INTO tblREGION (RegionName)
SELECT DISTINCT REGION
FROM airport_data$
GO

-- insert tblCOUNTRY
INSERT INTO tblCOUNTRY (RegionID, CountryName)
SELECT DISTINCT R.RegionID, iso_country
FROM airport_data$ A
	JOIN tblREGION R on A.REGION = R.RegionName
GO


-- insert tblCITY

INSERT INTO tblCITY (CountryID, CityName)
SELECT DISTINCT C.CountryID, A.CITY
FROM airport_data$ A
	JOIN tblREGION R on A.REGION = R.RegionName
	JOIN tblCOUNTRY C on R.RegionID = C.RegionID
WHERE A.CITY is not null
GO


-- insert tblAIRPORT_TYPE AND tblAIRPORT

DELETE FROM tblAIRPORT_TYPE
WHERE AirportTypeID is not null


DECLARE @AT_ID INT
BEGIN TRANSACTION T1
INSERT INTO tblAIRPORT_TYPE (AirportTypeName)
SELECT DISTINCT type
FROM airport_data$
SET @AT_ID = SCOPE_IDENTITY()

IF @@ERROR <> 0
	BEGIN
		ROLLBACK TRANSACTION T1
	END

	ELSE 
		BEGIN TRANSACTION T2

		INSERT INTO tblAIRPORT (AirportTypeID, CityID, AirportName)
		SELECT DISTINCT @AT_ID, CI.CityID, A.[name]
		FROM airport_data$ A
			JOIN tblREGION R on A.REGION = R.RegionName
			JOIN tblCOUNTRY C on R.RegionID = C.RegionID
			JOIN tblCITY CI on C.CountryID = CI.CountryID
		WHERE A.CITY is not null

		IF @@ERROR <> 0
            BEGIN
                PRINT('Error, cannot insert into Order_Product')
                ROLLBACK TRANSACTION T2
            END
        ELSE
			COMMIT TRANSACTION T2
            COMMIT TRANSACTION T1




SELECT COUNT(AirportID)
FROM tblAIRPORT

SELECT *
FROM tblAIRPORT_TYPE


SELECT DISTINCT CI.CityID, A.[name]
FROM airport_data$ A
	JOIN tblREGION R on A.REGION = R.RegionName
	JOIN tblCOUNTRY C on R.RegionID = C.RegionID
	JOIN tblCITY CI on C.CountryID = CI.CountryID


SELECT DISTINCT AirportName
FROM tblAIRPORT

UPDATE tblAIRPORT
SET AirportName = AirportName..
WHERE DISTINCT AirportName;