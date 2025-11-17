--SQL Retails Sales Analysis - p1 
create database sql_project_p2

--create table 
create table retail_sales(
    transactions_id int ,
	sale_date date,
	sale_time time,
	coustomer_id int,
	gender varchar(15),
	age int,
	category varchar(15),
	quatity int,
	price_per_unit float,
	cogs float,
	totals_sale float
);

select * from retail_sales

select
   count(*)
from retail_sales   

---data cleaning
select * from retail_sales where transactions_id is null

select * from retail_sales 
where 
    transactions_id is null
	or 
	sale_date is null
	or 
	coustomer_id is null
	or 
	gender is null
	or 
	category is null
	or
	quantity is null
	or 
	price_per_unit is null
	or 
    cogs is null
	or 
	total_sales is null;

delete from retail_sales
where 
    transactions_id is null
	or 
	sale_date is null
	or 
	coustomer_id is null
	or 
	gender is null
	or 
	category is null
	or
	quantity is null
	or 
	price_per_unit is null
	or 
    cogs is null
	or 
	total_sales is null;

--data exploraton
--how many sales we have?
select count(*) as total_sale from retail_sales ;


--how many customers we have?
select count(*) as total_customer from retail_sales;

--how many unique customers we have?
select count(distinct coustomer_id) as unique_customer from retail_sales;	

--total numbers of category we have?
select count(distinct category) as total_category from retail_sales ;

select distinct category as total_category from retail_sales ;

--data analysis & bussiness problem & answers 
-- My Analysis & Findings

-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05

select * from retail_sales
where sale_date='2022-11-05';

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022
select * from retail_sales 
where category='Clothing'
    and
      quantity>3
	and 
	 TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
	  
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.

  select sum(total_sales) as total_sale, category
  from retail_sales group by category; 

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

       select round(avg(age),2) from retail_sales where category='Beauty'

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.

       select * from retail_sales where total_sales>1000;

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

	 select 
	 gender, count(transactions_id) as total_trasaction_per_gender
	 from retail_sales
	 group by gender;
	 
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year

	 select 
     extract (year from sale_date) as year,
	 extract (month from sale_date) as month,
	 sum(total_sales) as total_sales
	 from retail_sales
	 order by year, month desc

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
    
	select coustomer_id, total_sales 
	from retail_sales 
	order by total_sales
	desc limit 5;
	
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.

SELECT 
    category,    
    COUNT(DISTINCT coustomer_id) as cnt_unique_cs
FROM retail_sales
GROUP BY category

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)
with hourly_sale 
as
(
SELECT 
    CASE
        WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END as shift
FROM retail_sales
)
select shift,
   COUNT(*) as total_orders    
FROM hourly_sale
GROUP BY shift
