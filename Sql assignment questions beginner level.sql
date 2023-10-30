--Q.1

select count(distinct companyname) as total_customers from customers
select count(*) from customers

--Q.2
select companyname from customers where CompanyName like 'b%'

--Q.3

select companyname from customers where CompanyName   like '%s%'

--Q.4

select city,
	   count(customerid) as noOfCustomers
	   from customers
	   group by city 
	   order by noOfCustomers 

--Q.5

select top 3  city,
	   count(customerid) as noOfCustomers
	   from customers
	   group by city 
	   order by noOfCustomers desc
	       --or---

 with cte as 
(select city,
	   count(customerid) as noOfCustomers,
	   ROW_NUMBER() over (order by  count(customerid) desc) as rownumber
	   from customers
	   group by city )

	   select city, noOfCustomers from cte where rownumber<4

--Q.6

with cte as 
( select  c.CustomerID,
	 CompanyName,
	 ContactName,
	 count(orderid ) as totalOrders,
	 ROW_NUMBER() over (order by  count(orderid ) desc) as rownum from [dbo].[Customers] c
 join orders o  on c.CustomerID=o.CustomerID
 group by c.CustomerID,CompanyName,ContactName)
 
 select CustomerID,
	 CompanyName,
	 ContactName
from cte where rownum=1 


--Q.7


with cte as 
( select  c.CustomerID,
	 CompanyName,
	 ContactName,orderdate,
	 count(orderid ) as totalOrders,
	 ROW_NUMBER() over (order by  count(orderid ) desc) as rownum from [dbo].[Customers] c
 join orders o  on c.CustomerID=o.CustomerID
 group by c.CustomerID,CompanyName,ContactName,orderdate)
 
 select CustomerID,
	 CompanyName
from cte where rownum=1 and  orderdate like '%1997%'


--Q.8

select top 3 country,
		count(orderid) noOfOrders
from customers c 
join orders o on c.CustomerID=o.CustomerID
group by country
order by noOfOrders desc

--Q.9

select  top 1 companyname as shippername ,
		count(o.ShipVia) totalShipments 
from shippers s
join orders o on s.ShipperID=o.ShipVia
group by CompanyName

--Q.11

select lastname from employees
where DATEPART(month,birthdate)=09

--Q.12
select 
	firstname, 
	lastname, 
	territorydescription as territory 
from employees e
join EmployeeTerritories et on e.EmployeeID=et.EmployeeID
join Territories t on et.TerritoryID=t.TerritoryID
group by TerritoryDescription,LastName,FirstName


--Q.13

with cte as (
select 
	od.productid,
	sum(od.UnitPrice*od.Quantity) as saleamount,
	productname 
from [Order Details] od 
join Products p on od.ProductID= p.ProductID 
group by od.ProductID,ProductName
)

select  productname as topsaleproduct from cte where saleamount=(select max(saleamount) from cte)