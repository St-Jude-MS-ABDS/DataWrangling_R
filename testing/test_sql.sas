
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
After running proc sql above, you should see
"SQL test successful!" in OUTPUT DATA tab.
If you do not see the expected output, please email
yichen.chen@stjude.org with your a screenshot of LOG.
*/