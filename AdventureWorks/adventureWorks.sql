use AdventureWorks

select
	*
from Customers

select 
	*
from Sales_2016

select 
	*
from Products

--shows total orderqty, revenue, cost of goods, and profit for each item in 2016

SELECT 
    p.productkey,
    p.productname,
    pc.categoryname,
    ps.subcategoryname,
    SUM(CAST(s.orderQuantity AS int)) AS orderqty,
    SUM(CAST(s.orderQuantity AS int)) * ((CAST(p.productprice AS DECIMAL (10 , 2 )))) AS Revenue,
    SUM(CAST(s.orderQuantity AS int)) * (CAST(p.productcost AS DECIMAL (10 , 2 ))) AS COGs,
    (SUM(CAST(s.orderQuantity AS int)) * ((CAST(p.productprice AS DECIMAL (10 , 2 ))))) - (SUM(CAST(s.orderQuantity AS DECIMAL (10 , 2 ))) * (CAST(p.productcost AS DECIMAL (10 , 2 )))) AS Profit
FROM
    sales_2016 s
        JOIN
    products p ON s.productkey = p.productkey
        JOIN
    product_subcategories ps ON ps.productsubcategorykey = p.productsubcategorykey
        JOIN
    product_categories pc ON pc.productcategorykey = ps.productcategorykey
GROUP BY p.productkey, p.productname, pc.categoryname, ps.subcategoryname, p.productprice, p.productcost
ORDER BY Profit desc;

--creates temp table (customerIndividualSales) to get individual sales by each customer 2016

select 
	c.customerkey,
	SUM(CAST(s.orderQuantity AS int)) * CAST(p.productprice AS DECIMAL (10 , 2 )) AS totalCustomerSales
into ##customerIndividualSales
FROM
    sales_2016 s
        JOIN
    products p ON s.productkey = p.productkey
		JOIN
	Customers c on c.CustomerKey = s.CustomerKey
group by c.CustomerKey, p.productprice 
order by c.CustomerKey

-- uses temp table customerIndividualSales to total sales for each individual customer 2016

select customerkey, SUM(totalCustomerSales) as totalCustomerSales
from ##customerIndividualSales
group by CustomerKey
order by totalCustomerSales desc

--get the age of customers, create temp table customers age

select customerkey, datediff(YY,birthdate,getdate()) as age
into ##customersAge
from customers
group by CustomerKey, BirthDate
order by  age

--finding the average age of customers from temp table customersAge
select AVG(age)
from ##customersAge

--male vs female customer count

select COUNT(case when gender = 'M' then 1 end) as male_count,
	   COUNT(case when gender = 'F' then 1 end) as female_count
from Customers

--total sales by gender

select gender, SUM(totalcustomersales) as revenue
from Customers c
join ##customerIndividualSales s
on s.CustomerKey= c.CustomerKey
group by Gender
order by revenue desc

--income level customer count

select COUNT(case when incomeLevel = 'High' then 1 end) as high_income,
	   COUNT(case when incomeLevel = 'Average' then 1 end) as average_income,
	   COUNT(case when incomeLevel = 'Low' then 1 end) as low_income
from Customers

--total sales by income level

select incomeLevel, SUM(totalcustomersales) as revenue
from Customers c
join ##customerIndividualSales s
on s.CustomerKey= c.CustomerKey
group by IncomeLevel
order by revenue desc

--total sales by customer occupation

select Occupation, SUM(totalcustomersales) as revenue
from Customers c
join ##customerIndividualSales s
on s.CustomerKey= c.CustomerKey
group by Occupation
order by revenue desc

-- count of customers with children

select COUNT(case when totalchildren > 0 then 1 end) as has_children,
	   COUNT(case when totalchildren = 0 then 1 end) as no_children
from customers

--total sales for customer with and customers without children

select SUM(totalCustomerSales) as SalesWithChildren
from ##customerIndividualSales s
join Customers c
on s.CustomerKey = c.CustomerKey
where c.TotalChildren > 0


select
SUM(totalCustomerSales) as SalesWithoutChildren
from ##customerIndividualSales s
join Customers c
on s.CustomerKey = c.CustomerKey
where c.TotalChildren = 0

--YoY customer count into temp table ##YoYCustomerCount

select (
	   select COUNT(distinct(customerkey))
	   from Sales_2015) as customer_count_2015,
	   (
	   select COUNT(distinct(customerkey))
	   from Sales_2016) as customer_count_2016,
	   (
	   select  COUNT(distinct(customerkey))
	   from Sales_2017) as customer_count_2017
into ##YoYCustomerCount	   

--Relative Change of customer count Yoy 

select round((customer_count_2016 - customer_count_2015) / customer_count_2016 * 100, 2) as customer_count_percent_change_2015_2016,
	    round((customer_count_2017 - customer_count_2016) / customer_count_2017 * 100, 2) as customer_count_percent_change_2016_2017
from ##YoYCustomerCount

--create temp table ##first_purchase_table to determine customers first purchase date

select * into ##first_purchase_table from (SELECT DISTINCT

CustomerKey, orderdate,

MIN(orderdate) OVER (PARTITION BY customerkey) AS first_purchase_date

FROM Sales_2015 

union

SELECT DISTINCT

CustomerKey, orderdate,

MIN(orderdate) OVER (PARTITION BY customerkey) AS first_purchase_date

FROM Sales_2016 

union

SELECT DISTINCT

CustomerKey, orderdate,

MIN(orderdate) OVER (PARTITION BY customerkey) AS first_purchase_date

FROM Sales_2017 ) as tmp

--uses ##first_purchase_table to flag each customer as a new or returning customer and inserts into ##newVSrepeatCustomer

select customerkey, orderdate,
	   CASE WHEN orderdate = first_purchase_date THEN 1 ELSE 0 END AS isNewCustomer,
	   CASE WHEN orderdate != first_purchase_date THEN 1 ELSE 0 END AS isRepeatCustomer
into ##newVSrepeatCustomer
from ##first_purchase_table

--total # of new vs repeat customer per year

select year(orderdate) as Year, sum(isnewcustomer)as NewCustomers, sum(isrepeatcustomer)as RepeatCustomers
from ##newVSrepeatCustomer
group by year(OrderDate)
order by year(orderdate)


