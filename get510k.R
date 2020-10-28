#load package
library(readr)
library(dplyr)
library(stringr)
library(utils)

#read data for each file
pmn96cur <- read_delim("510K/pmn96cur.txt", "|", escape_double = FALSE, trim_ws = TRUE)
pmn9195 <- read_delim("510K/pmn9195.txt", "|", escape_double = FALSE, trim_ws = TRUE)
pmn8690 <- read_delim("510K/pmn8690.txt", "|", escape_double = FALSE, trim_ws = TRUE)
pmn8185 <- read_delim("510K/pmn8185.txt", "|", escape_double = FALSE, trim_ws = TRUE)
pmn7680 <- read_delim("510K/pmn7680.txt", "|", escape_double = FALSE, trim_ws = TRUE)

#Combine all 510K FDA submissions from 1976-current
all <- rbind(pmn96cur, pmn9195, pmn8690, pmn8185, pmn7680 )

# Filter for Glucose submission only
sub <- all %>% filter(stringr::str_detect(DEVICENAME, 'Glucose') ) %>% select(KNUMBER,DATERECEIVED) %>% 
           mutate(y = substr(DATERECEIVED,9,11)) %>% mutate(yy= stringr::str_remove(y, "^0+")) %>% 
           select(KNUMBER, yy)
  
#code to filter Abbott submission
#filter(APPLICANT = grepl('abbott))




# apply([, c("kunumber","y")], 1, 
#       function(ind) {summary(lm(mpg ~ ind, data = mtcars))} )

for p in 1:length(sub)){
  i <- 1
  k <- sub[i,1]
  year <-  sub[i,2]
  
  path <- paste0("https://www.accessdata.fda.gov/cdrh_docs/pdf",year,"/",k,".pdf")
  output <- paste0(k,".pdf")
  download.file(path, output)
  
}



download.file("https://www.accessdata.fda.gov/cdrh_docs/pdf9/K092602.pdf", "K092602.pdf")

?toupper

