#### cleaning

use sakila;

select* from analysis;
delete from analysis
where 
transactions_id is null
or
sale_date is null
or
sale_time is null
or
gender is null
or
age is null
or
category is null
or
quantity is null
or 
price_per_unit is null
or 
cogs is null
or 
total_sale is null;

#### data exploration

### how many unique customers?
select count(distinct customer_id) from analysis


### business key problems and answers

### Q1 write an sql query to retrieve all columns for sales made on 2022-11-05

select*
from analysis
where sale_date='2022-11-05'

###Q2 write a sql query to retrieve all transactions where the category is 'clothing' and the quantity sold is more than 3 in the month Nov-2022

select*
from analysis
where 
	year(sale_date)='2022' and month(sale_date)='11' 
    and 
    quantity >3
    and 
    category='clothing'
    
###Q3 write sql query to calculate the total sales (total_sale) for each category

select
	category,
    sum(total_sale) as net_sale
from analysis
group by 1

### Q4 write a sql query to find the average age of customers who purchased items from the 'Beauty' category

select
	avg(age) as avg_age
from analysis
where category='Beauty'

###Q5 write a sql query to find where the total_sale is greater than 1000

select*
from analysis
where total_sale >1000

###Q6 write a sql query to find the total numberof transactions_id made by each gender in each category

select
	category,
	gender,
    count(*) as total_trans
from analysis
group by category,
	gender
order by 1

###Q7 write a sql query to calculate average sales for each month. Find out best selling month in each year

select* from
(
	select
		year(sale_date),
		month(sale_date),
		avg(total_sale) as avg_total_sales,
		rank() over(partition by year(sale_date) order by avg(total_sale) desc) as ranking
	from analysis
	group by 1,2
) as t1
where ranking =1 

###Q8 write a sql query to find the top 5 customers based on the highest total sales

select
	customer_id,
    sum(total_sale) as total_sales
from analysis
group by 1
order by 2 desc
limit 5

###Q9 write a sql query to find the number of unique customers who purchased items for each category


select
	category,
    count(distinct customer_id) as distinct_customers
from analysis
group by category


###Q10 write an sql query to create each shift and number of orders (Example Morning<=12, Afternoon Between 12 & 17, Evening > 17)

with hourly_sale
as
(
select*,
	case
		when hour(sale_time) < 12 then 'Morning'
        when hour(sale_time) between 12 and 17 then 'Afternoon'
        else 'Evening'
	end as shift
from analysis
)
select
	shift,
	count(*) as total_orders
from hourly_sale
group by shift

    
    






	



