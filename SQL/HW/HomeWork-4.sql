/*1.Ранжируйте продукты (по ProductRank) в каждой
категории на основе их общего объема продаж
(TotalSales).
*/
SELECT 
    p.CategoryID,
    p.ProductID,
    p.ProductName,
    SUM(od.Quantity * p.Price) AS TotalSales,
    RANK() OVER (PARTITION BY p.CategoryID ORDER BY SUM(od.Quantity * p.Price) DESC) AS ProductRank
FROM Products p
JOIN OrderDetails od ON p.ProductID = od.ProductID
GROUP BY p.CategoryID, p.ProductID, p.ProductName;

/*2. Обратимся к таблице Clusters
Рассчитайте среднюю сумму кредита (AvgCreditAmount) для
каждого кластера и месяца, учитывая общую среднюю сумму
кредита за соответствующий месяц (OverallAvgCreditAmount).
Определите OverallAvgCreditAmount в первой строке
результатов запроса.
*/
WITH MonthlyCredit AS (
    SELECT 
        cluster AS ClusterID,
        month AS CreditMonth,
        AVG(credit_amount) AS AvgCreditAmount
    FROM Clusters
    GROUP BY ClusterID, CreditMonth
), 
OverallMonthlyAvg AS (
    SELECT 
        month AS CreditMonth,
        AVG(credit_amount) AS OverallAvgCreditAmount
    FROM Clusters
    GROUP BY CreditMonth
)
SELECT 
    o.CreditMonth,
    o.OverallAvgCreditAmount,
    m.ClusterID,
    m.AvgCreditAmount
FROM OverallMonthlyAvg o
JOIN MonthlyCredit m ON o.CreditMonth = m.CreditMonth
ORDER BY o.CreditMonth, m.ClusterID;


/*3.Сопоставьте совокупную сумму сумм кредита
(CumulativeSum) для каждого кластера, упорядоченную по
месяцам, и сумму кредита в порядке возрастания.
Определите CumulativeSum в первой строке результатов
запроса
*/
SELECT
    month,
    cluster,
    credit_amount,
    LAG(credit_amount) OVER (PARTITION BY cluster ORDER BY month) AS PreviousCreditAmount,
    COALESCE(credit_amount - LAG(credit_amount) OVER (PARTITION BY cluster ORDER BY month), 0) AS Difference
FROM Clusters;
