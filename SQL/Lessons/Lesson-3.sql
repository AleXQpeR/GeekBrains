/*Задание 1
Приджойним к данным о заказах данные о
покупателях. Данные, которые нас интересуют —
имя заказчика и страна, из которой совершается
покупка.
*/

SELECT 
	o.*, 
	CustomerName, Country
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID;

/*Задание 2
Давайте проверим, Customer пришедшие из какой
страны совершили наибольшее число Orders.
Используем сортировку по убыванию по полю
числа заказов.
И выведем сверху в результирующей таблице
название лидирующей страны.
*/

SELECT 
	COUNT(*) AS cnt,
	Country 
FROM Customers c 
JOIN Orders o ON c.CustomerID = o.CustomerID 
GROUP BY Country 
ORDER BY cnt DESC
LIMIT 1;

/*Задание 3
А теперь напишем запрос, который обеспечит
целостное представление деталей заказа,
включая информацию как о клиентах,
так и о сотрудниках.
Будем использовать JOIN для соединения
информации из таблиц Orders, Customers
и Employees.
*/

SELECT 
	o.OrderID,
	o.OrderDate,
	c.CustomerName,
	c.Country,
	e.LastName
FROM Customers c 
JOIN Orders o ON c.CustomerID = o.CustomerID 
JOIN Employees e ON e.EmployeeID = o.EmployeeID 
;

/*Задание 4
Наша следующая задача — проанализировать
данные заказа, рассчитать ключевые показатели,
связанные с выручкой, и соотнести результаты
с ценовой информацией из таблицы Products.
Давайте посмотрим на общую выручку, а также
минимальный, максимальный чек в разбивке
по странам.
*/

SELECT 
	c.Country,
	SUM(p.Price * od.Quantity), 
	MAX(p.Price * od.Quantity),
	MIN(p.Price * od.Quantity)
FROM Customers c 
JOIN Orders o ON c.CustomerID = o.CustomerID 
JOIN OrderDetails od ON od.OrderID = o.OrderID 
JOIN Products p ON p.ProductID = od.ProductID 
GROUP BY c.Country 

/*Задание 5
Выведем имена покупателей, которые совершили
как минимум одну покупку 12 декабря
*/

SELECT DISTINCT c.CustomerName
FROM Customers c 
JOIN Orders o ON c.CustomerID = o.CustomerID 
WHERE OrderDate = '2023-12-12'

/*Задание 6
Напишем SQL-запрос для создания отчета
об исследовании продукта, показывающего
потенциальный интерес к каждому продукту
в разных странах. Используем CROSS JOIN
операцию для создания комбинаций стран и
продуктов.
Это PotentialInterest должно представлять собой
гипотетическую оценку, основанную на общем
количестве клиентов из этой страны, которые могут
быть заинтересованы в конкретном продукте.
CROSS JOIN создаёт все возможные комбинации
стран и названий продуктов.
*/

SELECT
c.Country,
p.ProductName,
p.Price,
COUNT(DISTINCT c.CustomerID) AS
PotentialInterestScore
FROM
Customers AS c
CROSS JOIN
Products AS p
GROUP BY
c.Country, p.ProductName, p.Price;

/*Задание 7
Давайте проанализируем разнообразие
поставщиков в категориях продуктов.
Напишем SQL-запрос для определения
поставщиков, предлагающих широкий
ассортимент продукции в разных категориях.
*/

SELECT
s.SupplierID,
s.SupplierName,
s.Country,
COUNT(DISTINCT p.CategoryID) AS
ProductCategoryDiversity
FROM
Suppliers AS s
JOIN
Products AS p ON s.SupplierID =
p.SupplierID
GROUP BY
s.SupplierID, s.SupplierName, s.Country
ORDER BY
ProductCategoryDiversity DESC

/*Задание 8
Ваша компания заинтересована в том, чтобы
понять, в каких странах появились новые
клиенты, которые еще не разместили заказы.
Напишем SQL-запрос, позволяющий
идентифицировать страны, в которых клиенты
зарегистрировались, но не сделали заказов.
*/

WITH cust AS (SELECT c.* 
	FROM Customers c EXCEPT
	SELECT c.* FROM Customers c
	JOIN Orders o ON c.CustomerID =
	o.CustomerID)
SELECT country, 
	count(DISTINCT CustomerID)
FROM Cust
GROUP BY Country;

/*Задание 9
Представим, что Ваша компания хочет выявить
клиентов, которые приобрели товары как
стоимостью менее 30, так и стоимостью более
150 долларов США.
Напишите запрос SQL, INTERSECT чтобы найти
клиентов, которые делали покупки в обоих этих
ценовых диапазонах.
*/

SELECT c.CustomerID, CustomerName
FROM Customers as c
JOIN Orders as o ON c.CustomerID = o.CustomerID
JOIN OrderDetails as od ON o.OrderID = od.OrderID
JOIN Products as p ON od.ProductID = p.ProductID
WHERE p.Price < 30
INTERSECT
SELECT c.CustomerID, CustomerName
FROM Customers as c
JOIN Orders as o ON c.CustomerID = o.CustomerID
JOIN OrderDetails as od ON o.OrderID = od.OrderID
JOIN Products as p ON od.ProductID = p.ProductID
WHERE p.Price > 150;

/*Задание 10
Следующим запросом давайте создадим набор
результатов, который включает уникальные
записи о клиентах как для США, так и для
Канады.
В данном случае оператор UNION объединяет
результаты двух отдельных запросов,
представляя единый список клиентов из обеих
стран, удаляя при этом любые дубликаты.
*/

SELECT CustomerID, CustomerName
FROM Customers
WHERE Country = 'USA'
UNION
SELECT CustomerID, CustomerName
FROM Customers
WHERE Country = 'Canada';