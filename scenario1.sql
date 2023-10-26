--High-Value Customers:

--High-value customers are those who have made significant purchases.
--You can define them as customers with a total purchase amount (revenue) above a certain threshold.
select
	c.CustomerID,
	c.ContactName,
	count(quantity) as quantity,
	sum(od.unitPrice * od.quantity) as TotalPurchaseAmount
from customers c 
join orders o  on c.CustomerID=o.CustomerID
join [Order Details] od on o.orderid=od.OrderID
group by c.CustomerID,c.ContactName
Having sum(od.unitPrice * od.Quantity)>10000

--Frequent Buyers:

--Frequent buyers are those who have placed a large number of orders. 
--You can define them as customers with a high count of orders.

select
	c.CustomerID,
	c.ContactName,
	count(quantity) as quantity
from customers c 
join orders o  on c.CustomerID=o.CustomerID
join [Order Details] od on o.orderid=od.OrderID
group by c.CustomerID,c.ContactName
Having count(quantity)>10;

--Lapsed Customers:

--Lapsed customers are those who have not made a purchase for a certain period. 
--You can define them as customers who have not placed an order in the last X months.

select
	c.CustomerID,
	c.ContactName,
	cast(DATEDIFF(month,max(o.OrderDate),'1998-05-06') as varchar(5))+' months ago' as last_order 
	from customers c
join orders o  on c.CustomerID=o.CustomerID
group by c.CustomerID,c.ContactName
Having DATEDIFF(month,max(o.OrderDate),'1998-05-06')>6
order by last_order