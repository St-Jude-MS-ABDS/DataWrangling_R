

library(googledrive)
library(googlesheets4)

workpath <- "C:/Users/ychen3/OneDrive - St. Jude Children's Research Hospital/GPM/DataWrangling_R/_dev/"
setwd(workpath)

# url for the google sheet 
url <- "https://docs.google.com/spreadsheets/d/1kez-6oyKECIMJAWPiAhDLiWz2RUK1TdWXPX_Mg6081A/edit?gid=0#gid=0"

response_raw <- googlesheets4::read_sheet(url)

######################################################################
# First time run, you will be asked for permission from Tidyverse API
######################################################################
# Is it OK to cache OAuth
# access credentials in the
# folder
# C:/Users/ychen3/AppData/Local/gargle/gargle/Cache
# between R sessions?
# 1: Yes
# 2: No

####
# Enter 1 for Yes
####

# Selection: Yes
# Enter a number between 1 and
# 2, or enter 0 to exit.

####
# Enter 1 again
####

# Selection: 1
# Waiting for authentication in browser...
# Press Esc/Ctrl + C to abort
# Authentication complete.
# ✔ Reading from lecture12.
# ✔ Range Sheet1.
