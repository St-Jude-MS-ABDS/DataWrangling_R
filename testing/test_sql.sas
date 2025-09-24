/*
Server name: DataWrangling2025

Database Name     | DSN    | Schema
------------------------------------
datawrangling_R   | DW_R   | dbo  (dbo.test_sql)
datawrangling_SQL | DW_SQL | dbo
ccs_applications  | DW_CCS | dbo
*/

/* Method 1 - Get test_sql through DSN */

LIBNAME mylib ODBC DSN=DW_R schema=dbo;
PROC DATASETS LIBRARY=mylib; RUN; * list data sets in mylib ;
DATA test_sql; SET mylib.test_sql; RUN;

/* Method 2 - Get test_sql through proc sql using database name */

proc sql;
connect to SQLSERVR as stjude_conn (SERVER = DataWrangling2025 DATABASE = datawrangling_R);
create table test_sql as 
select * 
from connection to stjude_conn
(
  select * from dbo.test_sql;
);
disconnect from stjude_conn;
quit;

/*
After running DATA step (line 17) or proc sql (line 20-29) above, you should see
"SQL test successful!" in OUTPUT DATA tab.
If you do not see the expected output, please email
yichen.chen@stjude.org with your a screenshot of LOG.
*/