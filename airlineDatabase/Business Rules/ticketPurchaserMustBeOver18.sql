--------------- Business Rules: Cynthia ---------------

-- No people below the age of 18 can purchase a plane ticket
Use INFO_430_Proj_04;

GO
CREATE FUNCTION fn_noUnder18()
RETURNS INT
AS
BEGIN
DECLARE @RET INTEGER = 0
IF EXISTS(SELECT * FROM tblPASSENGER_TYPE PT 
          JOIN tblPASSENGER P ON PT.PassengerTypeID = P.PassengerTypeID
          JOIN tblBOOKING B ON P.PassengerID = B.PassengerID
          WHERE P.PassengerDOB < DATEADD(Year,-18, GETDATE())

)
    BEGIN
        SET @RET = 1
    END   
RETURN @RET
END 
GO

ALTER TABLE tblBOOKING
ADD CONSTRAINT ck_Age18_Booking
CHECK(fn_noUnder18() = 0)