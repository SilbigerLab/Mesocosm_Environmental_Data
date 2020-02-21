rm(list=ls())
library(tidyverse)

# The following script will produce a dataframe containing temperature and pH data only from each mesocosm tank
# If you would like a dataframe containing all datalog information, remove the filter from the Apex_Full section before writing the csv

########################
# File Names
########################
foldername<-'20200204' # folder of the day
date<-'20200204' # today's date
Apex_All_Datalogs<-'Apex_Full_Datalog.csv' # Larger data set your compiled new data will be added to
Apex_1_filename<-'39106_200131d3.csv' # data from Apex 39106 : year, month, day, # of days to record after log start
Apex_2_filename<-'40216_200131d3.csv' # data from Apex 40216
Apex_3_filename<-'39952_200131d3.csv' # data from Apex 39952
Apex_4_filename<-'37810_200131d3.csv' # data from Apex 37810
Apex_5_filename<-'41239_200131d3.csv' # data from Apex 41239

#################################################################################
# DO NOT CHANGE ANYTHING BELOW HERE ----------------------------------
#################################################################################

########################
# Apex 39106, Tanks 1-4
########################
Apex_39106 <- read_csv(paste0('Data/Apex_DataLogs/',foldername,'/',Apex_1_filename),
                       col_names = FALSE,
                       skip=6) #skips first 6 rows containing system information

#Splits data into separate columns
Apex_39106 <- separate(Apex_39106,"X1", into=c("Date",NA), sep="</date>", remove=TRUE) # Removes </date>
Apex_39106 <- separate(Apex_39106,"Date", into=c("Date",NA), sep="<probe>", remove=TRUE) # Removes <probe>

Apex_39106 <- separate(Apex_39106,"Date", into=c("Date",NA), sep="</record>", remove=TRUE) # Removes second to last row </record>
Apex_39106 <- separate(Apex_39106,"Date", into=c("Date",NA), sep="</datalog>", remove=TRUE) # Removes last row </datalog>

Apex_39106 <- separate(Apex_39106,"Date", into=c("Date","Probe"), sep="<name>", remove=TRUE) # Date/Time become a new second column separete from other data
Apex_39106 <- separate(Apex_39106,"Probe",into=c("Probe","Type"), sep="</name> <type>",remove=TRUE) # Splits probe name from other probe data
Apex_39106 <- separate(Apex_39106,"Type",into=c("Type","Value"), sep="</type><value>",remove=TRUE) # Splits probe type from probe value
Apex_39106 <- separate(Apex_39106,"Value",into=c("Value",NA), sep="</value></probe>",remove=TRUE) # Removes <probe>

Apex_39106 <- separate(Apex_39106,"Date", into=c(NA,"Date"), sep="<date>", remove=TRUE)
Apex_39106 <- fill(Apex_39106,"Date",.direction = c("down")) # Fills in date/time data for all probes/types/values until reaches the next date/time

# Removes all blank columns (values == NA)
Apex_39106 <- drop_na(Apex_39106)

# Parse date and time
Apex_39106$Date <- Apex_39106$Date %>%
  parse_datetime(format = "%m/%d/%Y %H:%M:%S", na=character(),
                 locale = default_locale(), trim_ws = TRUE)

# Convert character strings to numeric
Apex_39106$Value <- Apex_39106$Value %>%
  parse_double(na=c("","NA"),locale=default_locale(),trim_ws = TRUE)

# Optional: separate date and time
#Apex_39106 <- separate(Apex_39106,"Date", into=c("Date","Time"), sep=" ", remove=TRUE)

# For bringing in multiple files for the same apex in the same folder
If(paste0('Data/Apex_DataLogs/',foldername,'/','39106_datalog.csv')=TRUE){
  Apex_39106_union <- read_csv(paste0('Data/Apex_DataLogs/',foldername,'/','39106_datalog.csv'),
                               col_names = TRUE)
  Apex_39106 <- 
    union(Apex_39106,Apex_39106_union,by=Date)
  Apex_39106 <- Apex_39106 %>% arrange(Date)
}

write_csv(Apex_39106,paste0('Data/Apex_DataLogs/',foldername,'/','39106_datalog.csv'))


########################
# Apex 40216, Tanks 5-8
########################

