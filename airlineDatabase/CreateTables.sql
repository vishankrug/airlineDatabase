Use INFO_430_Proj_04;

--------------------LOOK UP TABLES---------------------------------------
-- Vishank
CREATE TABLE tblPRODUCT_TYPE(
    ProductTypeID INT IDENTITY(1,1) primary key,
    ProductTypeName varchar(100),
    ProductTypeDescr varchar(255)
)
GO

CREATE TABLE tblPRODUCT(
    ProductID INT IDENTITY(1,1) primary key,
    ProductTypeID INT FOREIGN KEY REFERENCES tblPRODUCT_TYPE(ProductTypeID) not null,
    ProductName varchar(100) not null,
    ProductPrice numeric(8,2) not null
)
GO

CREATE TABLE tblORDER_PRODUCT(
    OrderProductID INT IDENTITY(1,1) primary key,
    ProductID INT FOREIGN KEY REFERENCES tblPRODUCT(ProductID) not null,
    Quantity INT not null,
	OrderID INT FOREIGN KEY REFERENCES tblORDER(OrderID) not null
)
GO

CREATE TABLE tblPASSENGER_TYPE(
    PassengerTypeID INT IDENTITY(1,1) primary key,
    PassengerTypeName varchar(255) not null,
    PassengerTypeDescr varchar(255)

)
GO

CREATE TABLE tblPASSENGER(
    PassengerID INT IDENTITY(1,1) primary key,
    PassengerTypeID INT FOREIGN KEY REFERENCES tblPASSENGER_TYPE(PassengerTypeID) not null,
    PassengerFname varchar(255) not null,
    PassengerLname varchar(255) not null,
    PassengerDOB Date,
    PassengerAddress varchar(255) not null,
    PassengerCity varchar(255) not null,
    PassengerState varchar(100),
    PassengerZIP varchar(50) not null
)
GO

CREATE TABLE tblLUGGAGE_TYPE(
    LuggageTypeID INT IDENTITY(1,1) primary key,
    LuggageTypeName varchar(100) not null,
    LuggageTypeDescription varchar(255)
)
GO

-------------------------- Cynthia's tables (05/10) --------------------------
CREATE TABLE tblMAINTENANCE_TYPE (
    MaintenanceTypeID INT IDENTITY(1,1) PRIMARY KEY,
    MaintenanceTypeName VARCHAR(100),
    MaintenanceTypeDescr VARCHAR(600)
)
GO

CREATE TABLE tblMAINTENANCE (
    MaintenanceID INT IDENTITY(1,1) PRIMARY KEY,
    MaintenanceName VARCHAR(100),
    MaintenanceTypeID INT FOREIGN KEY REFERENCES tblMAINTENANCE_TYPE(MaintenanceTypeID) NOT NULL
)
GO

CREATE TABLE tblPLANE_TYPE (
    PlaneTypeID INT IDENTITY(1,1) PRIMARY KEY,
    PlaneTypeName VARCHAR(100),
    PlaneTypeDescr VARCHAR(200)
)
GO

CREATE TABLE tblPLANE (
	PlaneID INT IDENTITY(1,1) Primary Key,
    PlaneTypeID INT FOREIGN KEY REFERENCES tblPLANE_TYPE(PlaneTypeID),
    PlaneID INT IDENTITY(1,1) PRIMARY KEY,
	PlaneName VARCHAR(100),
	ICAO VARCHAR(10),
	IATA VARCHAR(10),
	ModelOrigin VARCHAR(100),
	SeatCount INT
)
GO

CREATE TABLE tblPLANE_MAINTENANCE (
    PlaneMaintenanceID INT IDENTITY(1,1) PRIMARY KEY,
    MaintenanceDate DATE,
    PlaneID INT FOREIGN KEY REFERENCES tblPLANE(PlaneID),
    MaintenanceID INT FOREIGN KEY REFERENCES tblMAINTENANCE(MaintenanceID)
)
GO

CREATE TABLE tblCLASS (
    ClassID INT IDENTITY(1,1) PRIMARY KEY,
    ClassName VARCHAR(100),
    ClassDescr VARCHAR(200),
)
GO

CREATE TABLE tblSEAT (
    SeatID INT IDENTITY(1,1) PRIMARY KEY,
    ClassID INT FOREIGN KEY REFERENCES tblCLASS(ClassID),
    PlaneID INT FOREIGN KEY REFERENCES tblPLANE(PlaneID),
    SeatName VARCHAR(10),
)
GO


-----------Brian's Tables----------------------------------

-- city, country, region, flights, flighttype, airport, airporttype

CREATE TABLE tblREGION (
    RegionID INT IDENTITY(1,1) PRIMARY KEY,
    RegionName VARCHAR(100)
)
GO

CREATE TABLE tblCOUNTRY (
    CountryID INT IDENTITY(1,1) PRIMARY KEY,
    RegionID INT FOREIGN KEY REFERENCES tblREGION(RegionID),
    CountryName VARCHAR(100),
    CountryCode VARCHAR(10)
)
GO


