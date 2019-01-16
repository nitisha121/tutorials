Different types of joins:

/* A left join keeps all rows from the left table and adds the rows in the right table that have a matching entry for the specified key(s) */
select
*
from table1 a
left join table2 b
on a.key = b.key

/* This left join keeps rows from the left table, that DON'T have a matching entry for the specified key(s) in the right table */
select
*
from table1 a
left join table2 b
on a.key = b.key
where b.key is null

/* A right join keeps all rows from the right table and adds the rows in the leftt table that have a matching entry for the specified key(s)*/
select
*
from table2 b
left join table1 a
on b.key = a.key

/* This right join keeps rows from the right table, that DON'T have a matching entry for the specified key(s) in the left table */
select
*
from table2 b
left join table1 a
on b.key = a.key
where a.key is null

/* An inner join keeps only the rows that have an entry for the specified key(s) in BOTH the right and the left tables. */
select
*
from table1 a
inner join table2 b
on a.key = b.key

/* A full outer join keeps all entries in both tables, joining where keys match */
select
*
from table1 a
full outer join table2 b
on a.key = b.key

/* A full outer join without the intersection, i.e. keeps all rows that have a key for the left table AND the right table */
select
*
from table1 a
full outer join table2 b
on a.key = b.key
where a.key is null or b.key is null


/* A cross join creates new rows that match all rows of the left table with all rows of the left table */
select
*
from table1 a
cross join table2 b