Apex_40216 <- read_csv(paste0('Data/Apex_DataLogs/',foldername,'/',Apex_2_filename),
                       col_names = FALSE,
                       skip=6)  #skips first 6 rows containing system information

#Splits data into separate columns
Apex_40216 <- separate(Apex_40216,"X1", into=c("Date",NA), sep="</date>", remove=TRUE) # Removes </date>
Apex_40216 <- separate(Apex_40216,"Date", into=c("Date",NA), sep="<probe>", remove=TRUE) # Removes <probe>

Apex_40216 <- separate(Apex_40216,"Date", into=c("Date",NA), sep="</record>", remove=TRUE) # Removes second to last row </record>
Apex_40216 <- separate(Apex_40216,"Date", into=c("Date",NA), sep="</datalog>", remove=TRUE) # Removes last row </datalog>

Apex_40216 <- separate(Apex_40216,"Date", into=c("Date","Probe"), sep="<name>", remove=TRUE) # Date/Time become a new second column separete from other data
Apex_40216 <- separate(Apex_40216,"Probe",into=c("Probe","Type"), sep="</name> <type>",remove=TRUE) # Splits probe name from other probe data
Apex_40216 <- separate(Apex_40216,"Type",into=c("Type","Value"), sep="</type><value>",remove=TRUE) # Splits probe type from probe value
Apex_40216 <- separate(Apex_40216,"Value",into=c("Value",NA), sep="</value></probe>",remove=TRUE) # Removes <probe>

Apex_40216 <- separate(Apex_40216,"Date", into=c(NA,"Date"), sep="<date>", remove=TRUE)
Apex_40216 <- fill(Apex_40216,"Date",.direction = c("down")) # Fills in date/time data for all probes/types/values until reaches the next date/time

# Removes all blank columns (values == NA)
Apex_40216 <- drop_na(Apex_40216)

# Parse date and time
Apex_40216$Date <- Apex_40216$Date %>%
  parse_datetime(format = "%m/%d/%Y %H:%M:%S", na=character(),
                 locale = default_locale(), trim_ws = TRUE)

# Convert character strings to numeric
Apex_40216$Value <- Apex_40216$Value %>%
  parse_double(na=c("","NA"),locale=default_locale(),trim_ws = TRUE)

# Optional: separate date and time
#Apex_40216 <- separate(Apex_40216,"Date", into=c("Date","Time"), sep=" ", remove=TRUE)

# For bringing in multiple files for the same apex in the same folder
If(paste0('Data/Apex_DataLogs/',foldername,'/','40216_datalog.csv')=TRUE){
  Apex_40216_union <- read_csv(paste0('Data/Apex_DataLogs/',foldername,'/','40216_datalog.csv'),
                         col_names = TRUE)
  Apex_40216 <- 
    union(Apex_40216,Apex_40216_union,by=Date)
  Apex_40216 <- Apex_40216 %>% arrange(Date)
}

write_csv(Apex_40216,paste0('Data/Apex_DataLogs/',foldername,'/','40216_datalog.csv'))


########################
# Apex 39952, Tanks 9-12
########################

Apex_39952 <- read_csv(paste0('Data/Apex_DataLogs/',foldername,'/',Apex_3_filename),
                       col_names = FALSE,
                       skip=6)  #skips first 6 rows containing system information

#Splits data into separate columns
Apex_39952 <- separate(Apex_39952,"X1", into=c("Date",NA), sep="</date>", remove=TRUE) # Removes </date>
Apex_39952 <- separate(Apex_39952,"Date", into=c("Date",NA), sep="<probe>", remove=TRUE) # Removes <probe>

Apex_39952 <- separate(Apex_39952,"Date", into=c("Date",NA), sep="</record>", remove=TRUE) # Removes second to last row </record>
Apex_39952 <- separate(Apex_39952,"Date", into=c("Date",NA), sep="</datalog>", remove=TRUE) # Removes last row </datalog>

Apex_39952 <- separate(Apex_39952,"Date", into=c("Date","Probe"), sep="<name>", remove=TRUE) # Date/Time become a new second column separete from other data
Apex_39952 <- separate(Apex_39952,"Probe",into=c("Probe","Type"), sep="</name> <type>",remove=TRUE) # Splits probe name from other probe data
Apex_39952 <- separate(Apex_39952,"Type",into=c("Type","Value"), sep="</type><value>",remove=TRUE) # Splits probe type from probe value
Apex_39952 <- separate(Apex_39952,"Value",into=c("Value",NA), sep="</value></probe>",remove=TRUE) # Removes <probe>

