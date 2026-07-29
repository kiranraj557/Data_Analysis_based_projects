SELECT * FROM coffee_shop_sales;

DESCRIBE coffee_shop_sales;

UPDATE coffee_shop_sales
SET transaction_date = STR_TO_DATE(transaction_date, '%m/%d/%Y');

UPDATE coffee_shop_sales
SET transaction_time = STR_TO_DATE(transaction_time, '%h:%i:%s %p');

ALTER TABLE coffee_shop_sales 
MODIFY COLUMN transaction_date DATE;

ALTER TABLE coffee_shop_sales 
MODIFY COLUMN transaction_time TIME;

SELECT CONCAT((ROUND(SUM(unit_price * transaction_qty))) / 1000 , "k")  AS Total_sales
FROM coffee_shop_sales
WHERE 
MONTH(transaction_date) = 5 ; -- May Month 

SELECT CONCAT((ROUND(SUM(unit_price * transaction_qty))) / 1000 , "k")  AS Total_sales
FROM coffee_shop_sales
WHERE 
MONTH(transaction_date) = 3 ; -- March Month 

SELECT
MONTH(transaction_date) AS month,  -- month in number
ROUND(SUM(unit_price * transaction_qty)) AS total_sales,  -- total sales column
(SUM(unit_price * transaction_qty) - LAG(SUM(unit_price * transaction_qty),1)  -- month sales difference
OVER(ORDER BY MONTH(transaction_date))) / LAG(SUM(unit_price * transaction_qty),1) -- divide by previous month
OVER(ORDER BY MONTH(transaction_date)) *  100 AS mom_increase_percentage -- percentage
FROM
coffee_shop_sales
WHERE
MONTH(transaction_date) IN (4,5) -- for months of April and May
GROUP BY 
MONTH(transaction_date)
ORDER BY
MONTH(transaction_date);

SELECT (COUNT(transaction_id)) AS Total_orders
FROM coffee_shop_sales
WHERE 
MONTH(transaction_date) = 3 ; -- March Month 

SELECT
MONTH(transaction_date) AS month,  -- month in number
ROUND(COUNT(transaction_id)) AS total_orders,  -- total orders column
(COUNT(transaction_id) - LAG(COUNT(transaction_id),1)  -- month orders difference
OVER(ORDER BY MONTH(transaction_date))) / LAG(COUNT(transaction_id),1) -- divide by previous month
OVER(ORDER BY MONTH(transaction_date)) *  100 AS mom_increase_percentage -- percentage
FROM
coffee_shop_sales
WHERE
MONTH(transaction_date) IN (4,5) -- for months of April and May
GROUP BY 
MONTH(transaction_date)
ORDER BY
MONTH(transaction_date);

SELECT (SUM(transaction_qty)) AS Total_quantity_sold
FROM coffee_shop_sales
WHERE 
MONTH(transaction_date) = 5 ; 

SELECT
MONTH(transaction_date) AS month,  -- month in number
ROUND(SUM(transaction_qty)) AS total_orders,  -- total orders column
(SUM(transaction_id) - LAG(SUM(transaction_qty),1)  -- month orders difference
OVER(ORDER BY MONTH(transaction_date))) / LAG(SUM(transaction_qty),1) -- divide by previous month
OVER(ORDER BY MONTH(transaction_date)) *  100 AS mom_increase_percentage -- percentage
FROM
coffee_shop_sales
WHERE
MONTH(transaction_date) IN (4,5) -- for months of April and May
GROUP BY 
MONTH(transaction_date)
ORDER BY
MONTH(transaction_date);


SELECT
CONCAT(ROUND(SUM(unit_price * transaction_qty)/1000,1), 'k') AS Total_sales,
CONCAT(ROUND(SUM(transaction_qty)/1000,1), 'k') AS Total_qty_sold,
CONCAT(ROUND(COUNT(transaction_id)/1000,1), 'k') AS Total_orders
FROM coffee_shop_sales
WHERE transaction_date = '2023-05-18';

SELECT
CASE WHEN DAYOFWEEK(transaction_date) IN (1,7) THEN 'Weekends'
ELSE 'Weekdays'
END AS day_type ,
CONCAT(ROUND(SUM(unit_price * transaction_qty)/1000,1), 'k') AS Total_sales
FROM coffee_shop_sales
WHERE MONTH(transaction_date) = 5 
GROUP BY
CASE WHEN DAYOFWEEK(transaction_date) IN (1,7) THEN 'Weekends'
ELSE 'Weekdays'
END ;


