"""
A company's executives are interested in seeing who earns the most money in each of the company's departments. 
A high earner in a department is an employee who has a salary in the top three unique salaries for that department.

Write a solution to find the employees who are high earners in each of the departments.

Return the result table in any order.

The result format is in the following example.

Input: 
Employee table:
+----+-------+--------+--------------+
| id | name  | salary | departmentId |
+----+-------+--------+--------------+
| 1  | Joe   | 85000  | 1            |
| 2  | Henry | 80000  | 2            |
| 3  | Sam   | 60000  | 2            |
| 4  | Max   | 90000  | 1            |
| 5  | Janet | 69000  | 1            |
| 6  | Randy | 85000  | 1            |
| 7  | Will  | 70000  | 1            |
+----+-------+--------+--------------+
Department table:
+----+-------+
| id | name  |
+----+-------+
| 1  | IT    |
| 2  | Sales |
+----+-------+
Output: 
+------------+----------+--------+
| Department | Employee | Salary |
+------------+----------+--------+
| IT         | Max      | 90000  |
| IT         | Joe      | 85000  |
| IT         | Randy    | 85000  |
| IT         | Will     | 70000  |
| Sales      | Henry    | 80000  |
| Sales      | Sam      | 60000  |
+------------+----------+--------+

"""

-- method 1 : correlated subquery
select 
    d.name as Department, 
    e.name as Employee, 
    e.salary as Salary 
from 
    Employee e join Department d 
on 
    e.departmentId = d.id 
where 
    3 > (
            select 
                count(distinct e2.salary) 
            from 
                employee e2 
            where 
                e2.salary > e.salary and e.departmentId = e2.departmentId
        )

  
-- method 2: dense_rank()
with cte as 
(
    select 
        d.id,
        d.name as Department, 
        e.name as Employee, 
        e.salary as Salary,
        dense_rank() over(partition by d.id order by e.salary desc) as rnk
    from 
        Employee e join Department d 
    on 
        e.departmentId = d.id 
)

select Department, Employee, Salary from cte where rnk < 4
