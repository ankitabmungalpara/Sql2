"""
Each node in the tree can be one of three types:

"Leaf": if the node is a leaf node.
"Root": if the node is the root of the tree.
"Inner": If the node is neither a leaf node nor a root node.
Write a solution to report the type of each node in the tree.

Return the result table in any order.

The result format is in the following example.

Input: 
Tree table:
+----+------+
| id | p_id |
+----+------+
| 1  | null |
| 2  | 1    |
| 3  | 1    |
| 4  | 2    |
| 5  | 2    |
+----+------+
Output: 
+----+-------+
| id | type  |
+----+-------+
| 1  | Root  |
| 2  | Inner |
| 3  | Leaf  |
| 4  | Leaf  |
| 5  | Leaf  |
+----+-------+

"""

-- method 1: using CASE 
select 
    t.id,
    case
        when t.id = (select t1.id from tree t1 where t1.p_id is null) then 'Root'
        when t.id in (select t1.p_id from tree t1) then 'Inner'
        else 'Leaf'
    end as type
from 
    tree t
order by 
    t.id

-- method 2 : using IF
select 
    t.id,
    if(isnull(t.p_id ), 
        'Root', 
        if(t.id in (select p_id from tree ), 'Inner', 'Leaf')
    ) as type
from 
    tree t
order by 
    t.id
