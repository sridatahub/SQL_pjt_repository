create table retail_sales(
		transactions_id INT PRIMARY KEY,
		sale_date DATE,	
		sale_time TIME,
		customer_id	INT,
		gender	VARCHAR(15),
		age	INT,
		category VARCHAR(15),	
		quantity INT,
		price_per_unit FLOAT,	
		cogs FLOAT,
		total_sale FLOAT
		);
DROP TABLE retail_sales;
SELECT * FROM retail_sales limit 10;--specific row of rows fetched.
--Total no of records.
SELECT count(*) FROM retail_sales;
--Data Cleaning:Handling null values
SELECT * FROM retail_sales
	WHERE 
		transactions_id IS NULL
		OR 
		sale_date IS NULL
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
--Update 10 records of my age column with its avg value.
UPDATE retail_sales SET 
age=(SELECT ROUND(AVG(age),0) FROM retail_sales WHERE age is NOT NULL)
WHERE age is NULL;
--Delete remaining null values in combination columns(quantity,price_per_unit,cogs)
DELETE  FROM retail_sales
	WHERE 
		transactions_id IS NULL
		OR 
		sale_date IS NULL
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
--Checking count of null values..
SELECT COUNT(*) AS TOT_NULL_VALUES FROM retail_sales
	WHERE 
		transactions_id IS NULL
		OR 
		sale_date IS NULL
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
/*Data cleaned:No null values present*/
--Data Exploration
--1.Total Number of sales happended?
SELECT COUNT(transactions_id) as Tot_sales FROM retail_sales;


--2.How many unique customers do we have
SELECT COUNT(DISTINCT(customer_id)) as Customers from retail_sales;


--3.What are the categories do we have
SELECT DISTINCT category from retail_sales;

--4.Count of female and male customers in my data
SELECT gender,count(gender) from retail_sales GROUP BY gender;

--5.Max Age in my data
SELECT MAX(age) from retail_sales;

--6.Count of individual category 
SELECT category,count(category) from retail_sales GROUP BY category

/*Data Analysis and Solving key business problems*/
--Write a SQL query to retrieve all columns for sales made on '2022-11-05'
SELECT * FROM retail_sales WHERE sale_date = '2022-11-05'


--Write a SQL query to retrieve all transactions where the category is 'Clothing' 
--and the quantity sold is more than 4 in the month of Nov-2022:
SELECT count(*) FROM retail_sales 
WHERE category = 'Clothing' 
AND quantity>=4 AND 	
sale_date BETWEEN '2022-11-01' AND '2022-11-30';

--Write a SQL query to calculate the total sales (total_sale) for each category.:
select category,sum(total_sale) from retail_sales group by 1;


--Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.:
SELECT ROUND(AVG(age),2) as average_age from retail_sales where  category = 'Beauty';

--Write a SQL query to find all transactions where the total_sale is greater than 1000.:
SELECT * FROM retail_sales 	WHERE total_sale>1000;


--Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.:
SELECT 
	category,
	gender,
	count(transactions_id) 
	from retail_sales 
group by gender,category
order by 1; 

--Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:
SELECT  
	year,
	month,
	avg_sale
FROM(
SELECT 
	EXTRACT(YEAR FROM sale_date) as year,
	EXTRACT(MONTH FROM sale_date) as month,
	AVG(total_sale) as avg_sale,
	RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) AS rank
FROM retail_sales
GROUP BY 1,2) AS t1
WHERE rank =1;


--Write a SQL query to find the top 5 customers based on the highest total sales 
SELECT 
	customer_id,
	MAX(total_sale) 
FROM retail_sales 
	GROUP BY 1
	ORDER BY 2 DESC LIMIT 5;

--Write a SQL query to find the number of unique customers who purchased items from each category.:
SELECT 
	COUNT(DISTINCT customer_id),category 
FROM retail_sales
GROUP BY category;


--Find the total revenue, average order value, and total sales for each product category in November 2022.
SELECT
	category,
	COUNT(transactions_id) as total_sales,
	SUM(total_sale) as total_revenue,
	ROUND(AVG(total_sale)::NUMERIC, 3) as avg_order_value
FROM retail_sales
WHERE sale_date BETWEEN '2022-11-01' AND '2022-11-30'
GROUP BY category
ORDER BY total_revenue DESC;