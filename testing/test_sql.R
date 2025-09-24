
# Server name: DataWrangling2025
# 
# Database Name     | DSN    | Schema
# ------------------------------------
# datawrangling_R   | DW_R   | dbo  (dbo.test_sql)
# datawrangling_SQL | DW_SQL | dbo
# ccs_applications  | DW_CCS | dbo


library(odbc)
library(DBI)

odbcListDataSources() # List out available DSN

stjude_conn <- dbConnect(odbc(), dsn = "DW_R")     # connection to datawrangling_R
# stjude_conn <- dbConnect(odbc(), dsn = "DW_SQL") # connection to datawrangling_SQL
# stjude_conn <- dbConnect(odbc(), dsn = "DW_CCS") # connection to ccs_applications

dbGetQuery(stjude_conn, "SELECT name FROM sys.databases;")

# After running line 20, you should see the expected output as below.
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

