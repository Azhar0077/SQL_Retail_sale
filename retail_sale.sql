--SQL RETAIL SALES ANALYSIS --
DROP TABLE IF EXISTS retail_sale;

CREATE TABLE retail_sale(
transactions_id INT PRIMARY KEY,
sale_date DATE,
sale_time TIME,
customer_id	INT,
gender VARCHAR(10),
age	INT,
category VARCHAR(50),
quantity INT,
price_per_unit FLOAT,
cogs FLOAT,
total_sale FLOAT  
);

SELECT * FROM retail_sale;

--CHECK NULL VAALUES--

SELECT * FROM retail_sale 
WHERE transactions_id IS NULL
OR 
 sale_time IS NULL
OR 
 customer_id IS NULL
OR 
 gender IS NULL
OR 
 age IS NULL
OR 
 category IS NULL
OR 
 quantity IS NULL
OR 
 price_per_unit IS NULL
OR 
 cogs IS NULL
OR 
 total_sale IS NULL;

--DELETE NULL VALUES--

 DELETE FROM retail_sale
 WHERE transactions_id IS NULL
OR 
 sale_time IS NULL
OR 
 customer_id IS NULL
OR 
 gender IS NULL
OR 
 age IS NULL
OR 
 category IS NULL
OR 
 quantity IS NULL
OR 
 price_per_unit IS NULL
OR 
 cogs IS NULL
OR 
 total_sale IS NULL;

 --DATA EXPLORATION--
 --HOW MANY SALES WE HAVE--
 SELECT COUNT(total_sale) FROM 
 retail_sale;

  --HOW MANY CUSTOMER WE HAVE USING DISTINCT TO REMOVE DUPLICATE CUSTOMERS--
  SELECT COUNT(DISTINCT customer_id) FROM
  retail_sale;

  --HOW MANY CATEGORY WE HAVE USING DISTINCT TO REMOVE DUPLICATE CATEGORY--
SELECT DISTINCT category FROM 
retail_sale;

--DATA ANALYSIS & BUSINESS KEY PROBLEMS & ANSWERS--
SELECT * FROM retail_sale;
--write a sql query to retreive all columns for sales made on '2022-11-05'--
SELECT * FROM retail_sale
WHERE sale_date='2022-11-05';

--write a sql query to retreive all transaction where the category is 'clothing' and the quantity sold is more than 3 in the month of the nov-2022 --
SELECT * FROM retail_sale
WHERE category='Clothing'
AND 
TO_CHAR(sale_date,'yyyy-mm')='2022-11'
AND 
quantity>=3;

--write a sql query to calculate the total sale for each category --
SELECT category,
SUM(total_sale),
COUNT(*) AS total_order
FROM retail_sale
GROUP BY category;

--write a sql query to find the average age of customer who purchased items from the beauty category--
SELECT ROUND(AVG(age),2) AS avg_age FROM retail_sale
WHERE category='Beauty';

--write a sql query to find all transaction where the total_sale is greater than 1000--
SELECT * FROM retail_sale
WHERE total_sale>1000;

--write a sql query to find the total number of transaction (transaction_id) made by each gender in each category--
SELECT category,gender,
COUNT(*) AS total_transaction
FROM retail_sale
GROUP BY category,gender;

--write a sql query to calcuate the avg sale for each month find out best selling month each year--
SELECT* FROM
   (SELECT EXTRACT(YEAR FROM sale_date) AS year,
  EXTRACT(MONTH FROM sale_date) AS month,
  AVG(total_sale) AS avg_sale,
  RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) AS rank
  FROM retail_sale
  GROUP BY 1,2) AS t1
WHERE rank = 1;

--write a sql query to find the top 5 customer based on the highest total sale--
SELECT customer_id, SUM(total_sale) 
FROM retail_sale
GROUP BY 1
ORDER BY 2 DESC LIMIT 5;

--write a sql query to find the number of unique customer who purchased items from each category--
SELECT category,COUNT(DISTINCT customer_id) AS unique_customer
FROM retail_sale
GROUP BY category;

--write a sql query to create each shift and number of orders (exm morning <=12,afternoon between 12&17,evening>17)--

WITH hourly_sale
AS
(SELECT *,
CASE
WHEN EXTRACT(HOUR FROM sale_time) <=12 THEN 'Morning'
WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
ELSE 'Evening'
END AS shift
 FROM retail_sale
 )
  SELECT shift, COUNT(*) AS total_order
 FROM hourly_sale
 GROUP BY shift;





 




