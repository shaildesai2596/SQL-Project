--this is main 3 branch
--this is main 2 branch
--create new column of sales

update ['Sales Orders Sheet$']
set sales = [Unit Price] * [Order Quantity];

--sales channel wise 

select [Sales Channel], format(sum(sales), '#,#') as Total_Sales from ['Sales Orders Sheet$']
group by [Sales Channel];


--gap between procured_date and order_date

update ['Sales Orders Sheet$']
set [diff_between_procureddate_orderdate] = DATEDIFF(MONTH, ['Sales Orders Sheet$'].ProcuredDate, ['Sales Orders Sheet$']. OrderDate);

select ['Sales Orders Sheet$'].ProcuredDate, ['Sales Orders Sheet$'].OrderDate, [diff_between_procureddate_orderdate]
from ['Sales Orders Sheet$'];

--DAYS NOT GETTING DISPLAYED SO MONTH IS TAKEN AS AN ARGUMENT IN DATEDIFF

--top 5 highest discount given to which customers

select top 5 ([Discount Applied]), ['Sales Orders Sheet$']._CustomerID, [Customer Names] 
from ['Sales Orders Sheet$'] join
[dbo].['Customers Sheet$']
on ['Sales Orders Sheet$']. _CustomerID = ['Customers Sheet$']. _CustomerID
order by ([Discount Applied]) desc

--maximum sales of which products
--channel wise which product is sold the maximum (quantity wise)

alter table [dbo].['Sales Orders Sheet$']
add quantity_sold int;

update ['Sales Orders Sheet$']
set [quantity_sold]= (select sum([Order Quantity]) from ['Sales Orders Sheet$']
group by _ProductID, [Sales Channel]);

--qtr wise sales

select DATEPART(YEAR, [OrderDate]) as year, DATEPART(quarter, [OrderDate]) as quarter, sum(sales) as sales from ['Sales Orders Sheet$']
group by DATEPART(YEAR, [OrderDate]), DATEPART(quarter, [OrderDate])
order by 1,2;

--year wise sales

select DATEPART(YEAR, [OrderDate]) as year, sum(sales) as sales from ['Sales Orders Sheet$']
group by DATEPART(YEAR, [OrderDate])
order by 1;

--state wise sales

