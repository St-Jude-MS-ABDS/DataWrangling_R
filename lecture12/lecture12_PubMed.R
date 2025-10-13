library(rentrez)
library(httr)
library(jsonlite)

workpath <- "C:/Users/ychen3/OneDrive - St. Jude Children's Research Hospital/GPM/DataWrangling_R/_dev/"
setwd(workpath)

#### einfo

# rentrez package 
rentrez::entrez_info() # list all NCBI database
rentrez::entrez_dbs() # list all NCBI database
rentrez::entrez_db_summary(db="pubmed")
rentrez::entrez_db_summary(db="genome")

# Entrez API Request to get list of NCBI database
args <- list(retmode="json", usehistory=T)
response <- httr::GET("https://eutils.ncbi.nlm.nih.gov/entrez/eutils/einfo.fcgi?", 
                      query = args, config = NULL) 
response_content <- httr::content(response, as="text", encoding="UTF-8")
jfile <- jsonlite::fromJSON(response_content)
jfile$einforesult$dblist


#### esearch

# entrez query
entrez_query <- '(((childrens oncology group[Title]) AND (english[Language])) AND (journal article[Publication Type])) AND (("2000"[Date - Publication] : "2020"[Date - Publication]))'

# rentrez package 
d_search <- rentrez::entrez_search(db = "pubmed", term = entrez_query, retmax=20)
d_search$count
d_search$ids

# Entrez API Request
args <- list(db = "pubmed", term=entrez_query, config=NULL, retmode="json", usehistory=T, retmax=20)
response <- httr::GET("https://eutils.ncbi.nlm.nih.gov/entrez/eutils/esearch.fcgi?", query=args, config= NULL) 
response_content <- httr::content(response, as="text", encoding="UTF-8")
jfile <- jsonlite::fromJSON(response_content)
jfile$esearchresult$count # total number of results
jfile$esearchresult$idlist # length of idlist depends on retmax value

#### ESummary: Returns document summaries (DocSums) for a list of input UIDs

# rentrez package 
d_summary <- rentrez::entrez_summary(db="pubmed", id=d_search$ids)
names(d_summary$`33488267`)
d_summary$`33488267`$title
d_summary$`33488267`$authors
d_summary$`33488267`$lang
d_summary$`33488267`$fulljournalname
d_summary$`33488267`$history
d_summary$`33488267`$articleids

d_summary.DF <- data.frame(pubmed_id = sapply(d_summary, function(x) {df<-x[["articleids"]]; df$value[df$idtype=="pubmed"]} ),
                           title = sapply(d_summary, function(x) x[["title"]]),
                           authors = sapply(d_summary, function(x) paste(x[["authors"]][,"name"], collapse = ", ")),
                           lang = sapply(d_summary, function(x) x[["lang"]]),
                           fulljournalname = sapply(d_summary, function(x) x[["fulljournalname"]]),
                           doi = unlist(sapply(d_summary, function(x) {df<-x[["articleids"]]; ifelse("doi"%in%df$idtype, df$value[df$idtype=="doi"], "")}))
)


#### efetch 
# Returns formatted data records for a list of input UIDs

d_summary.DF$abstract <- NA_character_

for(i in 1:nrow(d_summary.DF))
{
  d_summary.DF$abstract[i] <- rentrez::entrez_fetch(db="pubmed", id=d_summary.DF$pubmed_id[i], rettype="abstract", retmode="text")
  cat(i,"out of",nrow(d_summary.DF),"abstract is added \n")
}

