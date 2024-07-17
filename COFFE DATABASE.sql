SELECT * 
from coffee
order by 1,2,3;

select*
from coffee4
order by 1,2,3;

select*
from customers
order by 1,2,3;

#total sales by year
#2019

select OrderID,OrderDate, round(sum(Sales),2) as total_sales
from customers
where Sales is not NULL and OrderDate like '%19'
group by OrderID, OrderDate
order by total_sales desc;

#2020
select OrderID,OrderDate, round(sum(Sales),2) as total_sales
from customers
where Sales is not NULL and OrderDate like '%20'
group by OrderID, OrderDate
order by total_sales desc;

#2021
select OrderID,OrderDate, round(sum(Sales),2) as total_sales
from customers
where Sales is not NULL and OrderDate like '%21'
group by OrderID, OrderDate
order by total_sales desc;

#2022
select OrderID,OrderDate, round(sum(Sales),2) as total_sales
from customers
where Sales is not NULL and OrderDate like '%22'
group by OrderID, OrderDate
order by total_sales desc;

#total sales by country

select Country, round(sum(Sales),2) as country_sales
from customers
group by Country
order by country_sales desc; 

#top products sold
#coffee type vs Sales
select CoffeeType, round(sum(Sales),2) as type_sales
from customers
group by CoffeeType
order by type_sales;

#customer order frequency
select CustomerID, count(CustomerID) as customer_frequency
from coffee4
order by Customer ID
 
