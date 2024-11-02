/*1. Вам необходимо проверить влияние семейного
положения (family_status) на средний	доход
клиентов (income) и запрашиваемый кредит
(credit_amount) .
*/
SELECT family_status, 
ROUND(AVG(income), 2) AS avg_income,
ROUND(AVG(credit_amount), 2) AS avg_credit
FROM Clusters c 
GROUP BY family_status;
/*result:
   Another 32756.04, 29880.93
   Married 32272.52, 27638.51
 Unmarried 33217.95, 29032.05
 */

--2. Сколько товаров в категории Meat/Poultry.
SELECT COUNT(*) AS 'кол-во товаров' FROM Products
WHERE CategoryID = (SELECT CategoryID FROM Categories
WHERE CategoryName = 'Meat/Poultry');
--result = 6

/*3. Какой товар (название) заказывали в сумме в
самом большом количестве (sum(Quantity) в
таблице OrderDetails)
*/
SELECT ProductName FROM Products
WHERE ProductID = (SELECT ProductID FROM OrderDetails
GROUP BY ProductID
ORDER BY SUM(Quantity) DESC
LIMIT 1);
--result = Gorgonzola Telino




