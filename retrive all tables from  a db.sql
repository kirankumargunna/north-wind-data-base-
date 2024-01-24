	 ---retrive data from all the tables in a database at a time
 
 use northwind_database   ---repalce ab with preferred database 
 
 ----approach 1

 IF OBJECT_ID('tempdb..#tmp12') IS NOT NULL
    DROP TABLE #tmp12

create table #tmp12(tablename nvarchar(333))
insert into #tmp12 select name from sys.tables

	declare @row int
	declare @tablename varchar(300)
	declare @sql nvarchar(max) 
select @row=count(*) from #tmp12
select * from #tmp12

while @row >=1
begin 
SELECT TOP 1 * FROM #tmp12
select top 1 @tablename=  tablename from #tmp12
  set @sql='select * from'+quotename( @tablename)
  exec sp_executesql @sql
  delete top (1) from #tmp12
  select @row=count(*) from #tmp12

end



----------appraoch  2

/*declare  c2 cursor  for select [name] from sys.tables

open c2
declare @name nvarchar(225)
declare @sql nvarchar(max) 
fetch next from c2 into @name 
while @@FETCH_STATUS=0
begin 
 set @sql='select * from'+quotename( @name)
 -- exec sp_executesql @sql
 print @sql
  fetch next from c2 into @name 
 end 
 close c2
 deallocate c2*/


---------------------------------------------
/***********approach3**********


declare cur cursor for select TABLE_SCHEMA+'.'+TABLE_NAME as tablename from INFORMATION_SCHEMA.tables  
												where table_type='base table' order by TABLE_SCHEMA

open cur
declare @name varchar(333)
		,@sql nvarchar(max)
		,@sql1 nvarchar(max)

fetch next from cur into @name
while @@FETCH_STATUS=0
begin
SET @sql = 'SELECT TOP 1 * FROM ' +   REPLACE(REPLACE(QUOTENAME(@name), '[', ''), ']', '')
set @sql1='select * from '+  REPLACE(REPLACE(QUOTENAME(@name), '[', ''), ']', '')
print @sql1

--exec sp_executesql @sql
--exec sp_executesql @@sql1
fetch next from cur into @name
end 

close cur

deallocate cur
*****************************/+
