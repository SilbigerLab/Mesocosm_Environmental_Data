# Organizing the Raw Apex outlog files for readability

# written by Danielle Barnas
# created 1/03/2019
# last updated 8/19/2020

rm(list=ls())
library(tidyverse)

########################
# File Names
########################
foldername<-'20200803' # folder of the day
date<-'20200803' # today's date
Apex_1_filename<-'outlog_1_200803d1.csv' # data from Apex 39106 : year, month, day, # of days to record after log start
Apex_2_filename<-'outlog_2_200803d1.csv' # data from Apex 40216
Apex_3_filename<-'outlog_3_200803d1.csv' # data from Apex 39952
Apex_4_filename<-'outlog_4_200803d1.csv' # data from Apex 37810
Apex_5_filename<-'outlog_5_200803d1.csv' # data from Apex 41239

#################################################################################
# DO NOT CHANGE ANYTHING BELOW HERE ----------------------------------
#################################################################################

########################
# Apex_1 39106, Tanks 1-4
########################
Apex_1 <- read_csv(paste0('Data/Apex_Outlogs/',foldername,'/',Apex_1_filename),
                   col_names = FALSE,
                   skip=5) #skips first 5 rows containing system information

#Splits data into separate columns
Apex_1 <- separate(Apex_1,"X1", into=c("Record",NA), sep="</outlog>", remove=TRUE) # Removes last row </outlog>
Apex_1 <- separate(Apex_1,"Record", into=c("Record","Date"), sep="<record><date>", remove=TRUE) # Splits other data from date and time
Apex_1 <- separate(Apex_1,"Record",into=c("Status","Name"), sep="<name>",remove=TRUE) # Splits unit status and unit name 
Apex_1 <- separate(Apex_1,"Name",into=c("Name",NA), sep="</name>",remove=TRUE) # Removes </name>
Apex_1 <- separate(Apex_1,"Status",into=c("Status",NA), sep="</value>",remove=TRUE) # Removes </value></record>
Apex_1 <- separate(Apex_1,"Status",into=c(NA,"Status"), sep=">",remove=TRUE) # Removes <value> and last row </outlog>

# Removes NA values from Name column
Status_col <- Apex_1["Status"]
Status_col <- drop_na_(Status_col,"Status")

Name_col <- Apex_1["Name"]
Name_col <- drop_na_(Name_col,"Name")

Date_col <- Apex_1["Date"]
Date_col <- drop_na_(Date_col,"Date")

# Binds all columns together to match up data
Apex_1 <- cbind(Date_col,Name_col,Status_col)
Apex_1 <- separate(Apex_1,"Date",into=c("Date","Time"), sep=" ",remove=TRUE) # Splits date and time
Apex_1 <- separate(Apex_1,"Time",into=c("Time",NA), sep="</date>",remove=TRUE) # Removes </date>

# For bringing in multiple files for the same apex in the same folder (if volume of apex data requires multiple smaller files)
If(paste0('Data/Apex_Outlogs/',foldername,'/','Apex_1_outlog.csv')=TRUE){
  Apex_1_union <- read_csv(paste0('Data/Apex_Outlogs/',foldername,'/','Apex_1_outlog.csv'),
                           col_names = TRUE)
  Apex_1 <- 
    union(Apex_1,Apex_1_union,by=Date)
  Apex_1 <- Apex_1 %>% arrange(Date)
}

write_csv(Apex_1,paste0('Data/Apex_Outlogs/',foldername,'/','Apex_1_outlog.csv'))

########################
# Apex_2 40216, Tanks 5-8
########################
Apex_2 <- read_csv(paste0('Data/Apex_Outlogs/',foldername,'/',Apex_2_filename),
                   col_names = FALSE,
                   skip=5) #skips first 5 rows containing system information

