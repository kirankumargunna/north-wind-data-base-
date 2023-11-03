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
select @name as tableName 
 set @sql='select * from'+quotename( @name)
  exec sp_executesql @sql
  fetch next from c2 into @name 
 end 
 close c2
 deallocate c2*/


---------------------------------------------
