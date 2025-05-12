### MYSQL-DATASET_COMPUTATION
#### Sales Data Analysis Using MySQL

##### Statement of Problem
This project involves performing structured queries on a sales dataset to generate insights such as total profit, customer distribution, and sales team performance.


##### Installations:
Before running the SQL queries, I  ensured the following were installed.
-	MySQL Server
- MySQL Workbench 

##### Key Objectives:
-	Compute overall and segmented metrics from the sales dataset
-	Analyze regional and product-based performance
-	Identify top-performing customers and sales team members
- To understand the influence of sales channels on store profit

 ##### Steps Followed:

Step 1: 	Data Importation
- I loaded the CSV file into MySQL using "table data import wizard" through MySQL Workbench.
-	I ensured appropriate data types and also cleaned missing/null values where necessary.
 


-Step 2: Schema Design & Preprocessing
- I Checked column names and data types

- step 3: 	Query Execution:
- I wrote SQL queries to solve each of the given problem statements
- I	tested each query for accuracy and performance


Step 4: Some SQL Queries Used:

- TO CALCULATE TOTAL PROFIT (QUESTION 1)
select
 `product Name`, ROUND((`Order Quantity` * `Unit Price` * (1 - `Discount Applied`) - `Order Quantity` * `Unit Cost`), 2) AS Profit  

from `sales order_usa` as sales

left join product_usa as product

on sales._productID = product._productID;


-	TOTAL QUANTITY SOLD (QUESTION 2)


SELECT SUM(`Order Quantity`) AS TotalQuantitySold
FROM `sales order_usa`;

- COUNT OF CUSTOMERS BY REGION (QUESTION 9)

- select count(distinct customer._CustomerID) As count_, Region 
from `customer_usa` as customer

left join `sales order_usa` as sales 

on customer._CustomerID = sales._CustomerID


left join `store_sales_usa` as store

on sales._StoreID = store._StoreID

left join `region_usa` as region_

on store. StateCode = region_.StateCode

group by Region;

Step 5: Project questions used to generate the queries
[Project Question(mysql).pdf](https://github.com/user-attachments/files/20160920/Project.Question.mysql.pdf)

- Step 6: The .sql worksheet is uploaded as a file directly into Github





