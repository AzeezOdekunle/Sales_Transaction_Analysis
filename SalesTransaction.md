1. #### The Organization is planning to give the best performing manager who made the best sales and want to know the region which the manager belongs to ?

SELECT r.manager, r.region_name, SUM(s.sales) AS total_sales
FROM sales s INNER JOIN regional_manager r 
on s.region= r.region_name
GROUP BY 1,2
ORDER BY 3 DESC
LIMIT 1;

## Output 
The best performing manager who made the best sales is PAT and is from WEST 

![image](https://github.com/AzeezOdekunle/Sales_Transaction_Analysis/assets/139698365/0f3fe8b9-805c-4d68-8b63-166d68a76570) 

2. #### How many times was delivery truck used as the ship mode?

SELECT 
COUNT(ship_mode) AS ship_mode_count, 
ship_mode
FROM sales
GROUP BY 2
HAVING ship_mode = 'Delivery Truck'
ORDER BY 1;

## Output
Delivery truck was used 1146 times as the ship mode

![image](https://github.com/AzeezOdekunle/Sales_Transaction_Analysis/assets/139698365/9e7bdbb0-1982-4d4c-9ea5-5ad8eec9c003)



3. #### How many orders were returned and which product category got rejected the most ?

SELECT r.order_status, COUNT(r.order_status) order_status_count, s.product_category
FROM return_items r
INNER JOIN sales s
ON r.sales_id = s.sales_id
GROUP BY 1,3
HAVING r.order_status = 'Returned' 
ORDER BY 2, 3 DESC;

## Output
The number of orders returned are 461 (Office supplies), 218(Technology) and 193 (Furniture) and Office supplies got rejected most.
	 
![image](https://github.com/AzeezOdekunle/Sales_Transaction_Analysis/assets/139698365/733ff11b-4f56-49c9-b6ac-c14f1181a6f1)


4. #### Which Year did the company incurred the least shipping cost ?

SELECT DATE_TRUNC('year', ship_date) least_incurredYear,
	   SUM(shipping_cost) Total_shipping
FROM  sales
	GROUP BY 1
	ORDER BY 2
	LIMIT 1;

 ## Output
 The company incurred the least shipping cost of 24976.35 in the Year 2011

 ![image](https://github.com/AzeezOdekunle/Sales_Transaction_Analysis/assets/139698365/110196c2-46c2-493b-b515-2cdc49769c5e)



5. #### Display the day of the week in which customer segment has the most sales ?

SELECT DATE_PART('dow', ship_date) sales_day,
		customer_segment, sum(sales) total_sales  
FROM sales
	GROUP BY 1,2 
	ORDER BY 3 DESC
	LIMIT 1;

## Output
The week in which customer segment has the most sales is day 0 (Sunday)

![image](https://github.com/AzeezOdekunle/Sales_Transaction_Analysis/assets/139698365/3cb81a95-e564-482b-aca2-7d1d527cd38e)


6. #### The company want to determine its profitability by knowing the actual orders that were delivered

SELECT SUM(s.order_quantity), r.order_status
FROM return_items r join sales s
ON r.sales_id = s.sales_id
GROUP BY 2
HAVING r.order_status = 'Delivered'
ORDER BY 1;

## Output

![image](https://github.com/AzeezOdekunle/Sales_Transaction_Analysis/assets/139698365/8732ff8f-5968-48d6-b58d-0d9979da3600)



7. #### The Organization is eager to know the customer names and persons born in 2011 ?

SELECT CONCAT(first_name,' ',last_name) full_name, birth_date
FROM sales
GROUP BY 1,2
HAVING birth_date between '2010-12-31' AND '2012-01-01'

## Output
None of the customers were born in 2011

![image](https://github.com/AzeezOdekunle/Sales_Transaction_Analysis/assets/139698365/4cb041b3-101b-4606-83f3-14a447fb9640)


8. #### What are the aggregate orders made by all the customers ?

SELECT SUM(order_quantity) aggregate_orders 
FROM sales;

## Output

![image](https://github.com/AzeezOdekunle/Sales_Transaction_Analysis/assets/139698365/b649e978-eb3e-4ad4-8c19-e15f1f820049)


9. #### What are the aggregate orders made by each of the customer?

SELECT SUM(order_quantity) aggregate_orders,
                  CONCAT(first_name, ' ',last_name) AS customer_name
FROM sales
		GROUP BY 2
		ORDER BY 1;

  ## Output

  ![image](https://github.com/AzeezOdekunle/Sales_Transaction_Analysis/assets/139698365/71e96d7c-b6ce-4de6-9ef2-91eb2d3a8680)


10. #### The company intends to discontinue any product that brings in the least profit, you are required to help the organization to determine the product ?

SELECT product_category, MIN (profit) least_profit 
FROM sales
GROUP BY 1
ORDER BY 2
LIMIT 1;

## Output
The product with the least profit is -14140.7, followed by Furniture (-11053.6) and Office supplies -2175.09

![image](https://github.com/AzeezOdekunle/Sales_Transaction_Analysis/assets/139698365/e3673957-c462-44eb-b702-6f25e0b70bee)


11. #### What are the top 2 best selling items that the company should keep selling ?

SELECT product_category, SUM (profit) top_selling_items 
FROM sales
GROUP BY 1
ORDER BY 2 desc
LIMIT 2;

## Output

![image](https://github.com/AzeezOdekunle/Sales_Transaction_Analysis/assets/139698365/1e3aa5ee-c9c5-4954-bce2-7ffd7667be77)


