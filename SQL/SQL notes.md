# Basic SQL Tutorial

## Manipulating Tables:

SQL stands for Structured Query Language and is designed to manage data stored in Relational Databases (organizes information into 1+ tables).
Some common datatypes in SQL include INTEGER, TEXT, DATE, REAL, etc.

### Creating a table and inserting elements:

CREATE TABLE table_name (
  col_name1 TYPE,
  col_name2 TYPE,
  col_name3 TYPE
);

INSERT INTO table_name (col_name1, col_name2, col_name3) VALUES (val1, val2, val3);


SELECT is a clause used in SQL to fetch and view data from a database.

To view the row just made:
SELECT * FROM table_name;

To view specific column from table:
SELECT col_name1 FROM table_name;

Editing rows of a table:
UPDATE table_name SET col_name1 = val4 WHERE col_name2 = val1;


### Adding a new column to a table:

ALTER TABLE table_name ADD COLUMN col_name4 TEXT;

### Deleting elements:

DELETE FROM table_name WHERE col_name4 IS NULL;

A table can have constraints - must have a value. Example:
CREATE TABLE celebs (
   id INTEGER PRIMARY KEY,
   name TEXT UNIQUE,
   date_of_birth TEXT NOT NULL,
   date_of_death TEXT DEFAULT 'Not Applicable',
);

Primary key can be used to uniquely identify that row, attempts to insert row with duplicate primary key will be invalid.
Unique columns have different values for every row but unlike primary key, a table can have many different unique columns.
Not Null columns must have a value.
Default columns take an argument to allow assumed values for unspecified entries in new rows.


## Basic Queries

### SELECT:
As mentioned in the previous section, SELECT allows you to view information from a table.
SELECT * FROM table_name;

Using * allows you to grab everything from the table,

To select specific columns, you can list the column names you want:
SELECT col_name1, col_name2 FROM table_name;

### AS:
Sometimes you want to rename a column and refer to it using an alias.
It is important to remember that the columns have not been renamed in the table. The aliases only appear in the result.

SELECT col_name1 AS 'new_name' FROM table_name;


### DISTINCT:
Distinct filters out duplicate values in a column to return unique entries.
SELECT DISTINCT col_name1 FROM table_name;

### WHERE:
We can restrict our query results to display only what we want by setting constraints with WHERE.
SELECT * FROM table_name WHERE id < 5;

### LIKE:
We can use LIKE to compare similar values. Keep in mind LIKE is not case sensitive.
To search for a wildcard character we can use '_'
SELECT * FROM table_name WHERE col_name1 LIKE 'Desp_rate';

Another wildcard that can be used is % to match 0 or more missing letters in a pattern.
SELECT * FROM table_name WHERE name LIKE 'Asp%';

### COUNT:
We can count the number of entries that match a constraint we set.
SELECT COUNT(*) FROM table_name WHERE name LIKE 'Asp%';

### IS NULL:
Unknown values are indicated in SQL by NULL. We can't use = and != to test for NULL, we use IS NULL and IS NOT NULL.

Ex. Find all students in coop:
SELECT name FROM students WHERE coop IS NOT NULL;

### BETWEEN:
The BETWEEN operator can be used in a WHERE clause to filter the result set within a certain range.
The values can be numbers, text or dates.
This statement filters the result set to only include students with names that begin with letters 'A' up to, but not including 'J'.
SELECT * FROM students WHERE name BETWEEN 'A' AND 'J';
But this statement includes statements with numbers upto and including 5.
SELECT * FROM students WHERE id BETWEEN 1 and 5;

BETWEEN two letters is not inclusive of the 2nd letter but BETWEEN two numbers is inclusive of the 2nd number.

### AND/OR:
We can use the AND and OR operatora to make conditions in a WHERE clause more specific.
SELECT * FROM students WHERE start_year BETWEEN 1990 AND 1999 AND program = 'Math';
SELECT * FROM students WHERE start_year > 2014 or start_year < 1990;

### ORDER BY:
It is often useful to list the data in our result set in a particular order.
We can sort the results using ORDER BY, either alphabetically or numerically.
Sorting the results often makes the data more useful and easier to analyze.