#Splits data into separate columns
Apex_2 <- separate(Apex_2,"X1", into=c("Record",NA), sep="</outlog>", remove=TRUE) # Removes last row </outlog>
Apex_2 <- separate(Apex_2,"Record", into=c("Record","Date"), sep="<record><date>", remove=TRUE) # Splits other data from date and time
Apex_2 <- separate(Apex_2,"Record",into=c("Status","Name"), sep="<name>",remove=TRUE) # Splits unit status and unit name 
Apex_2 <- separate(Apex_2,"Name",into=c("Name",NA), sep="</name>",remove=TRUE) # Removes </name>
Apex_2 <- separate(Apex_2,"Status",into=c("Status",NA), sep="</value>",remove=TRUE) # Removes </value></record>
Apex_2 <- separate(Apex_2,"Status",into=c(NA,"Status"), sep=">",remove=TRUE) # Removes <value> and last row </outlog>

# Removes NA values from Name column
Status_col <- Apex_2["Status"]
Status_col <- drop_na_(Status_col,"Status")

Name_col <- Apex_2["Name"]
Name_col <- drop_na_(Name_col,"Name")

Date_col <- Apex_2["Date"]
Date_col <- drop_na_(Date_col,"Date")

# Binds all columns together to match up data
Apex_2 <- cbind(Date_col,Name_col,Status_col)
Apex_2 <- separate(Apex_2,"Date",into=c("Date","Time"), sep=" ",remove=TRUE) # Splits date and time
Apex_2 <- separate(Apex_2,"Time",into=c("Time",NA), sep="</date>",remove=TRUE) # Removes </date>

# For bringing in multiple files for the same apex in the same folder (if volume of apex data requires multiple smaller files)
If(paste0('Data/Apex_Outlogs/',foldername,'/','Apex_2_outlog.csv')=TRUE){
  Apex_2_union <- read_csv(paste0('Data/Apex_Outlogs/',foldername,'/','Apex_2_outlog.csv'),
                           col_names = TRUE)
  Apex_2 <- 
    union(Apex_2,Apex_2_union,by=Date)
  Apex_2 <- Apex_2 %>% arrange(Date)
}

write_csv(Apex_2,paste0('Data/Apex_Outlogs/',foldername,'/','Apex_2_outlog.csv'))

########################
# Apex_3 39952, Tanks 9-12
########################
Apex_3 <- read_csv(paste0('Data/Apex_Outlogs/',foldername,'/',Apex_3_filename),
                   col_names = FALSE,
                   skip=5) #skips first 5 rows containing system information

#Splits data into separate columns
Apex_3 <- separate(Apex_3,"X1", into=c("Record",NA), sep="</outlog>", remove=TRUE) # Removes last row </outlog>
Apex_3 <- separate(Apex_3,"Record", into=c("Record","Date"), sep="<record><date>", remove=TRUE) # Splits other data from date and time
Apex_3 <- separate(Apex_3,"Record",into=c("Status","Name"), sep="<name>",remove=TRUE) # Splits unit status and unit name 
Apex_3 <- separate(Apex_3,"Name",into=c("Name",NA), sep="</name>",remove=TRUE) # Removes </name>
Apex_3 <- separate(Apex_3,"Status",into=c("Status",NA), sep="</value>",remove=TRUE) # Removes </value></record>
Apex_3 <- separate(Apex_3,"Status",into=c(NA,"Status"), sep=">",remove=TRUE) # Removes <value> and last row </outlog>

# Removes NA values from Name column
Status_col <- Apex_3["Status"]
Status_col <- drop_na_(Status_col,"Status")

Name_col <- Apex_3["Name"]
Name_col <- drop_na_(Name_col,"Name")

Date_col <- Apex_3["Date"]
Date_col <- drop_na_(Date_col,"Date")

# Binds all columns together to match up data
Apex_3 <- cbind(Date_col,Name_col,Status_col)
Apex_3 <- separate(Apex_3,"Date",into=c("Date","Time"), sep=" ",remove=TRUE) # Splits date and time
Apex_3 <- separate(Apex_3,"Time",into=c("Time",NA), sep="</date>",remove=TRUE) # Removes </date>

