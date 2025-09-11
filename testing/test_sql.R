
library(odbc)
library(DBI)

stjude_conn <- dbConnect(odbc(),
                         Driver = "ODBC Driver 17 for SQL Server",
                         Server = "DataWrangling2025",
                         Database = "datawrangling_R",
                         uid = "datawrangling2025",
                         pwd = "l!XvQ8K$bvltOqwNUTq9qd2f0",
                         #Port = "1433",
                         #MARS_Connection="yes"
                         )

dbGetQuery(stjude_conn, "SELECT name FROM sys.databases;")

# After running line 15, you should see the expected output as below.
# If you see errors or outputs other than the expected output, 
# please email Yichen.chen@stjude.org with your screenshot.
####################################################################
# Expected output after running line 15:
#                name
# 1            master
# 2            tempdb
# 3             model
# 4              msdb
# 5   datawrangling_R
# 6 datawrangling_SQL
# 7  ccs_applications

dbDisconnect(stjude_conn)
