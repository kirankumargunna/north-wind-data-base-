--Q.1

SELECT COUNT(DISTINCT companyname) AS total_customers FROM customers
SELECT COUNT(*) FROM customers

--Q.2
SELECT companyname FROM customers WHERE CompanyName LIKE 'b%'

--Q.3

SELECT companyname FROM customers WHERE CompanyName   LIKE '%s%'

--Q.4

SELECT city,
	   COUNT(customerid) AS noOfCustomers
	   FROM customers
	   GROUP BY city 
	   ORDER BY noOfCustomers 

--Q.5

SELECT	TOP 3  city,
	   COUNT(customerid) AS noOfCustomers
	   FROM customers
	   GROUP BY city 
	   ORDER BY noOfCustomers DESC
	       --or---

 with cte AS 
(SELECT city,
	   COUNT(customerid) AS noOfCustomers,
	   ROW_NUMBER() OVER (ORDER BY  COUNT(customerid) DESC) AS rownumber
	   FROM customers
	   GROUP BY city )

	   SELECT city, noOfCustomers FROM cte WHERE rownumber<4

--Q.6

WITH cte AS 
( SELECT  c.CustomerID,
	 CompanyName,
	 ContactName,
	 COUNT(orderid ) AS totalOrders,
	 ROW_NUMBER() OVER (ORDER BY  COUNT(orderid ) DESC) AS rownum FROM [dbo].[Customers] c
 JOIN orders o  ON  c.CustomerID=o.CustomerID
 GROUP BY c.CustomerID,CompanyName,ContactName)
 
 SELECT CustomerID,
	 CompanyName,
	 ContactName
FROM cte WHERE rownum=1 


--Q.7


WITH cte AS 
( SELECT  c.CustomerID,
	 CompanyName,
	 ContactName,orderdate,
	 COUNT(orderid ) AS totalOrders,
	 ROW_NUMBER() OVER (ORDER BY  COUNT(orderid ) DESC) AS rownum FROM [dbo].[Customers] c
 JOIN orders o  ON  c.CustomerID=o.CustomerID
 GROUP BY c.CustomerID,CompanyName,ContactName,orderdate)
 
	SELECT CustomerID,
		   CompanyName
	FROM cte WHERE rownum=1 and  orderdate LIKE '%1997%'


--Q.8

SELECT top 3 country,
		COUNT(orderid) noOfOrders
FROM customers c 
JOIN orders o ON  c.CustomerID=o.CustomerID
GROUP BY country
ORDER BY noOfOrders DESC

--Q.9

SELECT  top 1 companyname AS shippername ,
		COUNT(o.ShipVia) totalShipments 
FROM shippers s
JOIN orders o ON  s.ShipperID=o.ShipVia
GROUP BY CompanyName

--Q.11

SELECT lastname FROM employees
WHERE DATEPART(MONTH,birthdate)=09

--Q.12
SELECT 
	firstname, 
	lAStname, 
	territoryDESCription AS territory 
FROM employees e
JOIN EmployeeTerritories et ON  e.EmployeeID=et.EmployeeID
JOIN Territories t ON  et.TerritoryID=t.TerritoryID
GROUP BY Territorydescription,lastName,FirstName


--Q.13

with cte AS (
SELECT 
	od.productid,
	sum(od.UnitPrice*od.Quantity) AS saleamount,
	productname 
FROM [Order Details] od 
JOIN Products p ON  od.ProductID= p.ProductID 
GROUP BY od.ProductID,ProductName
)

SELECT  productname AS topsaleproduct FROM cte WHERE saleamount=(SELECT max(saleamount) FROM cte)

--Q.14

SELECT 
	p.productname,
	o.unitprice*o.Quantity AS saleamount,
	COUNT(o.OrderID) AS totalOrders
FROM products p
JOIN [Order Details] o ON  p.ProductID=o.ProductID
WHERE o.unitprice*o.Quantity =(SELECT min (unitprice*Quantity) FROM [Order Details]) 
GROUP BY ProductName,o.unitprice*o.Quantity
having COUNT(o.OrderID)<=1

--Q.15
	SELECT top 1 MONTH AS BestMonthForSale FROM(SELECT 
		datename(MONTH,o.orderDate) AS [month],
		sum(od.unitprice*od.Quantity) AS totalSale
		FROM orders o 
		JOIN [Order Details] od ON  o.OrderID=od.OrderID
		GROUP BY DATENAME(MONTH,o.orderDate)
		) totalsalebymonth
		ORDER BY totalSale DESC
		
--q.16
	SELECT 
		TOP 1 CONCAT(FirstName,LAStName)AS full_name,
		od.UnitPrice*od.Quantity AS total_sale ,
		COUNT(o.orderid)AS total_orders
	FROM employees e 
	JOIN orders o ON  e.EmployeeID=o.EmployeeID
	JOIN [Order Details] od ON  o.OrderID=od.OrderID
	GROUP BY 
		CONCAT (FirstName,lastname),od.UnitPrice*od.Quantity
	ORDER BY
		od.UnitPrice*od.Quantity DESC 

--Q.17
	SELECT 
		region AS sales_region, 
		COUNT(employeeid)AS noOfEmployees 
	FROM employees 
	GROUP BY region 
	ORDER BY COUNT(employeeid) DESC

	--Q.18

