--- which planes that were made in the USA OR Canada had the most number of maintenances done between 2020 and 2021
-- Brian


SELECT TOP 10 P.PlaneName, P.ModelOrigin, COUNT(PM.PlaneMaintenanceID) AS totalMaintenance
FROM tblPLANE P
	JOIN tblPLANE_MAINTENANCE PM on P.PlaneID = PM.PlaneID
	JOIN tblMAINTENANCE M on PM.MaintenanceID = M.MaintenanceID
	JOIN tblMAINTENANCE_TYPE MT on M.MaintenanceTypeID = MT.MaintenanceTypeID
WHERE P.ModelOrigin = 'United States' OR P.ModelOrigin = 'Canada'
AND PM.MaintenanceDate BETWEEN '2020-01-01' AND '2021-01-01'
GROUP BY P.PlaneName, P.ModelOrigin
ORDER BY totalMaintenance DESC

SELECT *
FROM tblPLANE_MAINTENANCE