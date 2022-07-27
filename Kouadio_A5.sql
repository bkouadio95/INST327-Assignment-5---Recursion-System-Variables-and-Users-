USE ex;

/* ANSWER 1 */

WITH RECURSIVE management_cte AS (
   SELECT employee_id , CONCAT (first_name, ' ', last_name ) AS "employee_name",
		   department_number, manager_id
   FROM employees
   WHERE manager_id IS NULL
   UNION ALL
   SELECT e.employee_id, CONCAT (e.first_name, ' ', e.last_name) AS " enployee_name ",
           e.department_number, e.manager_id
   FROM employees AS e 
   INNER JOIN management_cte AS m
   ON m.employee_id = e.manager_id
   )
   
   
   SELECT m.employee_id, m.employee_name, d.department_name,
          CONCAT(e.first_name, ' ', e.last_name) AS manager_name
   FROM management_cte AS m 
   LEFT JOIN departments AS d
       USING (department_number)
       LEFT JOIN employees AS e
       ON m.manager_id = e.employee_id
    

/* ANSWER 2*/

/* Set safe updates to FALSE for the session.*/

SET SESSION sql_safe_updates = FALSE;

/* Set the maximum number of connections to 60 for the server*/
SET GLOBAL max_connections = 60;

/*Turn auto commit OFF for this session */
SET SESSION autocommit = OFF ;
/*Turn auto commit ON for this session */
SET SESSION autocommit = ON ;

/* Set the threshold for long running queries
 to 10 seconds for every session on the
server*/
SET SESSION long_query_time = 10;

/* Set the maximum depth for a recursion CTE to 300 for the current session*/
SET SESSION CTE_max_recursion_depth = 300;

/*Write the command(s) to show the value of
 the five variables you updated above.
*/
SELECT @@GLOBAL.sql_safe_updates;
SELECT @@GLOBAL.max_connections;
SELECT @@GLOBAL.autocommit;
SELECT @@GLOBAL.long_query_time;
SELECT @@GLOBAL.CTE_max_recursion_depth;
/*Write the commands to display all variables*/
SHOW VARIABLES LIKE "sql_safe_updates";
SHOW VARIABLES LIKE "max_connections";
SHOW VARIABLES LIKE "autocommit";
SHOW VARIABLES LIKE "long_query_time";
SHOW VARIABLES LIKE "CTE_max_recursion_depth";
SHOW VARIABLES ;

USE ex;

/*ANSWER 3 */
/*Users who must change their passwords every 60 days:*/
CREATE USER IF NOT EXISTS falcon@localhost IDENTIFIED BY "cap"
PASSWORD EXPIRE INTERVAL 60 DAY;
CREATE USER IF NOT EXISTS bucky_barnes@localhost IDENTIFIED BY "longing_rusted_seventeen"
PASSWORD EXPIRE INTERVAL 60 DAY;
CREATE USER IF NOT EXISTS john_walker@localhost IDENTIFIED BY "battlestar"
PASSWORD EXPIRE INTERVAL 60 DAY;
CREATE USER IF NOT EXISTS flag_smasher@localhost IDENTIFIED BY " Karli"
PASSWORD EXPIRE INTERVAL 60 DAY;

/* Rename user falcon to have username captain_america*/
RENAME USER falcon@localhost TO " captain_america ";

/* Change password for captain_america to be redwing */
ALTER USER captain_america IDENTIFIED BY " redwing ";

/* Drop user john_walker */
DROP USER john_walker@localhost;


    