----------- Romil --------------

USE INFO_430_Proj_04

GO

CREATE OR ALTER PROCEDURE getProductID
@ProductName1 varchar(100),
@ProductID1 INT OUTPUT --all parameters but one is an output parameter
AS
SET @ProductID1 = (SELECT ProductID FROM tblPRODUCT WHERE ProductName = @ProductName1)
 
GO

--CREATE OR ALTER PROCEDURE getBookingID
--@PassengerID2 INT, 
--@RouteID2 INT,
--@SeatID2 INT,
--@BookingID2 INT OUTPUT
--AS 

--SET @BookingID2 = (SELECT BookingID FROM tblBOOKING WHERE PassengerID = @PassengerID2 
--                    AND RouteID = @RouteID2 AND SeatID = @SeatID2)
 
--GO


CREATE OR ALTER PROCEDURE insertOrder 
@ProductName3 varchar(100),
@FName3 varchar(255),
@LName3 varchar(255),
@DOB3 Date,
@RouteName3 VARCHAR(50),
@SeatName3 VARCHAR(10),
@Quantity3 INT,
@ODate3 Date

AS 

DECLARE @ProductID3 INT, @PassengerID3 INT, @RouteID3 INT, @SeatID3 INT, @BookingID3 INT, @OrderID3 INT

EXEC getProductID
@ProductName1 = @ProductName3,
@ProductID1 = @ProductID3 OUTPUT 

IF @ProductID3 IS NULL
    BEGIN
        PRINT 'Product ID IS NULL';
        THROW 54567, 'Product ID cannot be null, process is terminating', 1;
    END

EXEC getPassengerID
@PassengerFName1 = @FName3,
@PassengerLName1 = @LName3,
@PassengerDOB1 = @DOB3,
@PassengerID = @PassengerID3 OUTPUT

IF @PassengerID3 IS NULL
    BEGIN
        PRINT @FName3;
        PRINT @LName3;
        PRINT @DOB3;
        PRINT 'Passenger ID IS NULL';
        THROW 54568, 'Passenger ID cannot be null, process is terminating', 1;
    END


EXEC getRouteID
@RouteName1 = @RouteName3,
@RouteID1 = @RouteID3 OUTPUT

IF @RouteID3 IS NULL
    BEGIN
        PRINT 'Route ID IS NULL';
        THROW 54569, 'Route ID cannot be null, process is terminating', 1;
    END

EXEC getSeatID
@SeatName1 = @SeatName3,
@SeatID = @SeatID3 OUTPUT

IF @SeatID3 IS NULL
    BEGIN


        PRINT 'Seat ID IS NULL';
        THROW 54570, 'Seat ID cannot be null, process is terminating', 1;
    END


EXEC getBookingID
@F = @FName3,
@L = @LName3,
@DOB = @DOB3,
@RtName = @RouteName3,
@SName = @SeatName3,
@BookingID = @BookingID3 OUTPUT

IF @BookingID3 IS NULL
    BEGIN
        PRINT 'Booking ID IS NULL';
        THROW 54570, 'Booking ID cannot be null, process is terminating', 1;
    END

BEGIN TRANSACTION T1
    INSERT INTO tblORDER(BookingID, OrderDate)
    VALUES (@BookingID3, @ODate3)
    SET @OrderID3 = SCOPE_IDENTITY()
    IF @@ERROR <> 0
        BEGIN 
            PRINT 'There is an error in transaction T1, rolling back.';
            ROLLBACK TRANSACTION T1
        END
    ELSE 
        BEGIN TRANSACTION T2
            INSERT INTO tblORDER_PRODUCT(OrderID, ProductID, Quantity)
            VALUES (@OrderID3, @ProductID3, @Quantity3)
            IF @@ERROR <> 0
                BEGIN
                    PRINT 'There is an error in transaction T2, rolling back.';
                    ROLLBACK TRANSACTION T2
                END
            ELSE 
                COMMIT TRANSACTION T2
                COMMIT TRANSACTION T1

GO


-- wrapper synthetic transaction


