# Reorganizing the Raw Apex data files for readability and plotting
# The following script will produce/update two dataframes: one containing all logged Apex data, and one only containing temperature and pH data from each mesocosm tank

# written by Danielle Barnas
# created 1/03/2019
# last updated 7/30/2020

rm(list=ls())
library(tidyverse)

########################
# File Names
########################
foldername<-'20200803' # folder of the day
date<-'20200803' # today's date
Apex_All_Datalogs<-'Apex_Full_Datalog.csv' # Long-term historical data set
Apex_1_filename<-'datalog_1_200803d1.csv' # data from Apex 39106 : year, month, day, # of days to record after log start
Apex_2_filename<-'datalog_2_200803d1.csv' # data from Apex 40216
Apex_3_filename<-'datalog_3_200803d1.csv' # data from Apex 39952
Apex_4_filename<-'datalog_4_200803d1.csv' # data from Apex 37810
Apex_5_filename<-'datalog_5_200803d1.csv' # data from Apex 41239

#################################################################################
# DO NOT CHANGE ANYTHING BELOW HERE ----------------------------------
#################################################################################

########################
# Apex_1 39106, Tanks 1-4
########################
Apex_1 <- read_csv(paste0('Data/Apex_DataLogs/',foldername,'/',Apex_1_filename),
                       col_names = FALSE,
                       skip=6) #skips first 6 rows containing system information

#Splits data into separate columns
Apex_1 <- separate(Apex_1,"X1", into=c("Date",NA), sep="</date>", remove=TRUE) # Removes </date>
Apex_1 <- separate(Apex_1,"Date", into=c("Date",NA), sep="<probe>", remove=TRUE) # Removes <probe>

Apex_1 <- separate(Apex_1,"Date", into=c("Date",NA), sep="</record>", remove=TRUE) # Removes second to last row </record>
Apex_1 <- separate(Apex_1,"Date", into=c("Date",NA), sep="</datalog>", remove=TRUE) # Removes last row </datalog>

Apex_1 <- separate(Apex_1,"Date", into=c("Date","Probe"), sep="<name>", remove=TRUE) # Date/Time become a new second column separete from other data
Apex_1 <- separate(Apex_1,"Probe",into=c("Probe","Type"), sep="</name> <type>",remove=TRUE) # Splits probe name from other probe data
Apex_1 <- separate(Apex_1,"Type",into=c("Type","Value"), sep="</type><value>",remove=TRUE) # Splits probe type from probe value
Apex_1 <- separate(Apex_1,"Value",into=c("Value",NA), sep="</value></probe>",remove=TRUE) # Removes <probe>

Apex_1 <- separate(Apex_1,"Date", into=c(NA,"Date"), sep="<date>", remove=TRUE) # removes <date>
Apex_1 <- fill(Apex_1,"Date",.direction = c("down")) # Fills in date/time data for all probes/types/values until reaches the next date/time

# Removes all blank columns (values == NA)
Apex_1 <- drop_na(Apex_1)

# Parse date and time
Apex_1$Date <- Apex_1$Date %>%
  parse_datetime(format = "%m/%d/%Y %T", na=character(),
                 locale = default_locale(), trim_ws = TRUE)

# Convert character strings to numeric
Apex_1$Value <- Apex_1$Value %>%
  parse_double(na=c("","NA"),locale=default_locale(),trim_ws = TRUE)

# Optional: separate date and time
#Apex_1 <- separate(Apex_1,"Date", into=c("Date","Time"), sep=" ", remove=TRUE)

# For bringing in multiple files for the same apex in the same folder (if volume of apex data requires multiple smaller files)
If(paste0('Data/Apex_DataLogs/',foldername,'/','Apex_1_datalog.csv')=TRUE){
  Apex_1_union <- read_csv(paste0('Data/Apex_DataLogs/',foldername,'/','Apex_1_datalog.csv'),
                               col_names = TRUE)
  Apex_1 <- 
    union(Apex_1,Apex_1_union,by=Date)
  Apex_1 <- Apex_1 %>% arrange(Date)
}

write_csv(Apex_1,paste0('Data/Apex_DataLogs/',foldername,'/','Apex_1_datalog.csv'))


########################
# Apex_2 40216, Tanks 5-8
########################

Apex_2 <- read_csv(paste0('Data/Apex_DataLogs/',foldername,'/',Apex_2_filename),
                       col_names = FALSE,
                       skip=6)  #skips first 6 rows containing system information

#Splits data into separate columns
Apex_2 <- separate(Apex_2,"X1", into=c("Date",NA), sep="</date>", remove=TRUE) # Removes </date>
Apex_2 <- separate(Apex_2,"Date", into=c("Date",NA), sep="<probe>", remove=TRUE) # Removes <probe>

