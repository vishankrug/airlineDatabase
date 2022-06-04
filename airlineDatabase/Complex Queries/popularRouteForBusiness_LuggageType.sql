-- which route is used the most by business class travelers and which luggage type has been carried on it the most (Cynthia)
USE INFO_430_Proj_04
GO

SELECT TOP 1 A.RouteID, A.LuggageTypeName, A.NumLuggage
FROM
(SELECT R.RouteID, LT.LuggageTypeName, COUNT(LT.LuggageTypeName) AS NumLuggage
FROM tblLUGGAGE_TYPE LT
    JOIN tblLUGGAGE L ON LT.LuggageTypeID = L.LuggageTypeID
    JOIN tblBOOKING B ON B.BookingID = L.BookingID
    JOIN tblROUTE R ON B.RouteID = R.RouteID
GROUP BY R.RouteID, LT.LuggageTypeName) A, 

(SELECT TOP 1 R.RouteID, COUNT(R.RouteID) AS RouteCount
    FROM tblROUTE R
    JOIN tblBOOKING B ON R.RouteID = B.RouteID
    JOIN tblSEAT S ON B.SeatID = S.SeatID
    JOIN tblCLASS C ON S.ClassID = C.ClassID
WHERE C.ClassName = 'Business' 
GROUP BY R.RouteID
ORDER BY RouteCount DESC
) B
WHERE A.RouteID = B.RouteID
ORDER BY NumLuggage DESC

