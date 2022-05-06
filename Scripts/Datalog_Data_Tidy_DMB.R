# Reorganizing the Raw Apex data files for readability and plotting
# The following script will produce/update one (or an optional second) dataframe(s): one only containing temperature and pH data from each mesocosm tank, and one optional containing all logged Apex data

# written by Danielle Barnas
# created 1/03/2019
# last updated 5/06/2020

########################
# Load Libraries
########################

library(tidyverse)
library(here)


########################
# File Names
########################

file.path <- "Data/Apex_DataLogs/202205"
output.path <- "Data/Apex_DataLogs/202205/QC_files"
file.date <- "202205" # logger date 

#################################################################################
# DO NOT CHANGE ANYTHING BELOW HERE ----------------------------------
#################################################################################

########################
# Read in Data
########################

file.names<-basename(list.files(file.path, pattern = "csv$", recursive = F)) #list all csv file names in the folder and subfolders

data <- file.names %>%
  purrr::map_dfr(~ readr::read_csv(file.path(file.path, .), skip = 6, col_names = F)) # read all csv files at the file path, skipping 1 line of metadata and bind together


########################
# Tidy dataframe
########################

# Splits data into separate columns
dataLog <- data %>% 
  separate("X1", into=c("Date",NA), sep="</date>", remove=TRUE) %>%  # Removes </date>
  separate("Date", into=c("Date",NA), sep="<probe>", remove=TRUE) %>%  # Removes <probe>
  separate("Date", into=c("Date",NA), sep="</record>", remove=TRUE) %>%  # Removes second to last row </record>
  separate("Date", into=c("Date",NA), sep="</datalog>", remove=TRUE) %>%  # Removes last row </datalog>
  separate("Date", into=c("Date","Probe"), sep="<name>", remove=TRUE) %>%  # Date/Time become a new second column separete from other data
  separate("Probe",into=c("Probe","Type"), sep="</name> <type>",remove=TRUE) %>%  # Splits probe name from other probe data
  separate("Type",into=c("Type","Value"), sep="</type><value>",remove=TRUE) %>%  # Splits probe type from probe value
  separate("Value",into=c("Value",NA), sep="</value></probe>",remove=TRUE) %>%  # Removes <probe>
  separate("Date", into=c(NA,"Date"), sep="<date>", remove=TRUE) %>%  # removes <date>
  fill("Date",.direction = c("down")) %>%  # Fills in date/time data for all probes/types/values until reaches the next date/time
  drop_na() %>%  # Removes all blank columns (values == NA)
  mutate(Date = lubridate::mdy_hms(Date)) %>%  # Parse date and time
  mutate(Value = as.numeric(Value)) # Convert character strings to numeric
  

fullData<-tibble(Date = as.POSIXct(NA),
               TankID = as.character(),
               Probe = as.character(),
               Type = as.character(),
               Value = as.numeric())

for(i in 1:20){

# create new column for Tank ID
temp <- dataLog %>% 
  mutate(TankID = Probe)

# strip away tank number from probe ID
Tank.num <- temp$TankID
Tank.num <- Tank.num %>% str_replace_all(pattern = "[a-z]|[A-Z]|\\-|\\_", replacement = "")

# replace Tank ID with numeric values
temp <- temp %>% mutate(TankID = as.numeric(Tank.num))

temp <- temp %>% 
  filter(TankID == i)

fullData <- fullData %>% rbind(temp)
}


write_csv(fullData, here(paste0(output.path,'Apex_datalog_',file.date,'.csv')))
