-- Complex query
-- Which products are the most popular for passengers in first class?
-- that is also the most popular for passenger type 'VIP'
-- Brian



SELECT TOP 10 A.ProductName, A.TotalOrders
FROM
(SELECT PR.ProductName, COUNT(OP.OrderProductID) AS TotalOrders
FROM tblPASSENGER P
	JOIN tblBOOKING B on P.PassengerID = B.PassengerID
	JOIN tblORDER O on B.BookingID = O.BookingID
	JOIN tblORDER_PRODUCT OP on O.OrderID = OP.OrderID
	JOIN tblPRODUCT PR on OP.ProductID = PR.ProductID
	JOIN tblPASSENGER_TYPE PT on P.PassengerTypeID = PT.PassengerTypeID
	JOIN tblSEAT S on B.SeatID = S.SeatID
	JOIN tblCLASS C on S.ClassID = C.ClassID
WHERE C.ClassName = 'First'
GROUP BY PR.ProductName) A,

(SELECT PR.ProductName, COUNT(OP.OrderProductID) AS TotalOrders
FROM tblPASSENGER P
	JOIN tblBOOKING B on P.PassengerID = B.PassengerID
	JOIN tblORDER O on B.BookingID = O.BookingID
	JOIN tblORDER_PRODUCT OP on O.OrderID = OP.OrderID
	JOIN tblPRODUCT PR on OP.ProductID = PR.ProductID
	JOIN tblPASSENGER_TYPE PT on P.PassengerTypeID = PT.PassengerTypeID
	JOIN tblSEAT S on B.SeatID = S.SeatID
	JOIN tblCLASS C on S.ClassID = C.ClassID
WHERE PT.PassengerTypeName = 'VIP'
GROUP BY PR.ProductName) B

WHERE A.ProductName = B.ProductName
ORDER BY A.TotalOrders DESC


SELECT * FROM tblORDER_PRODUCT


SELECT * FROM tblPASSENGER_TYPE
SELECT * FROM tblPASSENGER