# For bringing in multiple files for the same apex in the same folder (if volume of apex data requires multiple smaller files)
If(paste0('Data/Apex_Outlogs/',foldername,'/','Apex_3_outlog.csv')=TRUE){
  Apex_3 <- read_csv(paste0('Data/Apex_Outlogs/',foldername,'/','Apex_3_outlog.csv'),
                           col_names = TRUE)
  Apex_3 <- 
    union(Apex_3,Apex_3_union,by=Date)
  Apex_3 <- Apex_3 %>% arrange(Date)
}

write_csv(Apex_3,paste0('Data/Apex_Outlogs/',foldername,'/','Apex_3_outlog.csv'))

########################
# Apex_4 37810, Tanks 13-16
########################
Apex_4 <- read_csv(paste0('Data/Apex_Outlogs/',foldername,'/',Apex_4_filename),
                   col_names = FALSE,
                   skip=5) #skips first 5 rows containing system information

#Splits data into separate columns
Apex_4 <- separate(Apex_4,"X1", into=c("Record",NA), sep="</outlog>", remove=TRUE) # Removes last row </outlog>
Apex_4 <- separate(Apex_4,"Record", into=c("Record","Date"), sep="<record><date>", remove=TRUE) # Splits other data from date and time
Apex_4 <- separate(Apex_4,"Record",into=c("Status","Name"), sep="<name>",remove=TRUE) # Splits unit status and unit name 
Apex_4 <- separate(Apex_4,"Name",into=c("Name",NA), sep="</name>",remove=TRUE) # Removes </name>
Apex_4 <- separate(Apex_4,"Status",into=c("Status",NA), sep="</value>",remove=TRUE) # Removes </value></record>
Apex_4 <- separate(Apex_4,"Status",into=c(NA,"Status"), sep=">",remove=TRUE) # Removes <value> and last row </outlog>

# Removes NA values from Name column
Status_col <- Apex_4["Status"]
Status_col <- drop_na_(Status_col,"Status")

Name_col <- Apex_4["Name"]
Name_col <- drop_na_(Name_col,"Name")

Date_col <- Apex_4["Date"]
Date_col <- drop_na_(Date_col,"Date")

# Binds all columns together to match up data
Apex_4 <- cbind(Date_col,Name_col,Status_col)
Apex_4 <- separate(Apex_4,"Date",into=c("Date","Time"), sep=" ",remove=TRUE) # Splits date and time
Apex_4 <- separate(Apex_4,"Time",into=c("Time",NA), sep="</date>",remove=TRUE) # Removes </date>

# For bringing in multiple files for the same apex in the same folder (if volume of apex data requires multiple smaller files)
If(paste0('Data/Apex_Outlogs/',foldername,'/','Apex_4_outlog.csv')=TRUE){
  Apex_4 <- read_csv(paste0('Data/Apex_Outlogs/',foldername,'/','Apex_4_outlog.csv'),
                     col_names = TRUE)
  Apex_4 <- 
    union(Apex_4,Apex_4_union,by=Date)
  Apex_4 <- Apex_4 %>% arrange(Date)
}

write_csv(Apex_4,paste0('Data/Apex_Outlogs/',foldername,'/','Apex_4_outlog.csv'))

########################
# Apex_5 41239, Tanks 17-20
########################
Apex_5 <- read_csv(paste0('Data/Apex_Outlogs/',foldername,'/',Apex_5_filename),
                   col_names = FALSE,
                   skip=5) #skips first 5 rows containing system information

