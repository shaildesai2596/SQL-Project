--top 5 sales and their respective customers

select top 5 [Sales], customername from sales_data_sample 
order by sales desc ;

--top 10 quantity ordered and their respective customers

select top 10 [quantityordered], customername from sales_data_sample 
order by quantityordered desc ;

--total sales qtr wise

select qtr_id, sum(sales) as total_sales from sales_data_sample 
group by QTR_ID
order by sum(sales) desc;

--total sales qtr wise + product line wise

select qtr_id, productline, sum(sales) as total_sales from sales_data_sample 
group by QTR_ID, productline
order by sum(sales) desc;

--top 5 max sales on a single date

select top 5 sum(sales) as Max_Sales_On_Single_Day, customername, cast(ORDERDATE as date) as Date from sales_data_sample 
group by ORDERDATE
order by sum(sales) desc;

--product line with least sales

select sum(sales) as Least_Sales, PRODUCTLINE from sales_data_sample
group by PRODUCTLINE
order by sum(sales) asc;

--check duplication in orders

select *, ROW_NUMBER() over
(
partition by 
ordernumber
order by
ordernumber
)
from sales_data_sample;


--top 5 customers with maximum orders

select customername, count(customername) as count from sales_data_sample
group by CUSTOMERNAME
order by count(CUSTOMERNAME) desc;

--top 5 orders with large deal size

select top 5 * from sales_data_sample
where [DEALSIZE] = 'large';

--countries with least orders

select count(*), COUNTRY from sales_data_sample
group by country
order by count(*);
