--SELECT product_type FROM Clusters;
--SELECT * FROM Clusters
--WHERE family_status  = 'Another' AND sex = 'female';

--SELECT * FROM Clusters
--WHERE sex = 'female' AND age >= '60' OR 
--	  sex = 'male' AND age >= '65'
--ORDER BY sex DESC , age DESC; 

--SELECT * FROM Clusters
--WHERE (sex = 'female' AND age >= '60' OR 
--	  sex = 'male' AND age >= '65') AND family_status = 'Married'
--ORDER BY sex, age; 

--SELECT product_type, income FROM Clusters
--WHERE sex = 'female' AND age >= '60' OR 
--	  sex = 'male' AND age >= '65'
--ORDER BY income
--LIMIT 10;

--SELECT * FROM Clusters c 
--ORDER BY income DESC 
--LIMIT 10;

--SELECT *, income-credit_amount AS difference FROM Clusters
--ORDER BY income-credit_amount DESC;

--SELECT * FROM Clusters
--WHERE education = 'Higher education';

--SELECT * FROM Clusters
--WHERE cluster = 3 AND income > 120000;

--SELECT * FROM Clusters
--WHERE cluster IN (3, 5) AND income > 120000;

--SELECT * FROM Clusters
--WHERE product_type LIKE '%ces';

--SELECT * FROM Clusters
--WHERE product_type LIKE '%n%n%';

--SELECT * FROM Clusters
--WHERE product_type NOT LIKE '%_________%';
--или
--SELECT * FROM Clusters
--WHERE LENGTH (product_type) < 9;

--SELECT * FROM Clusters
--WHERE income >= 20000 AND income <= 30000
--ORDER BY income DESC;
--или
--SELECT * FROM Clusters
--WHERE income BETWEEN 20000 AND 30000 
--ORDER BY income DESC;

--SELECT CONCAT(LOWER(education), '(',  LOWER(sex),  ')') AS `new name`FROM Clusters;

--SELECT COUNT(DISTINCT credit_term) AS `Amount of credit terms`  FROM Clusters;

--SELECT SUM(credit_amount)  FROM Clusters
--WHERE month = 12 AND is_client = 1;

SELECT COUNT(*) FROM Orders
WHERE OrderDate BETWEEN '2023-09-01' AND '2023-09-15';