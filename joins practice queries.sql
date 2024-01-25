---retrieve the product information, including the product name, vendor name, and vendor contact details.

select * from [Production].[Product]
select * from [Purchasing].[ProductVendor]
select * from [Person].[Person]
select * from [Person].[BusinessEntityContact]
select * from [Person].[PersonPhone]


select  pro.name product_name ,
	   concat(p.firstname,p.middlename,p.lastname) vendor_name ,
	   perphone.PhoneNumber 
from [Production].[Product] pro 
	left join [Purchasing].[ProductVendor] prov on pro.ProductID=prov.ProductID
	left join [Person].[BusinessEntityContact] pbec on prov.BusinessEntityID=pbec.BusinessEntityID 
	 left join [Person].[Person] p on pbec.PersonID=p.BusinessEntityID
	 left join [Person].[PersonPhone] perphone on p.BusinessEntityID=perphone.BusinessEntityID
	 order by product_name,vendor_name,PhoneNumber

	 /************ show the total sales amount for each product category in each sales territory.******/

	 select * from Production.ProductCategory
	 select * from Production.ProductSubcategory
	 select * from Production.Product
	 select * from Sales.SalesTerritory
	 select * from Sales.SalesOrderHeader
	 select * from Sales.SalesOrderDetail



	 select pc.name product_category,
			st.Name,
	        sum(sod.orderqty*sod.unitprice)
	 from [Production].[ProductCategory] pc
	 join [Production].[ProductSubcategory] psc on pc.ProductCategoryID=psc.ProductCategoryID
	 join [Production].[Product] p on psc.ProductSubcategoryID=p.ProductSubcategoryID
	 join [Sales].[SalesOrderDetail] sod on p.ProductID=sod.ProductID
	 join [Sales].[SalesOrderHeader] soh on sod.SalesOrderID=soh.SalesOrderID
	 join [Sales].[SalesTerritory] st on soh.TerritoryID=st.TerritoryID
	 group by pc.name,st.Name 
	 order by product_category

	 /*****customers who have not placed any orders. Display customer details along with the number of orders.**********/
	 
	 select * from Sales.SalesOrderHeader 
	 select * from Sales.SalesOrderDetail 

	 select distinct CustomerID from Sales.SalesOrderHeader			--19,119
	 select distinct CustomerID from Sales.Customer					--19,820


	 select distinct c.CustomerID customer_id,
		    count(soh.SalesOrderID) no_of_orders
	 from [Sales].[Customer] c
	 left join  [Sales].[SalesOrderHeader] soh on c.CustomerID=soh.CustomerID
	 group by c.CustomerID
	 order by no_of_orders


	 /***Retrieve a list of products that have no sales . Include product details and sales information.****/

	 select * from Production.Product 
	 select * from Sales.SalesOrderDetail 

	 select p.ProductID,
			p.name,
			p.color,
			p.safetystocklevel,
			sod.SalesOrderID
	 from [Production].[Product] p 
	 left join [Sales].[SalesOrderDetail] sod on p.ProductID=sod.ProductID
	 where sod.SalesOrderID is null

	 /****query to find customers with a high lifetime value, considering the total amount spent on orders***/

	 select * from Sales.Customer 
	 select * from Sales.SalesOrderHeader 
	 select * from Sales.SalesOrderDetail
	-- select * from Person.Person
	--select * from Person.BusinessEntityContact



	 select top 100 c.CustomerID,
			sum(sod.UnitPrice*sod.OrderQty) total_purchase_amount	
	from [Sales].[Customer] c
	 join [Sales].[SalesOrderHeader] soh on c.CustomerID=soh.CustomerID
	 join [Sales].[SalesOrderDetail] sod on soh.SalesOrderID=sod.SalesOrderID
	 group by c.CustomerID
	 order by total_purchase_amount desc


	 /******Identify employees who work in the same department but different locations. Display their details.****/





	 /**********************************************

Cumulative Sales by Product and Month:
Create a query to calculate cumulative sales for each product over months, showing the running total.

Find Customers with Similar Purchase Patterns:
Identify customers who have similar purchase patterns based on the products they have bought. Consider product categories and quantities.

List Products with Price Changes:
Retrieve a list of products that have experienced price changes, showing the old and new prices along with the change percentage.

Employee Sales Performance Ranking:
Create a query to rank employees based on their total sales performance. Display employee details and ranking.

************************/