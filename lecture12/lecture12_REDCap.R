library(httr)

workpath <- "C:/Users/ychen3/OneDrive - St. Jude Children's Research Hospital/GPM/DataWrangling_R/_dev/"
setwd(workpath)

#### Functions

GetAPIToken <- function(database="RCC", studyname)
{
  #Function to get API Token from your SJ Onedrive .apitoken folder
  username <- Sys.getenv("USERNAME")
  path <- paste0("C:/Users/",username,"/OneDrive - St. Jude Children's Research Hospital/.apitoken/")
  loc <- grepl(studyname, list.files(path), fixed = T)
  
  if(sum(loc) == 0) stop(paste("Cannot find API token for study", studyname, "in", database, "database"))
  
  if(sum(loc) > 1) stop(paste("Multiple API tokens have been located, please double check the studyname!"))
  
  if(sum(loc) == 1){
    dat <- read.table(paste0(path,list.files(path)[loc]), header = F)
    if((dat[1,1]==database) == F) stop("Database name in the Token file mismatched with the database name specified by user.")
    if((dat[1,1]==database) == T) return(dat[1,2])
  }
}


###### Get Numeric and labelled Data from EVAT2 Project

redcap_uri <- "https://redcap.stjude.org/api/" # REDCap API HTTP URL

token_evat2 <- GetAPIToken(database="REDCap", studyname="EVAT2") # # API Token
token <- token_evat2 

# List of API Request Parameters

formData_num <- list("token"=token,
                     content='record',
                     action='export',
                     format='csv',
                     type='flat',
                     csvDelimiter='',
                     rawOrLabel='raw', # ='label' for labelled data = 'raw' for numeric data
                     rawOrLabelHeaders='raw',
                     exportCheckboxLabel='false',
                     exportSurveyFields='false',
                     exportDataAccessGroups='false',
                     returnFormat='json'
)

formData_char <- list("token"=token,
                      content='record',
                      action='export',
                      format='csv',
                      type='flat',
                      csvDelimiter='',
                      rawOrLabel='label', # ='label' for labelled data = 'raw' for numeric data
                      rawOrLabelHeaders='raw',
                      exportCheckboxLabel='false',
                      exportSurveyFields='false',
                      exportDataAccessGroups='false',
                      returnFormat='json'
)

# POST Method to export records from
response_num <- httr::POST(redcap_uri, body = formData_num, encode = "form")
content_num <- httr::content(response_num)
evat2_num_raw <- content_num

response_char <- httr::POST(redcap_uri, body = formData_char, encode = "form")
content_char <- httr::content(response_char)
evat2_char_raw <- content_char