Apex_39952 <- separate(Apex_39952,"Date", into=c(NA,"Date"), sep="<date>", remove=TRUE)
Apex_39952 <- fill(Apex_39952,"Date",.direction = c("down")) # Fills in date/time data for all probes/types/values until reaches the next date/time

# Removes all blank columns (values == NA)
Apex_39952 <- drop_na(Apex_39952)

# Parse date and time
Apex_39952$Date <- Apex_39952$Date %>%
  parse_datetime(format = "%m/%d/%Y %H:%M:%S", na=character(),
                 locale = default_locale(), trim_ws = TRUE)

# Convert character strings to numeric
Apex_39952$Value <- Apex_39952$Value %>%
  parse_double(na=c("","NA"),locale=default_locale(),trim_ws = TRUE)

# Optional: separate date and time
#Apex_39952 <- separate(Apex_39952,"Date", into=c("Date","Time"), sep=" ", remove=TRUE)

# For bringing in multiple files for the same apex in the same folder
If(paste0('Data/Apex_DataLogs/',foldername,'/','39952_datalog.csv')=TRUE){
  Apex_39952_union <- read_csv(paste0('Data/Apex_DataLogs/',foldername,'/','39952_datalog.csv'),
                               col_names = TRUE)
  Apex_39952 <- 
    union(Apex_39952,Apex_39952_union,by=Date)
  Apex_39952 <- Apex_39952 %>% arrange(Date)
}

write_csv(Apex_39952,paste0('Data/Apex_DataLogs/',foldername,'/','39952_datalog.csv'))


########################
# Apex 37810, Tanks 13-16
########################

Apex_37810 <- read_csv(paste0('Data/Apex_DataLogs/',foldername,'/',Apex_4_filename),
                       col_names = FALSE,
                       skip=6) #skips first 6 rows containing system information

#Splits data into separate columns
Apex_37810 <- separate(Apex_37810,"X1", into=c("Date",NA), sep="</date>", remove=TRUE) # Removes </date>
Apex_37810 <- separate(Apex_37810,"Date", into=c("Date",NA), sep="<probe>", remove=TRUE) # Removes <probe>

Apex_37810 <- separate(Apex_37810,"Date", into=c("Date",NA), sep="</record>", remove=TRUE) # Removes second to last row </record>
Apex_37810 <- separate(Apex_37810,"Date", into=c("Date",NA), sep="</datalog>", remove=TRUE) # Removes last row </datalog>

Apex_37810 <- separate(Apex_37810,"Date", into=c("Date","Probe"), sep="<name>", remove=TRUE) # Date/Time become a new second column separete from other data
Apex_37810 <- separate(Apex_37810,"Probe",into=c("Probe","Type"), sep="</name> <type>",remove=TRUE) # Splits probe name from other probe data
Apex_37810 <- separate(Apex_37810,"Type",into=c("Type","Value"), sep="</type><value>",remove=TRUE) # Splits probe type from probe value
Apex_37810 <- separate(Apex_37810,"Value",into=c("Value",NA), sep="</value></probe>",remove=TRUE) # Removes <probe>

Apex_37810 <- separate(Apex_37810,"Date", into=c(NA,"Date"), sep="<date>", remove=TRUE)
Apex_37810 <- fill(Apex_37810,"Date",.direction = c("down")) # Fills in date/time data for all probes/types/values until reaches the next date/time

# Removes all blank columns (values == NA)
Apex_37810 <- drop_na(Apex_37810)

# Parse date and time
Apex_37810$Date <- Apex_37810$Date %>%
  parse_datetime(format = "%m/%d/%Y %H:%M:%S", na=character(),
                 locale = default_locale(), trim_ws = TRUE)

# Convert character strings to numeric
Apex_37810$Value <- Apex_37810$Value %>%
  parse_double(na=c("","NA"),locale=default_locale(),trim_ws = TRUE)

# Optional: separate date and time
#Apex_37810 <- separate(Apex_37810,"Date", into=c("Date","Time"), sep=" ", remove=TRUE)

