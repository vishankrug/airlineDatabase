----------------- Romil -------------------

-- Which employee that is the longest serving employee that also worked at least 3 different roles

USE INFO_430_Proj_04;

SELECT E.EmployeeID, E.FName, E.LName, DATEDIFF(Year, E.StartDate, GetDate()) [Years Served]
FROM tblEmployee E 
    JOIN tblEmployee_Flight EF ON E.EmployeeID = EF.EmployeeID
    JOIN tblRole R ON EF.RoleID = R.RoleID  
GROUP BY E.EmployeeID, E.FName, E.LName, E.StartDate
HAVING COUNT(R.RoleID) >= 3 
ORDER BY DATEDIFF(Year, E.StartDate, GetDate())

