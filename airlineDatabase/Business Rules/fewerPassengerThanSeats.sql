----------------- Romil -------------------

USE INFO_430_Proj_04;

GO 

-- SELECT * FROM tblPLANE

-- Planes should have fewer passengers than the available seats

CREATE FUNCTION fewerPassengerThanSeats()
RETURNS INT 
AS 
BEGIN 

DECLARE @RET INT = 0
IF EXISTS (SELECT *
            FROM tblPLANE 
            WHERE SeatCount < 1 )
            BEGIN 
                SET @RET = 1
            END
RETURN @RET
END

GO

ALTER TABLE tblBooking
ADD CONSTRAINT Cn_fewerPassengerThanSeats
CHECK (dbo.fewerPassengerThanSeats() = 0)