Apex_2 <- separate(Apex_2,"Date", into=c("Date",NA), sep="</record>", remove=TRUE) # Removes second to last row </record>
Apex_2 <- separate(Apex_2,"Date", into=c("Date",NA), sep="</datalog>", remove=TRUE) # Removes last row </datalog>

Apex_2 <- separate(Apex_2,"Date", into=c("Date","Probe"), sep="<name>", remove=TRUE) # Date/Time become a new second column separete from other data
Apex_2 <- separate(Apex_2,"Probe",into=c("Probe","Type"), sep="</name> <type>",remove=TRUE) # Splits probe name from other probe data
Apex_2 <- separate(Apex_2,"Type",into=c("Type","Value"), sep="</type><value>",remove=TRUE) # Splits probe type from probe value
Apex_2 <- separate(Apex_2,"Value",into=c("Value",NA), sep="</value></probe>",remove=TRUE) # Removes <probe>

Apex_2 <- separate(Apex_2,"Date", into=c(NA,"Date"), sep="<date>", remove=TRUE) # removes <date>
Apex_2 <- fill(Apex_2,"Date",.direction = c("down")) # Fills in date/time data for all probes/types/values until reaches the next date/time

# Removes all blank columns (values == NA)
Apex_2 <- drop_na(Apex_2)

# Parse date and time
Apex_2$Date <- Apex_2$Date %>%
  parse_datetime(format = "%m/%d/%Y %T", na=character(),
                 locale = default_locale(), trim_ws = TRUE)

# Convert character strings to numeric
Apex_2$Value <- Apex_2$Value %>%
  parse_double(na=c("","NA"),locale=default_locale(),trim_ws = TRUE)

# Optional: separate date and time
#Apex_2 <- separate(Apex_2,"Date", into=c("Date","Time"), sep=" ", remove=TRUE)

# For bringing in multiple files for the same apex in the same folder (if volume of apex data requires multiple smaller files)
If(paste0('Data/Apex_DataLogs/',foldername,'/','Apex_2_datalog.csv')=TRUE){
  Apex_2_union <- read_csv(paste0('Data/Apex_DataLogs/',foldername,'/','Apex_2_datalog.csv'),
                         col_names = TRUE)
  Apex_2 <- 
    union(Apex_2,Apex_2_union,by=Date)
  Apex_2 <- Apex_2 %>% arrange(Date)
}

write_csv(Apex_2,paste0('Data/Apex_DataLogs/',foldername,'/','Apex_2_datalog.csv'))


########################
# Apex_3 39952, Tanks 9-12
########################

Apex_3 <- read_csv(paste0('Data/Apex_DataLogs/',foldername,'/',Apex_3_filename),
                       col_names = FALSE,
                       skip=6)  #skips first 6 rows containing system information

#Splits data into separate columns
Apex_3 <- separate(Apex_3,"X1", into=c("Date",NA), sep="</date>", remove=TRUE) # Removes </date>
Apex_3 <- separate(Apex_3,"Date", into=c("Date",NA), sep="<probe>", remove=TRUE) # Removes <probe>

Apex_3 <- separate(Apex_3,"Date", into=c("Date",NA), sep="</record>", remove=TRUE) # Removes second to last row </record>
Apex_3 <- separate(Apex_3,"Date", into=c("Date",NA), sep="</datalog>", remove=TRUE) # Removes last row </datalog>

Apex_3 <- separate(Apex_3,"Date", into=c("Date","Probe"), sep="<name>", remove=TRUE) # Date/Time become a new second column separete from other data
Apex_3 <- separate(Apex_3,"Probe",into=c("Probe","Type"), sep="</name> <type>",remove=TRUE) # Splits probe name from other probe data
Apex_3 <- separate(Apex_3,"Type",into=c("Type","Value"), sep="</type><value>",remove=TRUE) # Splits probe type from probe value
Apex_3 <- separate(Apex_3,"Value",into=c("Value",NA), sep="</value></probe>",remove=TRUE) # Removes <probe>

Apex_3 <- separate(Apex_3,"Date", into=c(NA,"Date"), sep="<date>", remove=TRUE) # removes <date>
Apex_3 <- fill(Apex_3,"Date",.direction = c("down")) # Fills in date/time data for all probes/types/values until reaches the next date/time

# Removes all blank columns (values == NA)
Apex_3 <- drop_na(Apex_3)

# Parse date and time
Apex_3$Date <- Apex_3$Date %>%
  parse_datetime(format = "%m/%d/%Y %T", na=character(),
                 locale = default_locale(), trim_ws = TRUE)

# Convert character strings to numeric
Apex_3$Value <- Apex_3$Value %>%
  parse_double(na=c("","NA"),locale=default_locale(),trim_ws = TRUE)

