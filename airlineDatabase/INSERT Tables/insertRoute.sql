USE INFO_430_Proj_04

GO

--------- INSERT ROUTE -----------
---- Brian --------------
SELECT * FROM tblROUTE

SELECT * FROM routes$

ALTER TABLE routes$
DROP COLUMN [2B], F2, F4, F6


CREATE TABLE tempROUTE(
RouteID INT IDENTITY(1,1) primary Key,
Departure varchar(10),
Arrival varchar(10),
PlaneRoute varchar(10)
)

INSERT INTO tempRoute
SELECT *, CONCAT(Departure, '-', Arrival) AS PlaneRoute
FROM routes$

SELECT * FROM tempROUTE



INSERT INTO tblROUTE (RouteName)
SELECT PlaneRoute
FROM tempROUTE



SELECT * FROM tblPASSENGER