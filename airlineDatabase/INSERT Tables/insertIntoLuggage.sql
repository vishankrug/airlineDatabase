Use INFO_430_Proj_04;
GO

CREATE PROCEDURE insert_into_luggage
@RUN INT
AS

DECLARE @BookingCount INT = (SELECT COUNT(*) FROM tblBOOKING)
DECLARE @LuggageTypeCount INT = (SELECT COUNT(*) FROM tblLUGGAGE_TYPE)

DECLARE @BookingID3 INT, @LuggageWeight3 INT, @LuggageTypeID3 INT

WHILE @RUN > 0
BEGIN

    SET @BookingID3 = (SELECT RAND() * @BookingCount + 1)
    SET @LuggageWeight3 = (SELECT RAND() * 50 + 1)
    SET @LuggageTypeID3 = (SELECT RAND() * @LuggageTypeCount + 1)
    INSERT INTO tblLUGGAGE(BookingID, LuggageWeight, LuggageTypeID)
    VALUES (@BookingID3, @LuggageWeight3, @LuggageTypeID3)

    SET @RUN = @RUN - 1
    END
GO

EXEC insert_into_luggage
@RUN = 100


SELECT * FROM tblLUGGAGE