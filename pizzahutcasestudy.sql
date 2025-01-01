create database pizzahut;
use pizzahut;
CREATE TABLE pizza (
    pizza_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    pizza_name_id VARCHAR(50) NOT NULL,
    quantity INT NOT NULL,
    order_date DATE NOT NULL,
    order_time TIME NOT NULL,
    unit_price DECIMAL(10, 2) NOT NULL,
    total_price DECIMAL(10, 2) NOT NULL,
    pizza_size CHAR(1) NOT NULL,
    pizza_category VARCHAR(50) NOT NULL,
    pizza_ingredients TEXT NOT NULL,
    pizza_name VARCHAR(255) NOT NULL
);

select * from pizza;

-- 1. Total revenue
select round(sum(total_price),1) as revenue from pizza;

-- 2. Avg Order values
select round(sum(total_price)/count( distinct(order_id)),1) as AvgOrderValue from pizza;

-- 3. Total Pizza sold 
select sum(quantity) as TotalPizzaSold from pizza;

-- 4. Total Orders 
select count(distinct order_id) from pizza;

-- 5.  Avg pizza per order 
select round(sum(quantity)/count(distinct order_id),2) as AvgPizzaPerOrder from pizza;

-- 6. Daily Trend for Total Orders
set SQL_SAFE_UPDATES = 1;
update pizza set order_date = str_to_date(order_date, '%d-%m-%Y');
select dayname(order_date) as Day, count(distinct order_id) as totalorders from pizza group by dayname(order_date) order by 2 desc;

-- 7. Monthly Trend for Orders
select monthname(order_date) as month , count(distinct order_id) as totalorders from pizza group by monthname(order_date) order by 2 desc;

-- 8. % of Sales by Pizza Category
select pizza_category, round(sum(total_price),1) as revenue, round((sum(total_price)*100)/(select sum(total_price) from pizza),2) as pct 
from pizza group by pizza_category;

-- 9. % of Sales by Pizza Size
select pizza_size,round(sum(total_price),1) as revenue, round((sum(total_price)*100)/(select sum(total_price) from pizza),2) as pct from pizza
group by pizza_size;

-- 10. Total Pizzas Sold by Pizza Category
select pizza_category, sum(quantity) as TotalPizzaSold from pizza group by pizza_category;

-- 11. Top 5 Pizzas by Revenue
select pizza_name, sum(total_price) as revenue from pizza group by pizza_name order by 2 desc limit 5;

-- 12 Bottom 5 Pizzas by Revenue
select pizza_name, sum(total_price) as revenue from pizza group by pizza_name order by 2  limit 5;

-- 13. Top 5 Pizzas by Quantity
select pizza_name, sum(quantity) as TotalPizzaSold from pizza group by pizza_name order by 2 desc limit 5;

-- 14. Bottom 5 Pizzas by Quantity
select pizza_name, sum(quantity) as TotalPizzaSold from pizza group by pizza_name order by 2 limit 5;

-- 15. Top 5 Pizzas by Total Orders
select pizza_name, count(distinct order_id) as TotalOrders from pizza group by pizza_name order by 2 desc limit 5;

-- 16. Bottom 5 Pizzas by Total Orders
select pizza_name, count(distinct order_id) as TotalOrders from pizza group by pizza_name order by 2 limit 5;