SELECT 
store_location,
CONCAT(ROUND(SUM(unit_price * transaction_qty)/1000,2),'k') AS Total_sales
FROM coffee_shop_sales
WHERE MONTH(transaction_date) = 6 -- june
GROUP BY store_location
ORDER BY SUM(unit_price * transaction_qty) DESC;

SELECT
AVG(unit_price * transaction_qty) AS Avg_sales
FROM coffee_shop_sales
WHERE MONTH(transaction_date) = 5;

SELECT
CONCAT(ROUND(AVG(total_sales)/1000, 1), 'k') AS Avg_sales
FROM 
(
SELECT SUM(transaction_qty * unit_price) AS total_sales
FROM coffee_shop_sales
WHERE MONTH (transaction_date) = 5
GROUP BY transaction_date
) AS Internal_query;

SELECT
DAY(transaction_date) AS day_of_month,
SUM(unit_price * transaction_qty) AS total_sales
FROM coffee_shop_sales
WHERE MONTH (transaction_date) = 5
GROUP BY DAY (transaction_date)
ORDER BY DAY(transaction_date);

SELECT
day_of_month,
CASE
WHEN total_sales > avg_sales THEN 'Above Average'
WHEN total_sales < avg_sales THEN 'Below Average'
ELSE 'Average'
END AS sales_status,
total_sales
FROM (
SELECT 
DAY(transaction_date) AS day_of_month,
SUM(unit_price * transaction_qty) AS total_sales,
AVG(SUM(unit_price * transaction_qty)) OVER () AS Avg_sales
FROM
coffee_shop_sales
WHERE 
MONTH(transaction_date) = 5 -- filter for May
GROUP BY
DAY(transaction_date)
) AS sales_data
ORDER BY 
day_of_month;

SELECT
product_category,
SUM(unit_price * transaction_qty) AS total_sales
FROM coffee_shop_sales
WHERE MONTH(transaction_date) = 5
GROUP BY product_category
ORDER BY SUM(unit_price * transaction_qty) DESC;

SELECT
product_type,
SUM(unit_price * transaction_qty) AS total_sales
FROM coffee_shop_sales
WHERE MONTH(transaction_date) = 5
GROUP BY product_type
ORDER BY SUM(unit_price * transaction_qty) DESC
LIMIT 10;

SELECT
product_type,
SUM(unit_price * transaction_qty) AS total_sales
FROM coffee_shop_sales
WHERE MONTH(transaction_date) = 5 AND product_category = 'coffee'
GROUP BY product_type
ORDER BY SUM(unit_price * transaction_qty) DESC
LIMIT 10;

SELECT
SUM(unit_price * transaction_qty) AS total_sales,
SUM(transaction_qty) AS total_qty_sales,
COUNT(*)
FROM coffee_shop_sales
WHERE MONTH(transaction_date) = 5 -- May
AND DAYOFWEEK(transaction_date) = 2 -- Monday
AND HOUR(transaction_time) = 8 -- HOUR no 8
;


SELECT
HOUR(transaction_time),
SUM(unit_price * transaction_qty) AS total_sales
FROM coffee_shop_sales
WHERE MONTH(transaction_date) = 5 
GROUP BY HOUR(transaction_time)
ORDER BY HOUR(transaction_time) 
;

SELECT
CASE 
WHEN DAYOFWEEK(transaction_date) = 2 THEN 'Monday'
WHEN DAYOFWEEK(transaction_date) = 3 THEN 'Tuesday'
WHEN DAYOFWEEK(transaction_date) = 4 THEN 'Wednesday'
WHEN DAYOFWEEK(transaction_date) = 5 THEN 'Thursday'
WHEN DAYOFWEEK(transaction_date) = 6 THEN 'Friday'
WHEN DAYOFWEEK(transaction_date) = 7 THEN 'Saturday'
ELSE 'Sunday'
END AS Day_of_Week,
ROUND(SUM(unit_price * transaction_qty)) AS total_sales
FROM 
coffee_shop_sales
WHERE
MONTH(transaction_date) = 5 -- filter for May 
GROUP BY 
CASE
WHEN DAYOFWEEK(transaction_date) = 2 THEN 'Monday'
WHEN DAYOFWEEK(transaction_date) = 3 THEN 'Tuesday'
WHEN DAYOFWEEK(transaction_date) = 4 THEN 'Wednesday'
WHEN DAYOFWEEK(transaction_date) = 5 THEN 'Thursday'
WHEN DAYOFWEEK(transaction_date) = 6 THEN 'Friday'
WHEN DAYOFWEEK(transaction_date) = 7 THEN 'Saturday'
ELSE 'Sunday'
END;


