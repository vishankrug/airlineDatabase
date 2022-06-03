------------------ Romil ------------------

use INFO_430_Proj_04;

-- Which flights are the most popular international flights


SELECT TOP 10 ArrivalCountry.FlightID, ArrivalCountry.FlightName, COUNT(*) AS FlightCount
FROM (SELECT F.FlightID, F.FlightName, CO.CountryID, CO.CountryName
        FROM tblFLIGHT F
            JOIN tblAIRPORT A ON F.ArrivalID = A.AirportID
            JOIN tblCITY C ON A.CityID = C.CityID
            JOIN tblCOUNTRY CO ON C.CountryID = CO.CountryID) ArrivalCountry,
        (SELECT F.FlightID, F.FlightName, CO.CountryID, CO.CountryName
        FROM tblFLIGHT F
            JOIN tblAIRPORT A ON F.ArrivalID = A.AirportID
            JOIN tblCITY C ON A.CityID = C.CityID
            JOIN tblCOUNTRY CO ON C.CountryID = CO.CountryID) DepartureCountry
WHERE ArrivalCountry.CountryID != DepartureCountry.CountryID
GROUP BY ArrivalCountry.FlightID, ArrivalCountry.FlightName
ORDER BY COUNT(*) DESC