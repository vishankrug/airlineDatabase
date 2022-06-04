-- Which city has the most flights per year (arrival)
-- Vishank

Use INFO_430_Proj_04;


SELECT TOP 10 C.CityName, Count(F.FlightID) AS numberOfFlights
FROM tblCITY C
JOIN tblAIRPORT A ON A.CityID = C.CityID
JOIN tblFLIGHT F ON F.ArrivalID = A.AirportID
GROUP BY C.CityName
ORDER BY numberOfFlights DESC