use Company

select  * from projects
select  * from employee
---select the employess who are in projects 
SELECT Id as EmployeeID, 
	   Name, 
	   Department, 
	   City, 
	   Title as Project, 
	   ClientId
FROM Employee 
INNER JOIN Projects 
ON Employee.Id = Projects.EmployeeId

----display the information of employees who are working on project and who are not in projects 

	SELECT Id as EmployeeID, 
		   Name, 
		   Department, 
		   City, 
		   Title as Project, 
		   ClientId
	FROM Employee 
	LEFT JOIN Projects 
	ON Employee.Id = Projects.EmployeeId

	----get all the project details alog with the assigned employee datails and projects that are not assigned to any employee 

	SELECT Title as Project,
		   Id as EmployeeID, 
		   Name, 
		   Department, 
		   City, 
		   ClientId
	FROM Employee 
	RIGHT JOIN Projects 
	ON Employee.Id = Projects.EmployeeId
	order by EmployeeID desc
	
	---get all the employe and project details 

	SELECT 
		Id as EmployeeID,
		Name,
		Department,
		City,
		Title as Project, 
		ClientId
	FROM Employee 
	FULL JOIN Projects 
	ON Employee.Id = Projects.EmployeeId




	/********************************************************************************************************************************/

use adventureworks2022
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



	 /***write a query to find the total sales by category and subcategory wise and percentage of sale in total sale ****/



  with cte as 
	( 
	  select 
	  pc.Name as name,
	  psc.name subcategory,
	  sum(sod.OrderQty*sod.UnitPrice) as total_sale
	  from [Production].[ProductCategory] pc
	  join [Production].[ProductSubcategory] psc on pc.ProductCategoryID=psc.ProductCategoryID
	  join [Production].[Product] p on psc.ProductSubcategoryID=p.ProductSubcategoryID
	  join [Sales].[SalesOrderDetail] sod on p.ProductID=sod.ProductID
	  group by pc.name, psc.name
	)
	  select 
	  name as category,
	  subcategory,
	  total_sale,
	  concat(ROUND(cast(total_sale as float)*100/sum(total_sale) over(),1),'%') as percentage
	  from cte
	  group by name,subcategory,total_sale
	  order by category

	  /***find the top 3 products in each product category based on their sales amount.
	  Include columns like ProductCategory, ProductName, SalesAmount, and the rank of each product within its category.*****/

	  with cte (category, product,total_sale, rownum)
	  as 
	( 
	  select 
	  pc.name,
	  p.name,
	  sum(sod.OrderQty*sod.UnitPrice),
	  row_number() over(partition by pc.name order by sum(sod.OrderQty*sod.UnitPrice) desc) 
	  from [Production].[ProductCategory] pc
	  join [Production].[ProductSubcategory] psc on pc.ProductCategoryID=psc.ProductCategoryID
	  join [Production].[Product] p on psc.ProductSubcategoryID=p.ProductSubcategoryID
	  join [Sales].[SalesOrderDetail] sod on p.ProductID=sod.ProductID
	  group by pc.name, p.name
	)
	select * from cte
	where rownum<4
	order by category


	/*****************************************/
	select DATENAME(DW,1)
	SELECT DATENAME(weekday, GETDATE()) AS DayName;
	WITH cte_numbers(n, weekday) 
AS (
    SELECT 
        0, 
        DATENAME(DW, 0)
    UNION ALL
    SELECT    
        n + 1, 
        DATENAME(DW, n + 1)
    FROM    
        cte_numbers
    WHERE n <=5
)
SELECT 
    *
FROM 
    cte_numbers;

	/********************/

	-- Create a scalar function to calculate the sale amount of each product 
alter FUNCTION dbo.totalsaleamount (
    @OrderQty INT,
    @UnitPrice MONEY
)
RETURNS MONEY
AS
BEGIN
    DECLARE @toal_sale MONEY;

    -- Your logic for calculating extended amount goes here
    SET @toal_sale = @OrderQty * @UnitPrice 

    RETURN @toal_sale;
END;
GO

-- Use the function in the query to calculate total sales amount for each product
SELECT
    ProductID,
    SUM(dbo.totalsaleamount(OrderQty, UnitPrice)) AS TotalSalesAmount
FROM
   sales.SalesOrderDetail
GROUP BY
    ProductID;


/********** Create a table-valued function that takes a start date and an end date as parameters and 
returns a table of employees hired between those dates from the HumanResources.Employee table. 
Write a query using this function to retrieve the list of employees hired between '2010-01-01' and '2011-12-31'.   **********/

select * from HumanResources.Employee

create function employees_hiried(
		@startdate date,
		@enddate date )
returns table
as 
return 
select * from HumanResources.Employee where HireDate  between @startdate and @enddate
 
SELECT * FROM employees_hiried('2010-01-01', '2011-12-31');

