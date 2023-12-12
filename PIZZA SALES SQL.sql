#PIZZA SALES STORE :

#1. Total Revenue:
SELECT SUM(total_price) AS Total_Revenue FROM pizza_sales;

#2. Average Order Value or price :
SELECT (SUM(total_price) / COUNT(order_id)) AS Avg_order_Value FROM pizza_sales;

#3. Total Pizzas Sold
SELECT SUM(quantity) AS Total_pizza_sold FROM pizza_sales;

#4. Total Orders :
SELECT COUNT(DISTINCT order_id) AS Total_Orders FROM pizza_sales;

#5. Average Pizzas Per Order :
SELECT 
	CAST(SUM(quantity) / COUNT(order_id) AS DECIMAL(10,2)) AS Avg_Pizzas_per_order 
	FROM pizza_sales; #Here 10 means upto ten decimal points can happen and 2 means 2 round up places.

#6.Daily Trend for Total Orders :
SELECT 
	DAYNAME(STR_TO_DATE(order_date, '%d-%dm-%y')) AS order_day, # It means converting our DD-MM-YY format to SQL YY-MM-DD format.
	COUNT(DISTINCT order_id) AS total_orders 
	FROM pizza_sales GROUP BY order_day ;

#7.Hourly Trend for Orders :
SELECT 
	HOUR(order_time) as order_hours, COUNT(DISTINCT order_id) as total_orders
	FROM pizza_sales GROUP BY HOUR(order_time) ORDER BY HOUR(order_time);

#8.% of Sales by Pizza Category :
SELECT pizza_category, CAST(SUM(total_price) AS DECIMAL(10,2)) as total_revenue,
	CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza_sales) AS DECIMAL(10,2)) AS PCT
	FROM pizza_sales GROUP BY pizza_category;

#9.% of Sales by Pizza Size :
SELECT pizza_size, CAST(SUM(total_price) AS DECIMAL(10,2)) as total_revenue,
	CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza_sales) AS DECIMAL(10,2)) AS PCT
	FROM pizza_sales GROUP BY pizza_size ORDER BY pizza_size;
	
#10.Total Pizzas Sold by Pizza Category :
SELECT pizza_category, SUM(quantity) as Total_Quantity_Sold
	FROM pizza_sales WHERE MONTH(STR_TO_DATE(order_date, '%d-%dm-%y')) = 1
	GROUP BY pizza_category ORDER BY Total_Quantity_Sold DESC;

#11.Top 5 Best Sellers by Total Pizzas Sold :
SELECT pizza_name, SUM(quantity) AS Total_Pizza_Sold
	FROM pizza_sales GROUP BY pizza_name ORDER BY Total_Pizza_Sold DESC LIMIT 5;

#12.Bottom 5 Best Sellers by Total Pizzas Sold :
SELECT pizza_name, SUM(quantity) AS Total_Pizza_Sold
	FROM pizza_sales GROUP BY pizza_name ORDER BY Total_Pizza_Sold ASC LIMIT 5;

#13.If you want to apply the Month, Quarter, Week filters to the above queries you can use WHERE clause :
SELECT 
	DAYNAME(STR_TO_DATE(order_date, '%d-%m-%y')) AS order_day, COUNT(DISTINCT order_id) AS total_orders 
	FROM pizza_sales WHERE MONTH(STR_TO_DATE(order_date, '%d-%m-%y')) = 1
	GROUP BY DAYNAME(STR_TO_DATE(order_date, '%d-%m-%y'));# In MySQL, you cannot use the alias from the SELECT clause directly in the GROUP BY clause.

#QUARTER WISE SALES :
SELECT
	QUARTER(STR_TO_DATE(order_date, '%d-%m-%y')) AS order_quarter, COUNT(DISTINCT order_id) AS total_orders
	FROM pizza_sales GROUP BY order_quarter ORDER BY order_quarter;

#WEEKWISE:
SELECT
    YEAR(STR_TO_DATE(order_date, '%d-%m-%y')) AS order_year,
    WEEK(STR_TO_DATE(order_date, '%d-%m-%y')) AS order_week, COUNT(DISTINCT order_id) AS total_orders
	FROM pizza_sales GROUP BY order_year, order_week ORDER BY order_year, order_week;

#YEARWISE :
SELECT 
	YEAR(STR_TO_DATE(order_date, '%d-%m-%y')) AS order_year,COUNT(DISTINCT order_id) AS total_orders
	FROM pizza_sales GROUP BY order_year ORDER BY order_year;

#LIVE DATA EG:LIVE BANKING,STOCK MARKET ,UBER TAXI,ZOMATO



