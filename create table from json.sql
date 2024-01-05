
/*************************convert json to table *************************************/


declare @json_data varchar(max) 

select @json_data = BulkColumn 
from openrowset 
(
 BULK 'C:\New folder\example2.json', SINGLE_CLOB
) as datasource

--print @json_data

select * into emp  
from openjson (@json_data)
WITH
(
 id int, 
 name varchar(20), 
 dept varchar(20), 
 salary int 
)
select * from emp 