#Splits data into separate columns
Apex_5 <- separate(Apex_5,"X1", into=c("Record",NA), sep="</outlog>", remove=TRUE) # Removes last row </outlog>
Apex_5 <- separate(Apex_5,"Record", into=c("Record","Date"), sep="<record><date>", remove=TRUE) # Splits other data from date and time
Apex_5 <- separate(Apex_5,"Record",into=c("Status","Name"), sep="<name>",remove=TRUE) # Splits unit status and unit name 
Apex_5 <- separate(Apex_5,"Name",into=c("Name",NA), sep="</name>",remove=TRUE) # Removes </name>
Apex_5 <- separate(Apex_5,"Status",into=c("Status",NA), sep="</value>",remove=TRUE) # Removes </value></record>
Apex_5 <- separate(Apex_5,"Status",into=c(NA,"Status"), sep=">",remove=TRUE) # Removes <value> and last row </outlog>

# Removes NA values from Name column
Status_col <- Apex_5["Status"]
Status_col <- drop_na_(Status_col,"Status")

Name_col <- Apex_5["Name"]
Name_col <- drop_na_(Name_col,"Name")

Date_col <- Apex_5["Date"]
Date_col <- drop_na_(Date_col,"Date")

# Binds all columns together to match up data
Apex_5 <- cbind(Date_col,Name_col,Status_col)
Apex_5 <- separate(Apex_5,"Date",into=c("Date","Time"), sep=" ",remove=TRUE) # Splits date and time
Apex_5 <- separate(Apex_5,"Time",into=c("Time",NA), sep="</date>",remove=TRUE) # Removes </date>

# For bringing in multiple files for the same apex in the same folder (if volume of apex data requires multiple smaller files)
If(paste0('Data/Apex_Outlogs/',foldername,'/','Apex_5_outlog.csv')=TRUE){
  Apex_5 <- read_csv(paste0('Data/Apex_Outlogs/',foldername,'/','Apex_5_outlog.csv'),
                     col_names = TRUE)
  Apex_5 <- 
    union(Apex_5,Apex_5_union,by=Date)
  Apex_5 <- Apex_5 %>% arrange(Date)
}

write_csv(Apex_5,paste0('Data/Apex_Outlogs/',foldername,'/','Apex_5_outlog.csv'))

########################################
# Join all files together into Apex_Full_Outlogs
########################################

# load apex data files
Apex_1 <- read_csv(paste0('Data/Apex_Outogs/',foldername,'/Apex_1_outlog.csv'))
Apex_2 <- read_csv(paste0('Data/Apex_Outogs/',foldername,'/Apex_2_outlog.csv'))
Apex_3 <- read_csv(paste0('Data/Apex_Outogs/',foldername,'/Apex_3_outlog.csv'))
Apex_4 <- read_csv(paste0('Data/Apex_Outogs/',foldername,'/Apex_4_outlog.csv'))
Apex_5 <- read_csv(paste0('Data/Apex_Outogs/',foldername,'/Apex_5_outlog.csv'))

# union pulls together both data files by their common Date value
Apex_Full <- 
  union(Apex_1,Apex_2,by=Date)
Apex_Full <- 
  union(Apex_Full,Apex_3,by=Date)
Apex_Full <- 
  union(Apex_Full,Apex_4,by=Date)
Apex_Full <- 
  union(Apex_Full,Apex_5,by=Date)

# arranges the data by the Date and Time in the Date column
Apex_Full <- Apex_Full %>% arrange(Date)

# separate date and time
Apex_Full <- separate(Apex_Full,"Date", into=c("Date","Time"), sep=" ", remove=TRUE)
Apex_Full$Date <- Apex_Full$Date %>%
  parse_date(format = "%Y-%m-%d", na=character(),
             locale = default_locale(), trim_ws = TRUE)
Apex_Full$Time <- Apex_Full$Time %>%
  parse_time(format = "%H:%M:%S", na=character(),
             locale = default_locale(), trim_ws = TRUE)

# Filters out unnecessary variables from the data frame, only keeping outlog variables you want
#Apex_Full <- Apex_Full %>% filter(Type %in% c("Temp", "pH"))

write_csv(Apex_Full,paste0('Data/Apex_Outogs/',foldername,'/','Apex_outlog_',date,'.csv'))
