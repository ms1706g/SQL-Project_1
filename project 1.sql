USE sqlproject1;
SELECT TOP 10  * FROM retailsales;
SELECT * FROM retailsales;
-- EXEC sp_rename '[SQL - Retail Sales Analysis_utf ]', 'retailsales';
SELECT COUNT(*) FROM retailsales;

-- DATA CLEANING

SELECT * FROM retailsales
WHERE transactions_id IS NULL




SELECT * FROM retailsales
WHERE sale_date IS NULL 


SELECT * FROM retailsales
WHERE sale_time IS NULL


SELECT * FROM retailsales
WHERE customer_id IS NULL


SELECT * FROM retailsales
WHERE gender IS NULL



SELECT * FROM retailsales
WHERE 
       transactions_id IS NULL
	   OR
	   sale_date IS NUll
       OR
	   sale_time IS NULL
	   OR
	   gender IS NULL
	   OR
	   category IS NULL
	   OR
	   quantiy IS NULL
	   OR
	   cogs IS NULL
	   OR
	   total_sale IS NULL;

--
DELETE FROM retailsales
WHERE 
       transactions_id IS NULL
	   OR
	   sale_date IS NUll
       OR
	   sale_time IS NULL
	   OR
	   gender IS NULL
	   OR
	   category IS NULL
	   OR
	   quantiy IS NULL
	   OR
	   cogs IS NULL
	   OR
	   total_sale IS NULL;


--DATA EXPLORATION

-- HOW MANY SALES WE HAVE

SELECT COUNT(*) as total_sale FROM retailsales

-- HOW MANY UNIQUE CUSTOMERS WE HAVE

SELECT COUNT(DISTINCT customer_id) as total_sale FROM retailsales

--HOW MANY CATEGORY WE HAVE

SELECT COUNT(DISTINCT category) as total_sale FROM retailsales

SELECT DISTINCT category FROM retailsales

--DATA ANALYSIS AND BUISNESS KEY PROBLEMS AND ANSWERS

-- Data Analysis & Business Key Problems & Answers

-- My Analysis & Findings
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05'
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)



-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05'

SELECT * FROM retailsales
WHERE sale_date = '2022-11-05';


-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than  in the month of Nov-2022

SELECT * 
FROM retailsales
WHERE category = 'Clothing' 
 -- AND quantity > 4
  AND FORMAT(sale_date, 'yyyy-MM') = '2022-11';
   

-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.


--SELECT COUNT(total_sale) FROM retailsales
--WHERE category = 'Clothing','Beauty','Electronics' AS clothing_sale,beauty_sale,electronics_sale;

SELECT 
    SUM(CASE WHEN category = 'Clothing' THEN total_sale ELSE 0 END) AS clothing_sale,
    SUM(CASE WHEN category = 'Beauty' THEN total_sale ELSE 0 END) AS beauty_sale,
    SUM(CASE WHEN category = 'Electronics' THEN total_sale ELSE 0 END) AS electronics_sale
FROM retailsales;


SELECT 
    COUNT(CASE WHEN category = 'Clothing' THEN 1 END) AS clothing_sale_count,
    COUNT(CASE WHEN category = 'Beauty' THEN 1 END) AS beauty_sale_count,
    COUNT(CASE WHEN category = 'Electronics' THEN 1 END) AS electronics_sale_count
FROM retailsales;

SELECT category,
SUM(total_sale) as net_sale,
COUNT(*) as total_orders
FROM retailsales
GROUP BY category;



-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.


SELECT AVG(age) as beauty_avg_age 
FROM retailsales
WHERE category = 'Beauty';


-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.

SELECT * FROM retailsales
WHERE total_sale > 1000;


-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

SELECT category,gender,
SUM(total_sale) as net_sale,
COUNT(*) as total_orders
FROM retailsales
GROUP BY category,gender;


-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year.


SELECT FORMAT(sale_date,'yyyy-MM') AS sale_month,
AVG(total_sale) AS avg_sale FROM retailsales
WHERE FORMAT(sale_date, 'yyyy') = '2022'
GROUP BY FORMAT(sale_date, 'yyyy-MM')
ORDER BY avg_sale DESC;
								

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales.

SELECT TOP 5 customer_id, SUM(total_sale) AS total_sales FROM retailsales
GROUP BY customer_id
ORDER BY total_sales DESC;


-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.

SELECT category, COUNT(DISTINCT customer_id)  AS unique_customers FROM retailsales
GROUP BY category;


-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

SELECT
CASE
    WHEN DATEPART (HOUR, sale_time) <12 THEN 'Morning'
	WHEN DATEPART (HOUR, sale_time) Between 12 AND 17 THEN 'Afternoon'
	WHEN DATEPART (HOUR, sale_time) >17 THEN 'Evening'
  END AS shifts,
  COUNT(*) AS total_orders 
  FROM retailsales
  GROUP BY 
   CASE
    WHEN DATEPART (HOUR, sale_time) <12 THEN 'Morning'
	WHEN DATEPART (HOUR, sale_time) Between 12 AND 17 THEN 'Afternoon'
	WHEN DATEPART (HOUR, sale_time) >17 THEN 'Evening'
	END;



