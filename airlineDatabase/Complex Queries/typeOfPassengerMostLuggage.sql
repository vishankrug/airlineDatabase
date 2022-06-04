-- What type of passenger carries the most luggage by count that is also flying to North America
-- Vishank

Use INFO_430_Proj_04;

SELECT PT.PassengerTypeName, COUNT(L.LuggageID) AS LuggageCount
FROM tblPASSENGER_TYPE PT
JOIN tblPASSENGER P ON P.PassengerTypeID = PT.PassengerTypeID
JOIN tblBOOKING B ON B.PassengerID = P.PassengerID
JOIN tblLUGGAGE L ON L.BookingID = B.BookingID
JOIN tblROUTE R ON B.RouteID = R.RouteID
JOIN tblROUTE_FLIGHTS RF ON R.RouteID = RF.RouteID
JOIN tblFLIGHT F ON F.FlightID = RF.FlightID
JOIN tblAIRPORT A ON F.ArrivalID = A.AirportID
JOIN tblCITY C ON C.CityID = A.CityID
JOIN tblCOUNTRY CO ON CO.CountryID = C.CountryID
JOIN tblREGION RE ON RE.RegionID = CO.RegionID
WHERE RE.RegionName = 'NA'
GROUP BY PT.PassengerTypeName