# For bringing in multiple files for the same apex in the same folder
If(paste0('Data/Apex_DataLogs/',foldername,'/','37810_datalog.csv')=TRUE){
  Apex_37810_union <- read_csv(paste0('Data/Apex_DataLogs/',foldername,'/','37810_datalog.csv'),
                               col_names = TRUE)
  Apex_37810 <- 
    union(Apex_37810,Apex_37810_union,by=Date)
  Apex_37810 <- Apex_37810 %>% arrange(Date)
}

write_csv(Apex_37810,paste0('Data/Apex_DataLogs/',foldername,'/','37810_datalog.csv'))


########################
# Apex 41239, Tanks 17-20
########################

Apex_41239 <- read_csv(paste0('Data/Apex_DataLogs/',foldername,'/',Apex_5_filename),
                       col_names = FALSE,
                       skip=6)  #skips first 6 rows containing system information

#Splits data into separate columns
Apex_41239 <- separate(Apex_41239,"X1", into=c("Date",NA), sep="</date>", remove=TRUE) # Removes </date>
Apex_41239 <- separate(Apex_41239,"Date", into=c("Date",NA), sep="<probe>", remove=TRUE) # Removes <probe>

Apex_41239 <- separate(Apex_41239,"Date", into=c("Date",NA), sep="</record>", remove=TRUE) # Removes second to last row </record>
Apex_41239 <- separate(Apex_41239,"Date", into=c("Date",NA), sep="</datalog>", remove=TRUE) # Removes last row </datalog>

Apex_41239 <- separate(Apex_41239,"Date", into=c("Date","Probe"), sep="<name>", remove=TRUE) # Date/Time become a new second column separete from other data
Apex_41239 <- separate(Apex_41239,"Probe",into=c("Probe","Type"), sep="</name> <type>",remove=TRUE) # Splits probe name from other probe data
Apex_41239 <- separate(Apex_41239,"Type",into=c("Type","Value"), sep="</type><value>",remove=TRUE) # Splits probe type from probe value
Apex_41239 <- separate(Apex_41239,"Value",into=c("Value",NA), sep="</value></probe>",remove=TRUE) # Removes <probe>

Apex_41239 <- separate(Apex_41239,"Date", into=c(NA,"Date"), sep="<date>", remove=TRUE)
Apex_41239 <- fill(Apex_41239,"Date",.direction = c("down")) # Fills in date/time data for all probes/types/values until reaches the next date/time

# Removes all blank columns (values == NA)
Apex_41239 <- drop_na(Apex_41239)

# Parse date and time
Apex_41239$Date <- Apex_41239$Date %>%
  parse_datetime(format = "%m/%d/%Y %H:%M:%S", na=character(),
                 locale = default_locale(), trim_ws = TRUE)

# Convert character strings to numeric
Apex_41239$Value <- Apex_41239$Value %>%
  parse_double(na=c("","NA"),locale=default_locale(),trim_ws = TRUE)

# Optional: separate date and time
#Apex_41239 <- separate(Apex_41239,"Date", into=c("Date","Time"), sep=" ", remove=TRUE)

# For bringing in multiple files for the same apex in the same folder
If(paste0('Data/Apex_DataLogs/',foldername,'/','41239_datalog.csv')=TRUE){
  Apex_41239_union <- read_csv(paste0('Data/Apex_DataLogs/',foldername,'/','41239_datalog.csv'),
                               col_names = TRUE)
  Apex_41239 <- 
    union(Apex_41239,Apex_41239_union,by=Date)
  Apex_41239 <- Apex_41239 %>% arrange(Date)
}

write_csv(Apex_41239,paste0('Data/Apex_DataLogs/',foldername,'/','41239_datalog.csv'))


########################################
# Join all files together into Apex_Full and Apex_All
########################################

# union pulls together both data files by their common Date value
Apex_Full <- 
  union(Apex_39106,Apex_40216,by=Date)
Apex_Full <- 
  union(Apex_Full,Apex_39952,by=Date)
Apex_Full <- 
  union(Apex_Full,Apex_37810,by=Date)
Apex_Full <- 
  union(Apex_Full,Apex_41239,by=Date)

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
View(Apex_All)

write_csv(Apex_All,paste0('Data/Apex_DataLogs/','Apex_Full_Datalog.csv'))
