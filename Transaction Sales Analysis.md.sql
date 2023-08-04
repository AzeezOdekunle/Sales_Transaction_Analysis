 create table Return_Items
	(id int Primary Key,
	 Order_ID int,
	 Sales_id int,
	 Order_status varchar (30) 
	);
	select * from Return_items
	
--load data using copy command into return_items
copy return_items 
from 'C:\Program Files\PostgreSQL\Returned_Item.csv' delimiter ',' csv header


create table Regional_manager
	(Region_name varchar (30) PRIMARY KEY ,
	 Manager varchar (30)
	);
--load data using copy command
copy Regional_manager 
from 'C:\Program Files\PostgreSQL\Transaction Analysis\Regional_Manager.csv' delimiter ',' csv header 
select * from Regional_manager

create table Sales
(sales_id int Primary Key,
 Order_id int,
 Real_order_date date,
 Order_Priority varchar (30),
 Order_Quantity int,
 Sales decimal,
 Discount decimal,
 Ship_Mode varchar (30),
 Profit decimal,
 Unit_price decimal,
 Shipping_Cost decimal,
 First_Name varchar (30),
 Last_Name varchar (30),
 Region varchar (30),
 Customer_Segment varchar (30) ,
 Product_Category varchar (30),
 Product_SubCategory varchar (30),
 Product_Container varchar (30),
 Ship_Date date, 
 Birth_Date date
);

select * from Sales

--load data into sales using copy command
copy Sales
from 'C:\Program Files\PostgreSQL\Transaction Analysis\Sales_Transaction.csv' delimiter ',' csv header
select * from Sales 

--Que 1: The Organization is planning to give the best performing manager who made the best sales and 
--want to know the region which the manager belongs to?

select r.manager, r.region_name, sum(s.sales) as total_sales
from sales s join regional_manager r 
on s.region= r.region_name
group by 1,2
order by 3 Desc
limit 1;
--**The best performing manager who made the best sales is PAT and is from WEST 


--Que 2: How many times was delivery truck used as the ship mode?
select count(ship_mode) ship_mode_count, ship_mode
from sales
group by 2
having ship_mode = 'Delivery Truck'
order by 1;
--**Delivery truck was used 1146 times as the ship mode



--Que 3: How many orders were returned and which product category got rejected the most?

Select r.order_status, count(r.order_status) order_status_count, s.product_category
from return_items r
inner join sales s
On r.sales_id = s.sales_id
group by 1,3
having r.order_status = 'Returned' 
order by 2 desc,3 
--**The number of orders returned are 461 (Office supplies), 218(Technology) and 193 (Furniture)**
--and Office supplies got rejected most.
	 
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

