/****************** triggers *****************************/

--create database triggers 

--use triggers

-- Create Employee table
CREATE TABLE Employee
(
  Id int Primary Key,
  Name nvarchar(30),
  Salary int,
  Gender nvarchar(10),
  DepartmentId int
)
GO

-- Insert data into Employee table
INSERT INTO Employee VALUES (1,'Pranaya', 5000, 'Male', 3)
INSERT INTO Employee VALUES (2,'Priyanka', 5400, 'Female', 2)
INSERT INTO Employee VALUES (3,'Anurag', 6500, 'male', 1)
INSERT INTO Employee VALUES (4,'sambit', 4700, 'Male', 2)
INSERT INTO Employee VALUES (5,'Hina', 6600, 'Female', 3)


select * from employee
--------------create trigger for insert  

create trigger insertemployee
on employee 
for insert 
as 
begin 
print' permission denied for insert '
rollback transaction 
end 

insert into employee values (6,'kiran',52502,'male',7)

--------------create trigger for update 

create trigger updateemployee
on employee 
for update  
as 
begin 
print' permission denied for update  '
rollback transaction 
end 

update employee
set DepartmentId =3 

alter  trigger dmlemployee
on employee 
for insert,update,delete 
as 
begin 
 if DATEPART(HH,getdate())>=6 and DATEPART(HH,getdate())<=18
  begin
   print ' at the current time you cannot perform any transactions  '
   rollback transaction 
 end 
end

-- Create or alter the trigger
CREATE OR ALTER TRIGGER dmlemployee
ON employee
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    IF (DATEPART(HOUR, GETDATE()) BETWEEN 18 AND 24 or DATEPART(HOUR, GETDATE()) between 1 and 6)
    BEGIN
        RAISERROR ('At the current time, you cannot perform any transactions.', 16, 1)
        ROLLBACK TRANSACTION
    END
END

	delete from employee

	-----enable and disable triggers

	disable trigger insertemployee on employee
	disable trigger dmlemployee on employee

	enable trigger insertemployee on employee
	enable trigger dmlemployee on employee 
	
	-- Insert data into Employee table
INSERT INTO Employee VALUES (1,'Pranaya', 5000, 'Male', 3)
INSERT INTO Employee VALUES (2,'Priyanka', 5400, 'Female', 2)
INSERT INTO Employee VALUES (3,'Anurag', 6500, 'male', 1)
INSERT INTO Employee VALUES (4,'sambit', 4700, 'Male', 2)
INSERT INTO Employee VALUES (5,'Hina', 6600, 'Female', 3)


