"""
Write a solution to swap the seat id of every two consecutive students. If the number of students is odd, the id of the last student is not swapped.

Return the result table ordered by id in ascending order.
  
The result format is in the following example.
  
Input: 
Seat table:
+----+---------+
| id | student |
+----+---------+
| 1  | Abbot   |
| 2  | Doris   |
| 3  | Emerson |
| 4  | Green   |
| 5  | Jeames  |
+----+---------+
Output: 
+----+---------+
| id | student |
+----+---------+
| 1  | Doris   |
| 2  | Abbot   |
| 3  | Green   |
| 4  | Emerson |
| 5  | Jeames  |
+----+---------+
  
"""

# Write your MySQL query statement below

select 
    (
        case 
            when mod(id, 2) != 0 and cnt != id then id +1
            when mod(id, 2) != 0 and cnt = id then id
            else id-1
        end
    ) as id, student
from
    seat,
    (
        select 
            count(*) as cnt 
        from 
            Seat
    ) as seat_count
order by 
    id
