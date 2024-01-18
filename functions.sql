----functions 
---data and time functions 

select CURRENT_TIMESTAMP
select GETDATE()
select orderdate from orders
select DATEADD(month,3,OrderDate) from Orders
select Datediff(year,orderdate,GETDATE()) from Orders
select datename(month,orderdate)from orders
select datename(month,getdate())
select DATEPART(month,getdate())
select DATEPART(day,orderdate) from orders
select day(getdate())
select isdate(orderdate) from orders
select isdate('01/18/2024')
SELECT QUOTENAME('abcdef')
SELECT STUFF('SQL Tutorial', 1, 3, 'HTML')
select trim ('            dlfkjdsf            ')
SELECT CAST(25.65 AS int);
SELECT CAST(25.65 AS varchar);
select db_name()
select Soundex('abcd')
select Soundex('kiran')