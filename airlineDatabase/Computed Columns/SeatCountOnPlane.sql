-- computed column: Available seats = total seats - filled seats
Use INFO_430_Proj_04;

GO
CREATE OR ALTER FUNCTION fn_CalcAvailableSeats (@PK INT)
RETURNS INT
AS 
BEGIN
DECLARE @RET INT = (SELECT COUNT(DISTINCT SeatName) AS NumSeats FROM tblSEAT S 
                                    JOIN tblPLANE P ON S.PlaneID = P.PlaneID
                                WHERE P.PlaneID = @PK)
RETURN @RET
END
GO

ALTER TABLE tblPlane
ADD Seat_Count AS (dbo.fn_CalcAvailableSeats(PlaneID))



SELECT * FROM tblPLANE