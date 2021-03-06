

CREATE TABLE count_employees AS
SELECT employee_name, employee_sal,
sum(case when emp_points = 1 then 1 else 0 end) as emp_bonus
FROM
payroll_chart
GROUP BY employee_name, employee_dept;


CREATE TABLE filt_emp AS
SELECT
*
FROM
count_employees
WHERE employee_dept = "marketing"
AND emp_bonus > 0;

/* show a few -25- rows */
SELECT
*
FROM
filt_emp
WHERE
employee_manager = "Carol Jis"
limit 25;

/* aggregates */

SELECT
COUNT(DISTINCT employee_dept)
FROM
filt_emp


/* when using SQL with Hive don't forget databases have built in functions */

select
lpad(cast(cast(account as BIGINT) % 5000 as STRING), 9 '0')  
from 
customers 
group by account, inter_date
limit 100