# Optional: separate date and time
#Apex_3 <- separate(Apex_3,"Date", into=c("Date","Time"), sep=" ", remove=TRUE)

# For bringing in multiple files for the same apex in the same folder (if volume of apex data requires multiple smaller files)
If(paste0('Data/Apex_DataLogs/',foldername,'/','Apex_3_datalog.csv')=TRUE){
  Apex_3_union <- read_csv(paste0('Data/Apex_DataLogs/',foldername,'/','Apex_3_datalog.csv'),
                               col_names = TRUE)
  Apex_3 <- 
    union(Apex_3,Apex_3_union,by=Date)
  Apex_3 <- Apex_3 %>% arrange(Date)
}

write_csv(Apex_3,paste0('Data/Apex_DataLogs/',foldername,'/','Apex_3_datalog.csv'))


########################
# Apex_4 37810, Tanks 13-16
########################

Apex_4 <- read_csv(paste0('Data/Apex_DataLogs/',foldername,'/',Apex_4_filename),
                       col_names = FALSE,
                       skip=6) #skips first 6 rows containing system information

#Splits data into separate columns
Apex_4 <- separate(Apex_4,"X1", into=c("Date",NA), sep="</date>", remove=TRUE) # Removes </date>
Apex_4 <- separate(Apex_4,"Date", into=c("Date",NA), sep="<probe>", remove=TRUE) # Removes <probe>

Apex_4 <- separate(Apex_4,"Date", into=c("Date",NA), sep="</record>", remove=TRUE) # Removes second to last row </record>
Apex_4 <- separate(Apex_4,"Date", into=c("Date",NA), sep="</datalog>", remove=TRUE) # Removes last row </datalog>

Apex_4 <- separate(Apex_4,"Date", into=c("Date","Probe"), sep="<name>", remove=TRUE) # Date/Time become a new second column separete from other data
Apex_4 <- separate(Apex_4,"Probe",into=c("Probe","Type"), sep="</name> <type>",remove=TRUE) # Splits probe name from other probe data
Apex_4 <- separate(Apex_4,"Type",into=c("Type","Value"), sep="</type><value>",remove=TRUE) # Splits probe type from probe value
Apex_4 <- separate(Apex_4,"Value",into=c("Value",NA), sep="</value></probe>",remove=TRUE) # Removes <probe>

Apex_4 <- separate(Apex_4,"Date", into=c(NA,"Date"), sep="<date>", remove=TRUE) # removes <date>
Apex_4 <- fill(Apex_4,"Date",.direction = c("down")) # Fills in date/time data for all probes/types/values until reaches the next date/time

# Removes all blank columns (values == NA)
Apex_4 <- drop_na(Apex_4)

# Parse date and time
Apex_4$Date <- Apex_4$Date %>%
  parse_datetime(format = "%m/%d/%Y %T", na=character(),
                 locale = default_locale(), trim_ws = TRUE)

# Convert character strings to numeric
Apex_4$Value <- Apex_4$Value %>%
  parse_double(na=c("","NA"),locale=default_locale(),trim_ws = TRUE)

# Optional: separate date and time
#Apex_4 <- separate(Apex_4,"Date", into=c("Date","Time"), sep=" ", remove=TRUE)

# For bringing in multiple files for the same apex in the same folder (if volume of apex data requires multiple smaller files)
If(paste0('Data/Apex_DataLogs/',foldername,'/','Apex_4_datalog.csv')=TRUE){
  Apex_4_union <- read_csv(paste0('Data/Apex_DataLogs/',foldername,'/','Apex_4_datalog.csv'),
                               col_names = TRUE)
  Apex_4 <- 
    union(Apex_4,Apex_4_union,by=Date)
  Apex_4 <- Apex_4 %>% arrange(Date)
}

write_csv(Apex_4,paste0('Data/Apex_DataLogs/',foldername,'/','Apex_4_datalog.csv'))


########################
# Apex_5 41239, Tanks 17-20
########################

Apex_5 <- read_csv(paste0('Data/Apex_DataLogs/',foldername,'/',Apex_5_filename),
                       col_names = FALSE,
                       skip=6)  #skips first 6 rows containing system information

#Splits data into separate columns
Apex_5 <- separate(Apex_5,"X1", into=c("Date",NA), sep="</date>", remove=TRUE) # Removes </date>
Apex_5 <- separate(Apex_5,"Date", into=c("Date",NA), sep="<probe>", remove=TRUE) # Removes <probe>

Apex_5 <- separate(Apex_5,"Date", into=c("Date",NA), sep="</record>", remove=TRUE) # Removes second to last row </record>
Apex_5 <- separate(Apex_5,"Date", into=c("Date",NA), sep="</datalog>", remove=TRUE) # Removes last row </datalog>