SELECT * FROM students ORDER BY name;
SELECT * FROM students WHERE id > 8 ORDER BY start_year DESC;

### LIMIT:
Most SQL tables contain hundreds of thousands of records. In those situations, it becomes important to cap the number of rows in the result.
LIMIT is a clause that lets you specify the maximum number of rows the result set will have.
LIMIT always goes at the very end of the query. Also, it is not supported in all SQL databases.

Top 3 averages:
SELECT * FROM students ORDER BY average DESC LIMIT 3;

### CASE:
A CASE statement allows us to create different outputs (usually in the SELECT statement). It is SQL's way of handling if-then logic.

Each WHEN tests a condition and the following THEN gives us the string if the condition is true.
The ELSE gives us the string if all the above conditions are false.
The CASE statement must end with END.

SELECT name,
 CASE
  WHEN average < 40 THEN 'Bad'
  WHEN average < 70 THEN 'Poorly Received'
  ELSE 'Good average'
 END AS 'Grades'
FROM students;


## Aggregate Functions

Calculations performed on multiple rows of a table are called aggregates.

### COUNT()
Counts the number of non empty values in a column.
SELECT COUNT(*) FROM table_name;

### SUM()
Sums the values in a column.
SELECT SUM(books) FROM students;

### MAX/MIN()
Returns largest/smallest value .
SELECT MAX(average) FROM students;

### AVG()
Average of values in a column.
SELECT AVG(courses) FROM students;

### ROUND()
Round all values in a column, takes two parameters: column name and number of decimal places to round to.
SELECT name, ROUND(fees, 0) FROM students;
SELECT ROUND(AVG(fees), 2) FROM students;

### GROUB BY()
GROUP BY is a clause in SQL that is used with aggregate functions.
It is used in collaboration with the SELECT statement to arrange identical data into groups.
The GROUP BY statement comes after any WHERE statements, but before ORDER BY or LIMIT.
SELECT courses, COUNT(*) FROM students GROUP BY courses;

SELECT program,
   AVG(gpa)
FROM students
GROUP BY program
ORDER BY program;

SELECT program, SUM(fees) FROM students GROUP BY program;

Sometimes, we want to GROUP BY a calculation done on a column. We can refer to columns by numbers to make life easier.
The first column in our SELECT statement is 1, second is 2, so on.

SELECT program,
   fees,
   AVG(courses)
FROM students
GROUP BY 1, 2;

### HAVING()
SQL also allows you to filter which groups to include and which to exclude.
For instance, imagine that we want to see how many movies of different genres were produced each year,
but we only care about years and genres with at least 10 movies.
We can't use WHERE here because we don't want to filter the rows; we want to filter groups.
This is where HAVING comes in. HAVING is very similar to WHERE.
In fact, all types of WHERE clauses you learned about thus far can be used with HAVING.

When we want to limit the results of a query based on values of the individual rows, use WHERE.
When we want to limit the results of a query based on an aggregate property, use HAVING.
HAVING statement always comes after GROUP BY, but before ORDER BY and LIMIT.

SELECT program,
   ROUND(AVG(courses)),
   COUNT(*)
FROM students
GROUP BY program
HAVING COUNT(name) > 10;

The WHERE clause filters rows, whereas the HAVING clause filter groups.


## Multiple Tables
For efficient information storage, it is intuitive that with more data, we need more tables to organize it into.

### Combining tables with SQL:

The first line selects all columns from our combined table. If we only want to select certain columns, we can specify which ones we want.
The second line specifies the first table that we want to look in, orders
The third line uses JOIN to say that we want to combine information from orders with customers.
The fourth line tells us how to combine the two tables. We want to match orders table's customer_id column with customers table's customer_id column.
SELECT *
FROM orders
JOIN customers
  ON orders.customer_id = customers.customer_id;


If we only wanted to select orders table's order_id column and customers table's customer_name column, we could use the following query;
SELECT orders.order_id, customers.customer_name FROM orders JOIN customers ON orders.customer_id = customers.customer_id;

