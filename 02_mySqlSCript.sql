SELECT * FROM pizza_db.pizza_sales;

-- PART A (KPI REQUIREMENTS)----
#1. Total Revenue
SELECT  ROUND(SUM(total_price),2) AS 'Total Revenue'
	FROM pizza_sales;
    
    
#2 Avg order value
SELECT  ROUND(SUM(total_price)/COUNT(DISTINCT order_id) ,2) AS 'Avg Order Value'
	FROM  pizza_sales;
    
    
#3 Total Pizza's sold
SELECT SUM(quantity) AS 'Total pizza sold' FROM pizza_sales;

#4 Total Order
SELECT COUNT(DISTINCT order_id) AS 'Total Orders' FROM pizza_sales;

#5 Avg pizza sold per order
SELECT SUM(quantity)/COUNT(DISTINCT order_id) AS 'Avg pizza sold per order' FROM pizza_sales;


-- PART B (CHART REQUIREMENTS)--
#1 Daily trend

## CONVERTING IN DATE FORMAT
select * from pizza_sales;
UPDATE pizza_sales 
	SET order_date = str_to_date(order_date, "%d-%m-%Y");
    
ALTER TABLE pizza_sales
	MODIFY order_date DATE;
    
SELECT dayname(order_date) AS 'Day',COUNT(DISTINCT order_id) AS 'Orders' FROM pizza_sales
GROUP BY Day
ORDER BY Orders DESC;

#2 Monthly Trend
SELECT monthname(order_date) AS 'Month',COUNT(DISTINCT order_id) AS 'Orders' FROM pizza_sales
GROUP BY Month
ORDER BY Orders DESC;



#3 Percentage of sales by pizza category
SELECT pizza_category, ROUND(SUM(total_price),2) AS 'Total Revenue',
			round(
            SUM(total_price) / (SELECT SUM(total_price) from pizza_sales)*100,2
            ) AS 'PCT' FROM pizza_sales
GROUP BY pizza_category;



#4 Percentage of sales by pizza size
SELECT pizza_size, ROUND(SUM(total_price),2) AS 'Total Revenue',
			round(
            SUM(total_price) / (SELECT SUM(total_price) from pizza_sales)*100,2
            ) AS 'PCT' FROM pizza_sales
GROUP BY pizza_size;

# 5 Pizza sold by pizza catergory
SELECT pizza_category,sum(quantity) AS 'Total Pizza sold' FROM  pizza_sales
GROUP BY pizza_category;

#6 Top 5 best seller by revenue,total quantity and total Orders
#a)  best seller by revenue

SELECT pizza_name,sum(total_price) AS 'Total_Revenue' FROM pizza_sales 
GROUP BY pizza_name
ORDER BY Total_Revenue DESC LIMIT 5;


#b)  best seller by total quantity
SELECT pizza_name,sum(quantity) AS 'Total_quantity_sold' FROM pizza_sales 
GROUP BY pizza_name
ORDER BY Total_quantity_sold DESC LIMIT 5;

#c) best seller by total orders
SELECT pizza_name, COUNT(distinct order_id) AS 'Total_orders' FROM pizza_sales 
GROUP BY pizza_name
ORDER BY Total_orders DESC LIMIT 5;



#7 bottom 5  seller by revenue,total quantity and total Orders
#a)  Bottom 5 seller by revenue
SELECT pizza_name,sum(total_price) AS 'Total_Revenue' FROM pizza_sales 
GROUP BY pizza_name
ORDER BY Total_Revenue  LIMIT 5;


#b)  Bottom 5 seller by total quantity
SELECT pizza_name,sum(quantity) AS 'Total_quantity_sold' FROM pizza_sales 
GROUP BY pizza_name
ORDER BY Total_quantity_sold  LIMIT 5;

#c) Bottom 5 seller by total orders
SELECT pizza_name, COUNT(distinct order_id) AS 'Total_orders' FROM pizza_sales 
GROUP BY pizza_name
ORDER BY Total_orders  LIMIT 5;






















