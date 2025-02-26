
1. Creating the Table

```sql
CREATE TABLE retail_sales(
    transactions_id INT PRIMARY KEY,
    sale_date DATE,
    sale_time TIME,
    customer_id INT,
    gender VARCHAR(15),
    age INT,
    category VARCHAR(15),
    quantity INT,
    price_per_unit FLOAT,
    cogs FLOAT,
    total_sale FLOAT
);
```
2. Checking Total Number of Records

   ```sql
   SELECT COUNT(*) FROM retail_sales;
3. Handling Null Values

```sql
SELECT * FROM retail_sales
WHERE transactions_id IS NULL
   OR sale_date IS NULL
   OR sale_time IS NULL
   OR customer_id IS NULL
   OR gender IS NULL
   OR age IS NULL
   OR category IS NULL
   OR quantity IS NULL
   OR price_per_unit IS NULL
   OR cogs IS NULL
   OR total_sale IS NULL;
```
4. Updating Null Age Values with Average
```sql
UPDATE retail_sales SET age = (
    SELECT ROUND(AVG(age), 0) FROM retail_sales WHERE age IS NOT NULL
) WHERE age IS NULL;
```
5. Deleting Remaining Null Values
```sql
DELETE FROM retail_sales
WHERE transactions_id IS NULL
   OR sale_date IS NULL
   OR sale_time IS NULL
   OR customer_id IS NULL
   OR gender IS NULL
   OR age IS NULL
   OR category IS NULL
   OR quantity IS NULL
   OR price_per_unit IS NULL
   OR cogs IS NULL
   OR total_sale IS NULL;
```
6. Checking for Null Values After Cleaning
```sql
SELECT COUNT(*) AS TOT_NULL_VALUES FROM retail_sales
WHERE transactions_id IS NULL
   OR sale_date IS NULL
   OR sale_time IS NULL
   OR customer_id IS NULL
   OR gender IS NULL
   OR age IS NULL
   OR category IS NULL
   OR quantity IS NULL
   OR price_per_unit IS NULL
   OR cogs IS NULL
   OR total_sale IS NULL;
```
7. Total Number of Sales
```sql
SELECT COUNT(transactions_id) AS Tot_sales FROM retail_sales;
```
8. Unique Customers Count
```sql
SELECT COUNT(DISTINCT customer_id) AS Customers FROM retail_sales;
```
9. Available Product Categories
```sql
SELECT DISTINCT category FROM retail_sales;
```
10. Gender-wise Customer Count
```sql
SELECT gender, COUNT(gender) FROM retail_sales GROUP BY gender;
```
11. Maximum Age in Data
```sql
SELECT MAX(age) FROM retail_sales;
```
12. Count of Each Product Category
```sql
SELECT category, COUNT(category) FROM retail_sales GROUP BY category;
```
13. Sales Data for a Specific Date
```sql
SELECT * FROM retail_sales WHERE sale_date = '2022-11-05';
```
14. Transactions of 'Clothing' Category with Quantity > 4 in November 2022
```sql
SELECT COUNT(*) FROM retail_sales 
WHERE category = 'Clothing' 
AND quantity >= 4 
AND sale_date BETWEEN '2022-11-01' AND '2022-11-30';
```
15. Total Sales by Category
```sql
SELECT category, SUM(total_sale) FROM retail_sales GROUP BY category;
```
16. Average Age of Customers in 'Beauty' Category
```sql
SELECT ROUND(AVG(age), 2) AS average_age FROM retail_sales WHERE category = 'Beauty';
```
17. Transactions with Total Sale Greater than 1000
```sql
SELECT * FROM retail_sales WHERE total_sale > 1000;
```
18. Transactions Count by Gender and Category
```sql
SELECT category, gender, COUNT(transactions_id) 
FROM retail_sales 
GROUP BY gender, category 
ORDER BY 1;
```
19. Best Selling Month for Each Year
```sql
SELECT year, month, avg_sale FROM (
    SELECT EXTRACT(YEAR FROM sale_date) AS year,
           EXTRACT(MONTH FROM sale_date) AS month,
           AVG(total_sale) AS avg_sale,
           RANK() OVER (PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) AS rank
    FROM retail_sales
    GROUP BY 1, 2
) AS t1 WHERE rank = 1;
```
20. Top 5 Customers by Highest Total Sales
```sql
SELECT customer_id, MAX(total_sale) FROM retail_sales 
GROUP BY 1 
ORDER BY 2 DESC LIMIT 5;
```
21. Unique Customers by Category
```sql
SELECT COUNT(DISTINCT customer_id), category FROM retail_sales GROUP BY category;
```
22. Total Revenue, Average Order Value, and Sales Per Category in November 2022
```sql
SELECT category, COUNT(transactions_id) AS total_sales,
       SUM(total_sale) AS total_revenue,
       ROUND(AVG(total_sale)::NUMERIC, 3) AS avg_order_value
FROM retail_sales
WHERE sale_date BETWEEN '2022-11-01' AND '2022-11-30'
GROUP BY category
ORDER BY total_revenue DESC;
```