Join orders table and subscriptions table and select all columns. Make sure to join on the subscription_id column.
SELECT * FROM orders JOIN subscriptions ON orders.subscription_id = subscriptions.subscription_id;

Add a second query after your first one that only selects rows from the join where description is equal to 'Fashion Magazine'.
SELECT * FROM orders JOIN subscriptions ON orders.subscription_id = subscriptions.subscription_id WHERE description = 'Fashion Magazine';

### Inner Joins:

When we perform a simple JOIN (often called an inner join) our result only includes rows that match our ON condition.

### Left Joins:

What if we want to combine two tables and keep some of the un-matched rows?
SQL lets us do this through a command called LEFT JOIN.
A left join will keep all rows from the first table, regardless of whether there is a matching row in the second table.

The first line selects all columns from both tables.
The second line selects table1 (the "left" table).
The third line performs a LEFT JOIN on table2 (the "right" table).
The fourth line tells SQL how to perform the join (by looking for matching values in column c2).
SELECT * FROM table1 LEFT JOIN table2 ON table1.c2 = table2.c2;

### Primary Key vs. Foreign Key

Special/unique identifier columns are called primary keys. In our example, order_id, subscription_id, and customer_id are primary keys.
The few requirements of primary keys include:
- None of the values can be NULL.
- Each value must be unique.
- You can't have more than one primary key column in a table.

When a primary key for one table appears in another table, it's called a foreign key.
So customer_id is a primary key in customers but a foreign key in orders.

Suppose Columbia University has two tables in their database:
The classes table contains information on the classes that the school offers. Its primary key is id.
The students table contains information on all students in the school. Its primary key is id.
It contains the foreign key class_id, which corresponds to the primary key of classes.
Perform an inner join of classes and students using the primary and foreign keys described above, and select all the columns.
SELECT * FROM classes JOIN students ON classes.id = students.class_id;

### Cross Join:

So far, we've focused on matching rows that have some information in common.
Sometimes, we just want to combine all rows of one table with all rows of another table.
Notice that cross joins don't require an ON statement. You're not really joining on any columns!

For instance, if we had a table of shirts and a table of pants, we might want to know all the possible combinations to create different outfits.
SELECT shirts.shirt_color,
   pants.pants_color
FROM shirts
CROSS JOIN pants;

The first two lines select the columns shirt_color and pants_color.
The third line pulls data from the table shirts.
The fourth line performs a CROSS JOIN with pants.

### Union:

Sometimes we just want to stack one dataset on top of the other. Suppose we have two tables and they have the same columns.
SELECT * FROM table1 UNION SELECT * FROM table2;

SQL has strict rules for appending data:
Tables must have the same number of columns.
The columns must have the same data types in the same order as the first table.


### With:

Often times, we want to combine two tables, but one of the tables is the result of another calculation.

Let's return to our magazine order example. Our marketing department might want to know a bit more about our customers.
For instance, they might want to know how many magazines each customer subscribes to. We can easily calculate this using our orders table:
SELECT customer_id,
   COUNT(subscription_id) AS 'subscriptions'
FROM orders
GROUP BY customer_id;

his query is good, but a customer_id isn't terribly useful for our marketing department, they probably want to know the customer's name.

We want to be able to join the results of this query with our customers table, which will tell us the name of each customer.
We can do this by using a WITH clause.

WITH previous_results AS (
   SELECT ...
   ...
   ...
   ...
)
SELECT *
FROM previous_results
JOIN customers
  ON _____ = _____;


The WITH statement allows us to perform a separate query (such as aggregating customer's subscriptions)
previous_results is the alias that we will use to reference any columns from the query inside of the WITH clause
We can then go on to do whatever we want with this temporary table (such as join the temporary table with another table)
Essentially, we are putting a whole first query inside the parentheses () and giving it a name.
After that, we can use this name as if it's a table and write a new query using the first query.

WITH previous_query AS (
	SELECT customer_id,
  COUNT(subscription_id) AS 'subscriptions'
  FROM orders GROUP BY customer_id
)

SELECT customers.customer_name, previous_query.subscriptions
FROM previous_query JOIN customers ON previous_query.customer_id = customers.customer_id;