CREATE TABLE tblCITY (
    CityID INT IDENTITY(1,1) PRIMARY KEY,
    CountryID INT FOREIGN KEY REFERENCES tblCOUNTRY(CountryID),
    CityName VARCHAR(100)
)
GO

CREATE TABLE tblAIRPORT_TYPE (
    AirportTypeID INT IDENTITY(1,1) PRIMARY KEY,
    AirportTypeName VARCHAR(100),
    AirportTypeDescr VARCHAR(100)
)
GO


CREATE TABLE tblAIRPORT (
    AirportID INT IDENTITY(1,1) PRIMARY KEY,
    AirportTypeID INT FOREIGN KEY REFERENCES tblAIRPORT_TYPE(AirportTypeID),
    CityID INT FOREIGN KEY REFERENCES tblCITY(CityID),
    AirportName VARCHAR(200)
)
GO

-- ALTER TABLE tblAIRPORT
-- ADD AirportName VARCHAR(200)

CREATE TABLE tblFLIGHT_TYPE (
    FlightTypeID INT IDENTITY(1,1) PRIMARY KEY,
    FlightTypeName VARCHAR(100),
    FlightTypeDescr VARCHAR(100)
)
GO

-- ALTER TABLE tblFLIGHT
-- ALTER COLUMN ArrivalTime datetime

-- ALTER TABLE tblFLIGHT
-- ALTER COLUMN DepartureTime datetime

-- ALTER TABLE tblFLIGHT
-- ALTER COLUMN FlightName varchar(255)

CREATE TABLE tblFLIGHT (
    FlightID INT IDENTITY(1,1) PRIMARY KEY,
    FlightTypeID INT FOREIGN KEY REFERENCES tblFLIGHT_TYPE(FlightTypeID),
    ArrivalID INT FOREIGN KEY REFERENCES tblAIRPORT(AirportID),
    DepartureID INT FOREIGN KEY REFERENCES tblAIRPORT(AirportID),
    FlightName VARCHAR(255),
    ArrivalTime datetime,
    DepartureTime datetime,
    Miles INT
)
GO

--------------------- Romil's Tables ----------------------
-- order, route, routeFlights, employee, employee_type, employeeFlight, role

CREATE TABLE tblROUTE(
    RouteID INT IDENTITY(1,1) PRIMARY KEY,
    RouteName Varchar(50)
)
GO

CREATE TABLE tblROUTE_FLIGHTS(
    RouteFlightsID INT IDENTITY(1,1) PRIMARY KEY,
    RouteID INT FOREIGN KEY REFERENCES tblROUTE(RouteID),
    FlightID INT FOREIGN KEY REFERENCES tblFLIGHT(FlightID),
)
GO

CREATE TABLE tblEMPLOYEE_TYPE(
    EmployeeTypeID INT IDENTITY(1,1) PRIMARY KEY,
    EmployeeTypeName Varchar(100),
    EmployeeTypeDescr Varchar(200)
)
GO

CREATE TABLE tblEMPLOYEE (
    EmployeeID INT IDENTITY(1,1) PRIMARY KEY,
    EmployeeTypeID INT FOREIGN KEY REFERENCES tblEMPLOYEE_TYPE(EmployeeTypeID),
    FName VARCHAR(100),
    LNAME VARCHAR(100),
    DateOfBirth DATE,
    StartDate DATE,
    EndDate DATE
)
GO

CREATE TABLE tblROLE (
    RoleID INT IDENTITY(1,1) PRIMARY KEY,
    RoleName VARCHAR(100),
    RoleDescription VARCHAR(900)
)
GO

CREATE TABLE tblEMPLOYEE_FLIGHT(
    EmployeeFlightID INT IDENTITY(1,1) PRIMARY KEY,
    FlightID INT FOREIGN KEY REFERENCES tblFLIGHT(FlightID),
    EmployeeID INT FOREIGN KEY REFERENCES tblEMPLOYEE(EmployeeID),
    RoleID INT FOREIGN KEY REFERENCES tblROLE(RoleID)
)
GO

CREATE TABLE tblBOOKING(
    BookingID INT IDENTITY(1,1) primary key,
    PassengerID INT FOREIGN KEY REFERENCES tblPASSENGER(PassengerID) not null,
    RouteID INT FOREIGN KEY REFERENCES tblROUTE(RouteID) not null,
    SeatID INT FOREIGN KEY REFERENCES tblSEAT(SeatID) not null
)
GO

CREATE TABLE tblORDER(
    OrderID INT IDENTITY(1,1) PRIMARY KEY,
    BookingID INT FOREIGN KEY REFERENCES tblBOOKING(BookingID),
    OrderDate Date,
    OrderTotal MONEY
)
GO

CREATE TABLE tblLUGGAGE(
    LuggageID INT IDENTITY(1,1) primary key,
    BookingID INT FOREIGN KEY REFERENCES tblBOOKING(BookingID) not null,
    LuggageWeight INT not null,
    LuggageTypeID INT FOREIGN KEY REFERENCES tblLUGGAGE_TYPE(LuggageTypeID) not null
)
GO


BACKUP DATABASE INFO_430_Proj_04 TO DISK = 'C:\SQL\INFO_430_Proj_04.BAK'