CREATE OR ALTER PROCEDURE wrapper_insertOrder
@RUN INT 
AS 

DECLARE @ProductName4 varchar(100), @FName4 varchar(255), @LName4 varchar(255), @DOB4 Date, @RouteName4 VARCHAR(50),
         @SeatName4 VARCHAR(10), @Quantity4 INT, @ODate4 Date

DECLARE @Product_RowCount INT = (SELECT COUNT(*) FROM tblPRODUCT)
DECLARE @Booking_RowCount INT = (SELECT COUNT(*) FROM tblBooking)


DECLARE @ProductID4 INT, @PassengerID4 INT, @RouteID4 INT, @SeatID4 INT, @BookingID4 INT

WHILE @RUN > 0

    BEGIN 

        SET @ProductID4 = (SELECT RAND() * @Product_RowCount + 1)
        SET @BookingID4 = (SELECT RAND() * @Booking_RowCount + 1)

        SET @PassengerID4 = (SELECT PassengerID FROM tblBOOKING WHERE BookingID = @BookingID4)
        SET @SeatID4 = (SELECT SeatID FROM tblBOOKING WHERE BookingID = @BookingID4)
        SET @RouteID4 = (SELECT RouteID FROM tblBOOKING WHERE BookingID = @BookingID4)
        
        SET @Quantity4 = (SELECT RAND() * 10 + 1)
        SET @ODate4 = GetDate()

        SET @ProductName4 = (SELECT ProductName FROM tblPRODUCT WHERE ProductID = @ProductID4)
        SET @FName4 = (SELECT PassengerFname FROM tblPASSENGER WHERE PassengerID = @PassengerID4)
        SET @LName4 = (SELECT PassengerLname FROM tblPASSENGER WHERE PassengerID = @PassengerID4)
        SET @DOB4 = (SELECT PassengerDOB FROM tblPASSENGER WHERE PassengerID = @PassengerID4)
        SET @RouteName4 = (SELECT RouteName FROM tblRoute WHERE RouteID = @RouteID4)
        SET @SeatName4 = (SELECT SeatName FROM tblSEAT WHERE SeatID = @SeatID4)

        EXEC insertOrder 
        @ProductName3 = @ProductName4,
        @FName3 = @FName4,
        @LName3 = @LName4,
        @DOB3 = @DOB4,
        @RouteName3 = @RouteName4,
        @SeatName3 = @SeatName4,
        @Quantity3 = @Quantity4,
        @ODate3 = @ODate4

        SET @RUN = @RUN - 1
    END

GO



EXEC wrapper_insertOrder 50000









-- TroubleShooting code

SELECT * FROM tblORDER


SELECT * FROM tblPASSENGER

SELECT * FROM tblORDER_PRODUCT

/*

select * from sys.foreign_keys


-- FK__tblPRODUC__Produ__398D8EEE

-- FK__tblORDER___Order__3587F3E0

-- FK__tblORDER__Bookin__02FC7413


alter table tblProduct
drop constraint FK__tblPRODUC__Produ__398D8EEE

alter table tblProduct
add constraint fn_product_product_type
foreign key (ProductTypeID)
references tblProduct_Type (ProductTypeID)
on delete cascade;

DELETE FROM tblPRODUCT_Type
WHERE ProductTypeID IS NOT NULL



alter table tblORDER_Product
drop constraint FK__tblORDER___Order__3587F3E0

alter table tblORDER_PRODUCT
add constraint fn_order_order_product
foreign key (OrderID)
references tblOrder (OrderID)
on delete cascade;

DELETE FROM tblORDER_PRODUCT
WHERE OrderProductID IS NOT NULL

DBCC CHECKIDENT ('tblOrder_Product', RESEED, 0);
GO



alter table tblOrder
drop constraint FK__tblORDER__Bookin__02FC7413

alter table tblORDER
add constraint fn_order_booking
foreign key (BookingID)
references tblBooking (BookingID)
on delete cascade;

DELETE FROM tblORDER
WHERE OrderID IS NOT NULL

DBCC CHECKIDENT ('tblOrder', RESEED, 0);
GO
*/