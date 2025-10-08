

library(haven)
library(DBI)
library(odbc)


workpath <- "C:/Users/ychen3/OneDrive - St. Jude Children's Research Hospital/GPM/DataWrangling_R//"
setwd(workpath)

###### Read CSV file

datacsv <- read.csv("_dev/datawrangling_R_lecture5.csv")

datacsv <- read.csv("_dev/datawrangling_R_lecture5.csv", skip=2) # start reading from row #3
colnames(datacsv)

datacsv <- read.csv("_dev/datawrangling_R_lecture5.csv", skip=2, check.names = F) # use origin column names without checking by R
colnames(datacsv)
sapply(datacsv, class)

datacsv <- read.csv("_dev/datawrangling_R_lecture5.csv", skip=2, check.names = F, na.strings = ".") # cells with "." are missing 
sapply(datacsv, class)

datacsv <- datacsv[,-1] # remove the first column
colnames(datacsv)

###### Read SAS file

datasas <- haven::read_sas("_dev/datawrangling_R_lecture5.sas7bdat")
colnames(datasas)
sapply(datasas, attr, "label")

###### save R data
save.image(file = "_dev/ws_all.RData")
save(list = c("datacsv","datasas"), file="_dev/ws.RData")

###### load R data into global env
rm(list = ls())
workpath <- "C:/Users/ychen3/OneDrive - St. Jude Children's Research Hospital/GPM/DataWrangling_R//"
setwd(workpath)
load("_dev/ws.RData")

###### create a new env and load R data into it
rm(list = ls())
workpath <- "C:/Users/ychen3/OneDrive - St. Jude Children's Research Hospital/GPM/DataWrangling_R//"
setwd(workpath)
myenv <- new.env()
load("_dev/ws.RData", envir = myenv)
names(myenv)
data1 <- myenv[["datacsv"]]
