select *
from supermarket_sales_sheet1
order by 1,2,3;

#BRANCH WITH THE HIGHEST SALES
#branch vs totals
Select Branch, round(sum(Total),2) as Totals
from supermarket_sales_sheet1
group by Branch
order by Totals desc;

#Product line with the best sales
#product line vs Totals
select ProductLine, round(sum(Total),2) as totals
from supermarket_sales_sheet1
group by ProductLine
order by totals desc;

#product line with the highest quantity percentage
#productline vs quantity
select ProductLine, sum(quantity) as quantity_total
from supermarket_sales_sheet1
group by ProductLine
order by quantity_total desc;

#cte
with first_total as(
select ProductLine, sum(quantity) as quantity_total
from supermarket_sales_sheet1
group by ProductLine
order by quantity_total desc
),
second_total as(
select sum(quantity) as everything
from supermarket_sales_sheet1
)
select ProductLine,(ft.quantity_total/st.everything)*100 as percentage_quantity
from first_total ft,second_total st
order by percentage_quantity desc;

#most used payment
select Payment, count(Payment) as number_of_payments
from supermarket_sales_sheet1
group by payment
order by number_of_payments desc;

#city with the highest sales percentage
#city vs Totals
select City, sum(Total) as city_totals
from supermarket_sales_sheet1
group by City
order by city_totals desc;

#cte
with first_total as(
select City, sum(Total) as city_totals
from supermarket_sales_sheet1
group by City
order by city_totals desc
),
second_total as(
select sum(Total)as everything
from supermarket_sales_sheet1
)
select City,(ft.city_totals/st.everything)*100 as percentage_totals
from first_total ft, second_total st
order by percentage_totals desc;

set sql_safe_updates=0;
update supermarket_sales_sheet1
set InvoiceId='200-000',Branch='syokimau' 
where InvoiceId='101-17-6199';

delete from  supermarket_sales_sheet1 
where InvoiceId='200-000' and Branch='syokimau' ;

select InvoiceId, Gender, sum(Total) as totals,
RANK() over(
partition by Total
order by totals desc
)as ranks
From supermarket_sales_sheet1 ; 



SELECT InvoiceId, Gender, totals,
       RANK() OVER (ORDER BY totals DESC) as ranks
FROM (
    SELECT InvoiceId, Gender, SUM(Total) as totals
    FROM supermarket_sales_sheet1
    GROUP BY InvoiceId, Gender
) as subquery;

#subquerying
select InvoiceId,Gender,totals,rank() over(order by totals desc) as ranks
from(
select InvoiceId, Gender,sum(Total) as totals
from supermarket_sales_sheet1
group by InvoiceId,Gender
)  as subquery;

#common table expressions
with salesCTE as(
select InvoiceId, sum(Total) as totals
from supermarket_sales_sheet1
group by InvoiceId
)
select InvoiceId,totals
from salesCTE
where totals>1020;

select sm.InvoiceId,sq.ranks
from supermarket_sales_sheet1 sm
join(
select InvoiceId,Gender,totals,rank() over(order by totals desc) as ranks
from(
select InvoiceId, Gender,sum(Total) as totals
from supermarket_sales_sheet1
group by InvoiceId,Gender
)as subquery) as sq
on sm.InvoiceId=sq.InvoiceId;



SELECT sm.InvoiceId, sq.ranks
FROM supermarket_sales_sheet1 sm
JOIN (
    SELECT InvoiceId, Gender, totals, 
           RANK() OVER (ORDER BY totals DESC) AS ranks
    FROM (
        SELECT InvoiceId, Gender, SUM(Total) AS totals
        FROM supermarket_sales_sheet1
        GROUP BY InvoiceId, Gender
    ) AS subquery
) AS sq ON sm.InvoiceId = sq.InvoiceId;

