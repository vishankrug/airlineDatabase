Begin Try
	Use Master;
	If Exists(Select Name From SysDatabases Where Name = 'INFO_430_Proj_04')
	 Begin 
	  Alter Database [INFO_430_Proj_04] set Single_user With Rollback Immediate;
	  Drop Database INFO_430_Proj_04;
	 End
	Create Database INFO_430_Proj_04;
End Try
Begin Catch
	Print Error_Number();
End Catch
go

Use INFO_430_Proj_04;

BACKUP DATABASE INFO_430_Proj_04 TO DISK = 'C:\SQL\INFO_430_Proj_04.BAK'

CREATE TABLE tblPRODUCT_TYPE(
    ProductTypeID INT IDENTITY(1,1) primary key,
    ProductTypeName varchar(50),
    ProductTypeDescr varchar(255)
)
GO

CREATE TABLE tblPRODUCT(
    ProductID INT IDENTITY(1,1) primary key,
    ProductTypeID INT FOREIGN KEY REFERENCES tblPRODUCT_TYPE(ProductTypeID) not null,
    ProductName varchar(50) not null,
    ProductPrice Money not null
)
GO


CREATE TABLE tblORDER_PRODUCT(
    OrderProductID INT IDENTITY(1,1) primary key,
    ProductID INT FOREIGN KEY REFERENCES tblPRODUCT(ProductID) not null,
    Quantity INT not null
)
GO

CREATE TABLE tblPASSENGER_TYPE(
    PassengerTypeID INT IDENTITY(1,1) primary key,
    PassengerTypeName varchar(255) not null,
    PassengerTypeDescr varchar(255)

)

CREATE TABLE tblPASSENGER(
    PassengerID INT IDENTITY(1,1) primary key,
    PassengerTypeID INT FOREIGN KEY REFERENCES tblPASSENGER_TYPE(PassengerTypeID) not null,
    PassengerFname varchar(30) not null,
    PassengerLname varchar(30) not null,
    PassengerDOB Date,
    PassengerAddress varchar(255) not null,
    PassengerCity varchar(255) not null,
    PassengerState varchar(50),
    PassengerZIP varchar(50) not null
)
GO

CREATE TABLE tblBOOKING(
    BookingID INT IDENTITY(1,1) primary key,
    PassengerID INT FOREIGN KEY REFERENCES tblPASSENGER(PassengerID) not null,
    RouteID INT FOREIGN KEY REFERENCES tblROUTE(RouteID) not null,
    SeatID INT FOREIGN KEY REFERENCES tblSEAT(SeatID) not null
)

CREATE TABLE tblLUGGAGE_TYPE(
    LuggageTypeID INT IDENTITY(1,1) primary key,
    LuggageTypeName varchar(50) not null,
    LuggageTypeDescription varchar(255)
)
GO

CREATE TABLE tblLUGGAGE(
    LuggageID INT IDENTITY(1,1) primary key,
    BookingID INT FOREIGN KEY REFERENCES tblBOOKING(BookingID) not null,
    LuggageWeight INT not null,
    LuggageTypeID INT FOREIGN KEY REFERENCES tblLUGGAGE_TYPE(LuggageTypeID) not null
)
GO

