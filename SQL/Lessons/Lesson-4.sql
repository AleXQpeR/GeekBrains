/*Задание 1
Рассчитайте среднее количество товаров,
заказанных каждым покупателем (используя
оконную функцию).
*/
---Групировка с агрегирующей функцией:
SELECT 
	AVG(Quantity),
	CustomerID 
FROM Orders o 
JOIN OrderDetails od ON o.OrderID = od.OrderID 
GROUP BY o.CustomerID;

---Оконная функция:
SELECT 
	AVG(Quantity) OVER(PARTITION BY o.CustomerID),
	CustomerID 
FROM Orders o 
JOIN OrderDetails od ON o.OrderID = od.OrderID;

/*Задание 2
Определите первую и последнюю даты
заказа для каждого клиента
*/
---Классическая групировка
SELECT 
	min(OrderDate),
	max(OrderDate),
	count(*),
	CustomerID 
FROM Orders o 
GROUP BY CustomerID;

---Оконная функция
SELECT DISTINCT 
	min(OrderDate) OVER (PARTITION BY CustomerID) AS min_date,
	max(OrderDate)  OVER (PARTITION BY CustomerID) AS max_date,
	count(*)  OVER (PARTITION BY CustomerID) AS cnt,
	CustomerID 
FROM Orders o;

/*Задание 3
Получите общее количество заказов для
каждого клиента, а также имя и город клиента.
*/
---Классическая групировка
SELECT 
	c.CustomerID,
	City,
	COUNT(*) 
FROM Orders o 
JOIN Customers c ON o.CustomerID = c.CustomerID 
GROUP BY c.CustomerID 

---Оконная фунция
SELECT DISTINCT 
	c.CustomerID,
	City,
	OrderDate,
	COUNT(*) OVER(PARTITION BY c.CustomerID) AS cnt
FROM Orders o 
JOIN Customers c ON o.CustomerID = c.CustomerID 

/*Задание 4
Ранжируйте сотрудников на основе общего
количества обработанных ими заказов.
*/
SELECT 
	EmployeeID,
	RANK() OVER(ORDER BY count(OrderID)) AS EmployeeRank
FROM Orders o 
GROUP BY EmployeeID;

/*Задание 5
Определите среднюю цену товаров внутри
каждой категории, рассматривая только
категории, в которых более трех товаров.
*/

WITH product_prices AS (SELECT DISTINCT 
	CategoryID,
	AVG(Price) OVER (PARTITION BY CategoryID) AS avg_price,
	COUNT(ProductID) OVER (PARTITION BY CategoryID) AS cnt 
FROM Products p )
SELECT *
FROM product_prices
WHERE cnt > 9;

/*Задание 6
Рассчитайте процент от общего объема (выручки)
продаж каждого продукта в своей категории.
*/
SELECT 
	ProductName,
	SUM(Price * Quantity) / SUM(sum(Price * Quantity)) OVER (PARTITION BY CategoryID) * 100 AS cash
FROM OrderDetails od 
JOIN Products p ON p.ProductID = od.ProductID 
GROUP BY p.ProductID, CategoryID;

/*Задание 7
Для каждого заказа сделайте новую колонку
в которой определите общий объем продаж
за каждый месяц, учитывая все годы.
*/
SELECT 
	YEAR(o.OrderDate),
	MONTH (o.OrderDate),
	SUM(Quantity * Price) 
			OVER (PARTITION BY MONTH(o.OrderDate),
			YEAR(o.OrderDate) ORDER BY YEAR(o.OrderDate)) AS TotalSales
FROM Orders o 
JOIN OrderDetails od ON o.OrderID = od.OrderID 
JOIN Products p ON p.ProductID = od.ProductID;

/*Задание 8
Вам поручено анализировать совокупные продажи в
двух европейских городах (Лондоне и Мадриде) к
концу каждой недели с начала апреля 2023 года.
Используйте оконные функции SQL для расчета и
отслеживания совокупных продаж с течением
времени в этих двух городах.
*/
SELECT
OrderDate,
City,
SUM(Quantity) OVER (PARTITION BY City
ORDER BY OrderDate) AS CumulativeSales
FROM (
SELECT
o.OrderDate,
c.City,
od.Quantity
FROM Orders o
JOIN Customers c ON o.CustomerID =
c.CustomerID
JOIN OrderDetails od ON o.OrderID =
od.OrderID
WHERE (c.City = 'London' OR c.City = 'Madrid')
AND o.OrderDate >= '2023-04-01'
) AS CumulativeSales
ORDER BY orderdate;

/*Задание 9
Рассчитайте промежуточную сумму заказанных
количеств для каждого продукта.
*/
SELECT
	OrderID,
	ProductID,
	Quantity,
SUM(Quantity) OVER (PARTITION BY
ProductID ORDER BY OrderID) AS
RunningTotal
FROM OrderDetails

/*Задание 10
Рассчитайте разницу в общем объеме продаж за
каждый день по сравнению с предыдущим днем.
*/
SELECT
OrderDate,
SUM(Quantity * Price) AS DailySales,
LAG(SUM(Quantity * Price)) OVER (ORDER
BY OrderDate) AS PreviousDaySales,
SUM(Quantity * Price) - LAG(SUM(Quantity
* Price)) OVER (ORDER BY OrderDate) AS
SalesDifference
FROM Orders
JOIN OrderDetails ON Orders.OrderID =
OrderDetails.OrderID
JOIN Products ON OrderDetails.ProductID =
Products.ProductID
GROUP BY OrderDate;

/*Задание 11
Рассчитайте среднюю стоимость заказа для
каждого сотрудника, учитывая только заказы
после 01-01-2023
*/
SELECT
e.EmployeeID,
AVG(TotalAmount) OVER (PARTITION BY
e.EmployeeID) AS AvgOrderValue
FROM (
SELECT
o.EmployeeID,
o.OrderID,
SUM(od.Quantity * p.Price) OVER
(PARTITION BY o.OrderID) AS TotalAmount
FROM Orders o
JOIN OrderDetails od ON o.OrderID =
od.OrderID
JOIN Products p ON od.ProductID =
p.ProductID
WHERE OrderDate >= '01-01-2023'
) AS e;
