1. The Organization is planning to give the best performing manager who made the best sales and want to know the region which the manager belongs to ?
   

SELECT r.manager, r.region_name, SUM(s.sales) AS total_sales
FROM sales s INNER JOIN regional_manager r 
on s.region= r.region_name
GROUP BY 1,2
ORDER BY 3 DESC
LIMIT 1;

## Output 
The best performing manager who made the best sales is PAT and is from WEST 


![image](https://github.com/AzeezOdekunle/Sales_Transaction_Analysis/assets/139698365/0f3fe8b9-805c-4d68-8b63-166d68a76570) 



2. How many times was delivery truck used as the ship mode?

SELECT 
COUNT(ship_mode) AS ship_mode_count, 
ship_mode
FROM sales
GROUP BY 2
HAVING ship_mode = 'Delivery Truck'
ORDER BY 1;

## Output

![image](https://github.com/AzeezOdekunle/Sales_Transaction_Analysis/assets/139698365/9e7bdbb0-1982-4d4c-9ea5-5ad8eec9c003)

Delivery truck was used 1146 times as the ship mode



3. ### How many orders were returned and which product category got rejected the most?

SELECT r.order_status, COUNT(r.order_status) order_status_count, s.product_category
FROM return_items r
INNER JOIN sales s
ON r.sales_id = s.sales_id
GROUP BY 1,3
HAVING r.order_status = 'Returned' 
ORDER BY 2, 3 DESC;

## Output

![image](https://github.com/AzeezOdekunle/Sales_Transaction_Analysis/assets/139698365/733ff11b-4f56-49c9-b6ac-c14f1181a6f1)

The number of orders returned are 461 (Office supplies), 218(Technology) and 193 (Furniture) and Office supplies got rejected most.
	 
-- Que 4: Which Year did the company incurred the least shipping cost

select date_trunc('year', ship_date) least_incurredYear,
	   sum(shipping_cost) Total_shipping
from  sales
	group by 1
	order by 2
	limit 1;
--**The company incurred the least shipping cost of 24976.35 in the Year 2011


--Que 5: Display the day of the week in which customer segment has the most sales?

select date_part('dow', ship_date) sales_day,
		customer_segment, sum(sales) total_sales  
from sales
	group by 1,2 
	order by 3 desc
	limit 1;
--**The week in which customer segment has the most sales is day 0 (Sunday)


--Que 6: The company want to determine its profitability by knowing the actual orders that were delivered

select sum(s.order_quantity), r.order_status
from return_items r join sales s
on r.sales_id = s.sales_id
group by 2
having r.order_status = 'Delivered'
order by 1;


--Que 7: The Organization is eager to know the customer names and persons born in 2011?

select concat(first_name,' ',last_name) full_name, birth_date
from sales
group by 1,2
--**The table below shows the Customer's full name and their birth dates.

select concat(first_name,' ',last_name) full_name, birth_date
from sales
group by 1,2
having birth_date between '2010-12-31' and '2012-01-01'
--None of the customers were born in 2011

--Que 8: What are the aggregate orders made by all the customers

select sum(order_quantity) aggregate_orders 
from sales;

--Que 9: What are the aggregate orders made by each of the customer?

select sum(order_quantity) aggregate_orders,
                  concat(first_name, ' ',last_name) AS customer_name
from sales
		group by 2
		order by 1;



--Que 10: The company intends to discontinue any product that brings in the least profit, you are 
--required to help the organization to determine the product?

select product_category, min (profit) least_profit 
from sales
group by 1
order by 2
Limit 1;
--The product with the least profit is -14140.7, followed by Furniture (-11053.6) and Office supplies -2175.09


--Que 11: What are the top 2 best selling items that the company should keep selling?

select product_category, sum (profit) top_selling_items 
from sales
group by 1
order by 2 desc
Limit 2;

