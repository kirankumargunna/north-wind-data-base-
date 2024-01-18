--scenario2

--As a procurement manager, you want to evaluate the performance of your suppliers.
--Write a query to calculate metrics such as on-time delivery
--based on historical order data in the Northwind database.

----------ON TIME DELIVERIES-------------

select 
	s.SupplierID,
	companyName,
	sum(case when shippeddate<=requireddate then 1 else 0 end) as ontimedeliveries,
	count(o.orderid)as totalorders,
	sum(case when shippeddate<=requireddate then 1 else 0 end) * 100/count(o.orderid) as onTimeDeliverypercentage
from Suppliers s 
join Products p on s.SupplierID = p.SupplierID
join [Order Details] od on p.ProductID = od.ProductID
join orders o on od.OrderID=o.OrderID
group by s.SupplierID,CompanyName
order by ontimedeliveries


