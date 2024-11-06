--Задача 1. Посчитать средний чек одного заказа.

SELECT AVG(OrderTotal) AS 'Средний чек одного заказа'
FROM (
    SELECT o.OrderID, SUM(od.Quantity * p.Price) AS OrderTotal
    FROM Orders o
    JOIN OrderDetails od ON o.OrderID = od.OrderID
    JOIN Products p ON od.ProductID = p.ProductID
    GROUP BY o.OrderID
);
--result = 1971,55

/*Задача 2. Посчитать сколько заказов доставляет в месяц
каждая служба доставки.
Определите, сколько заказов доставила United
Package в декабре 2023 года*/

SELECT 
    s.ShipperName, 
    strftime('%Y-%m', o.OrderDate) AS Month,
    COUNT(o.OrderID) AS 'Заказов доставлено'
FROM Orders o
JOIN Shippers s ON o.ShipperID = s.ShipperID
GROUP BY s.ShipperName, Month
ORDER BY s.ShipperName, Month;

SELECT 
	s.ShipperName, 
	COUNT(o.OrderID) AS 'Заказов доставлено'
FROM Orders o
JOIN Shippers s ON o.ShipperID = s.ShipperID
WHERE s.ShipperName = 'United Package'
  AND strftime('%Y-%m', o.OrderDate) = '2023-12'
GROUP BY s.ShipperName;
--result = 8

/*Задача 3. Определить средний LTV покупателя (сколько
денег покупатели в среднем тратят в магазине
за весь период)*/

SELECT 
    AVG(CustomerTotal) AS 'Средний LTV покупателя'
FROM (
    SELECT 
        o.CustomerID,
        SUM(od.Quantity * p.Price) AS CustomerTotal
    FROM Orders o
    JOIN OrderDetails od ON o.OrderID = od.OrderID
    JOIN Products p ON od.ProductID = p.ProductID
    GROUP BY o.CustomerID
) AS CustomerTotals;
--result = 5221,94

