
-- Business rule: Economy class passengers cannot check in an overweight bag (Cynthia) --
CREATE FUNCTION [dbo].[fn_noCkBagEconomy]()
RETURNS INT
AS
BEGIN
DECLARE @RET INTEGER = 0
IF EXISTS(SELECT * FROM tblBOOKING B
          JOIN tblLUGGAGE L  ON B.BookingID = L.BookingID
          JOIN tblSEAT S ON B.SeatID = S.SeatID 
          JOIN tblCLASS C ON S.ClassID = C.ClassID
          JOIN tblLUGGAGE_TYPE LT ON L.LuggageTypeID = LT.LuggageTypeID
          WHERE C.ClassName = 'Economy' AND LT.LuggageTypeName = 'Overweight'
)
    BEGIN
        SET @RET = 1
    END   
RETURN @RET
END 
GO
