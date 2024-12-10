"""
Write a solution to find the rank of the scores. The ranking should be calculated according to the following rules:

The scores should be ranked from the highest to the lowest.
If there is a tie between two scores, both should have the same ranking.
After a tie, the next ranking number should be the next consecutive integer value. In other words, there should be no holes between ranks.
Return the result table ordered by score in descending order.

The result format is in the following example.

Input: 
Scores table:
+----+-------+
| id | score |
+----+-------+
| 1  | 3.50  |
| 2  | 3.65  |
| 3  | 4.00  |
| 4  | 3.85  |
| 5  | 4.00  |
| 6  | 3.65  |
+----+-------+
    
Output: 
+-------+------+
| score | rank |
+-------+------+
| 4.00  | 1    |
| 4.00  | 1    |
| 3.85  | 2    |
| 3.65  | 3    |
| 3.65  | 3    |
| 3.50  | 4    |
+-------+------+
"""

# method 1 : using WINDOW function
select 
    score, dense_rank() over(order by score desc) as 'rank'
from 
    Scores 
order by score desc;


# method 2 : using subquery
select 
    s1.score,
    (
        select 
            count(distinct s2.score) 
        from 
            Scores s2 
        where 
            s2.score>=s1.score) as 'rank'
from 
    Scores s1 
order by
    s1.score desc
