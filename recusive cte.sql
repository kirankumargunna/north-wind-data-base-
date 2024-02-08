select * from employee1
select * from department1


-- Recursive CTE to retrieve the reporting hierarchy
WITH ReportingHierarchy AS (
    SELECT 
        EmployeeID,
        EmployeeName,
        ManagerID,
        0 AS Level
    FROM 
        Employee1
    WHERE 
        ManagerID IS NULL
    UNION ALL
    SELECT 
        e.EmployeeID,
        e.EmployeeName,
        e.ManagerID,
        rh.Level + 1
    FROM 
        Employee1 e
    INNER JOIN 
        ReportingHierarchy rh ON e.ManagerID = rh.EmployeeID
)
SELECT 
    EmployeeID,
    EmployeeName,
    ManagerID,
    Level
FROM 
    ReportingHierarchy
ORDER BY 
    Level, EmployeeID;
