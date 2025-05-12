select *
from customer_usa;

select *
from product_usa;

select *
from region_usa;

SELECT * 
FROM `sales order_usa`;

SELECT * 
FROM `sales team_usa`;

SELECT * 
FROM `store_sales_usa`;

-- TO CALCULATE TOTAL PROFIT (QUESTION 1)
select
 `product Name`, ROUND((`Order Quantity` * `Unit Price` * (1 - `Discount Applied`) - `Order Quantity` * `Unit Cost`), 2) AS Profit  
from `sales order_usa` as sales
left join product_usa as product
on sales._productID = product._productID;

-- TOTAL QUANTITY SOLD (QUESTION 2)
SELECT SUM(`Order Quantity`) AS TotalQuantitySold
FROM `sales order_usa`;

-- CUSTOMER COUNT (QUESTION 3)
select
count(distinct `sales order_usa`._CustomerID) as customer_count 
from `sales order_usa`;

-- TOTAL PROFIT BY REGION (QUESTION 4)
select
Region, SUM(ROUND((`Order Quantity` * `Unit Price` * (1 - `Discount Applied`) - `Order Quantity` * `Unit Cost`), 2)) AS total_Profit  
from `sales order_usa` as sales
left join `store_sales_usa` as store
on sales._StoreID = store._StoreID
left join `region_usa` as region_
on store. StateCode = region_.StateCode
group by Region
order by total_Profit  DESC; 

-- TOP REGION ONLY
select
Region, SUM(ROUND((`Order Quantity` * `Unit Price` * (1 - `Discount Applied`) - `Order Quantity` * `Unit Cost`), 2)) AS total_Profit  
from `sales order_usa` as sales
left join `store_sales_usa` as store
on sales._StoreID = store._StoreID
left join `region_usa` as region_
on store. StateCode = region_.StateCode
group by Region
order by total_Profit  DESC 
limit 1;

-- PRODUCTS CONTRIBUTING MOST TO PROFIT IN EACH REGION (QUESTION 5)
select
`Product Name`, Region,
 SUM(ROUND((`Order Quantity` * `Unit Price` * (1 - `Discount Applied`) - `Order Quantity` * `Unit Cost`), 2)) AS total_Profit  
from `sales order_usa` as sales
left join `product_usa` as product
on sales._ProductID = product._ProductID
left join `store_sales_usa` as store
on  sales._StoreID = store._StoreID 
left join `region_usa` as region_
on store. StateCode = region_.StateCode
group by Region, `Product Name`  
order by Region, total_profit DESC;

-- SALES CHANNELS EFFECT ON PROFIT (QUESTION 6) 
select `Sales Channel`, SUM(ROUND((`Order Quantity` * `Unit Price` * (1 - `Discount Applied`) - `Order Quantity` * `Unit Cost`), 2)) AS total_Profit  
from `sales order_usa`
group by`Sales Channel`
order by total_profit DESC; 

-- AVERAGE PROFIT ACROSS DIFFERENT REGIONS (QUESTION 7)
select
Region, avg(ROUND((`Order Quantity` * `Unit Price` * (1 - `Discount Applied`) - `Order Quantity` * `Unit Cost`), 2)) AS average_Profit  
from `sales order_usa` as sales
left join `store_sales_usa` as store
on sales._StoreID = store._StoreID
left join `region_usa` as region_
on store. StateCode = region_.StateCode
group by Region;

-- TOP 10 CUSTOMERS by REVENUE--Revenue = Price * Quantity (QUESTION 8)
select `Customer Names`, sum(`Unit Price` * `Order Quantity` ) As total_revenue
from `sales order_usa` as sales
left join `customer_usa` as customer
on sales._CustomerID = customer._CustomerID
group by `Customer Names`
order by total_revenue DESC
limit 10;  

-- COUNT OF CUSTOMERS BY REGION (QUESTION 9)
select count(distinct customer._CustomerID) As count_, Region 
from `customer_usa` as customer
left join `sales order_usa` as sales 
on customer._CustomerID = sales._CustomerID
left join `store_sales_usa` as store
on sales._StoreID = store._StoreID
left join `region_usa` as region_
on store. StateCode = region_.StateCode
group by Region;

-- TOP 5 REVENUE-GENERATING SALES TEAM MEMBERS--Revenue = Price * Quantity (QUESTION 10)
select `Sales Team`,  sum(`Unit Price` * `Order Quantity` ) As total_revenue
from `sales order_usa` as sales
left join `sales team_usa` as team
on sales._SalesTeamID = team._SalesTeamID
group by `Sales Team`
order by total_revenue DESC
limit 5;