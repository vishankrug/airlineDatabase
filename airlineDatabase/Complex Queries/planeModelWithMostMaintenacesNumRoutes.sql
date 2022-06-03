-- find the planes with the most maintenances performed on it and the number of routes its flown on
USE INFO_430_Proj_04
GO

SELECT TOP 10 A.PlaneID, A.PlaneName, A.NumMaintenances, B.RouteCount
FROM 
(SELECT P.PlaneID,  P.PlaneName, COUNT(PM.PlaneID) AS NumMaintenances
FROM tblPLANE P 
    JOIN tblPLANE_MAINTENANCE PM ON P.PlaneID = PM.PlaneID 
    JOIN tblMAINTENANCE M ON PM.MaintenanceID = M.MaintenanceID
    JOIN tblMAINTENANCE_TYPE MT ON M.MaintenanceTypeID = MT.MaintenanceTypeID
GROUP BY P.PlaneID, P.PlaneName) A, 

(SELECT P.PlaneID, COUNT(R.RouteID) AS RouteCount
FROM tblPLANE P
    JOIN tblSEAT S ON P.PlaneID = S.PlaneID
    JOIN tblBOOKING B ON S.SeatID = B.SeatID
    JOIN tblROUTE R ON B.RouteID = R.RouteID
    JOIN tblPLANE_TYPE PT ON P.PlaneTypeID = PT.PlaneTypeID
GROUP BY P.PlaneID) B
WHERE A.PlaneID = B.PlaneID 
ORDER BY A.NumMaintenances DESC