Apex_5 <- separate(Apex_5,"Date", into=c("Date","Probe"), sep="<name>", remove=TRUE) # Date/Time become a new second column separete from other data
Apex_5 <- separate(Apex_5,"Probe",into=c("Probe","Type"), sep="</name> <type>",remove=TRUE) # Splits probe name from other probe data
Apex_5 <- separate(Apex_5,"Type",into=c("Type","Value"), sep="</type><value>",remove=TRUE) # Splits probe type from probe value
Apex_5 <- separate(Apex_5,"Value",into=c("Value",NA), sep="</value></probe>",remove=TRUE) # Removes <probe>

Apex_5 <- separate(Apex_5,"Date", into=c(NA,"Date"), sep="<date>", remove=TRUE) # removes <date>
Apex_5 <- fill(Apex_5,"Date",.direction = c("down")) # Fills in date/time data for all probes/types/values until reaches the next date/time

# Removes all blank columns (values == NA)
Apex_5 <- drop_na(Apex_5)

# Parse date and time
Apex_5$Date <- Apex_5$Date %>%
  parse_datetime(format = "%m/%d/%Y %T", na=character(),
                 locale = default_locale(), trim_ws = TRUE)

# Convert character strings to numeric
Apex_5$Value <- Apex_5$Value %>%
  parse_double(na=c("","NA"),locale=default_locale(),trim_ws = TRUE)

# Optional: separate date and time
#Apex_5 <- separate(Apex_5,"Date", into=c("Date","Time"), sep=" ", remove=TRUE)

# For bringing in multiple files for the same apex in the same folder (if volume of apex data requires multiple smaller files)
If(paste0('Data/Apex_DataLogs/',foldername,'/','Apex_5_datalog.csv')=TRUE){
  Apex_5_union <- read_csv(paste0('Data/Apex_DataLogs/',foldername,'/','Apex_5_datalog.csv'),
                               col_names = TRUE)
  Apex_5 <- 
    union(Apex_5,Apex_5_union,by=Date)
  Apex_5 <- Apex_5 %>% arrange(Date)
}

write_csv(Apex_5,paste0('Data/Apex_DataLogs/',foldername,'/','Apex_5_datalog.csv'))


########################################
# Join all files together into Apex_Full and Apex_All
########################################

# load apex data files
Apex_1 <- read_csv(paste0('Data/Apex_DataLogs/',foldername,'/Apex_1_datalog.csv'))
Apex_2 <- read_csv(paste0('Data/Apex_DataLogs/',foldername,'/Apex_2_datalog.csv'))
Apex_3 <- read_csv(paste0('Data/Apex_DataLogs/',foldername,'/Apex_3_datalog.csv'))
Apex_4 <- read_csv(paste0('Data/Apex_DataLogs/',foldername,'/Apex_4_datalog.csv'))
Apex_5 <- read_csv(paste0('Data/Apex_DataLogs/',foldername,'/Apex_5_datalog.csv'))

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
# or can arrange data by the probe name
#Apex_Full <- Apex_Full %>% arrange(Probe)

# separate date and time
Apex_Full <- separate(Apex_Full,"Date", into=c("Date","Time"), sep=" ", remove=TRUE)
Apex_Full$Date <- Apex_Full$Date %>%
  parse_date(format = "%Y-%m-%d", na=character(),
                 locale = default_locale(), trim_ws = TRUE)
Apex_Full$Time <- Apex_Full$Time %>%
  parse_time(format = "%H:%M:%S", na=character(),
             locale = default_locale(), trim_ws = TRUE)

# Filters out unnecessary variables from the data frame, only keeping temperature and pH data
#Apex_Full <- Apex_Full %>% filter(Type %in% c("Temp", "pH"))

write_csv(Apex_Full,paste0('Data/Apex_DataLogs/',foldername,'/','Apex_datalog_',date,'.csv'))
View(Apex_Full)

# Read in Apex_All
Apex_All <- read_csv(paste0('Data/Apex_DataLogs/',Apex_All_Datalogs),
                       col_names = TRUE)

# Add the current Apex dataframe to the larger dataframe containing all apex logs
Apex_All <- 
  union(Apex_All,Apex_Full,by=Date)

Apex_All <- Apex_All %>% arrange(Date) # or
#Apex_Full <- Apex_Full %>% arrange(Probe)
#View(Apex_All)

write_csv(Apex_All,paste0('Data/Apex_DataLogs/Apex_Full_Datalog.csv'))

Apex_pH <- Apex_All %>%
  filter(Type %in% c("Temp", "pH"))
write_csv(Apex_pH,paste0('Data/Apex_DataLogs/Apex_temp_pH_Datalog.csv'))


