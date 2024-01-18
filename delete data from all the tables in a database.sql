USE northwind_database
/****************************************diable constraints on all tables************************************/
DECLARE @disable NVARCHAR(MAX)

-- Disable Constraints
SELECT @disable = STRING_AGG(
    'ALTER TABLE ' + QUOTENAME(s.name) + '.' + QUOTENAME(t.name) + ' NOCHECK CONSTRAINT all',
    CHAR(13)
)
FROM sys.tables t
INNER JOIN sys.schemas s ON t.schema_id = s.schema_id
WHERE s.name = 'dbo' AND t.type = 'U'

--print @disable  -- Optional: Check the generated SQL
execute sp_executesql @disable  


go
/*********************************delete all the data in all the table of database *********************************/


DECLARE @sql NVARCHAR(MAX)

SELECT @sql = STRING_AGG(
						 'DELETE FROM ' + QUOTENAME(DB_NAME()) + '.' + QUOTENAME(s.name) + '.' + QUOTENAME(t.name),
						  CHAR(13)
)
FROM sys.tables t
INNER JOIN sys.schemas s ON t.schema_id = s.schema_id
WHERE s.name = 'dbo' AND t.type = 'U'

--PRINT @sql -- Optional: Check the generated SQL

EXEC sp_executesql @sql 
go


/****************************************enable constraints ********************************************************/
DECLARE @enable NVARCHAR(MAX)

-- Disable Constraints
SELECT @enable = STRING_AGG(
    'ALTER TABLE ' + QUOTENAME(s.name) + '.' + QUOTENAME(t.name) + ' WITH CHECK CHECK CONSTRAINT all',
    CHAR(13)
)
FROM sys.tables t
INNER JOIN sys.schemas s ON t.schema_id = s.schema_id
WHERE s.name = 'dbo' AND t.type = 'U'

--PRINT @enable  -- Optional: Check the generated SQL
execute sp_executesql @enable


	

