rm(list=ls())
library(tidyverse)


########################
# File Names
########################
foldername<-'20200204' # folder of the day
Apex_1_filename<-'39106_200120d4.csv' # data from Apex 39106 : year, month, day, # of days to record after log start
Apex_2_filename<-'40216_200120d4.csv' # data from Apex 40216
Apex_3_filename<-'39952_200120d4.csv' # data from Apex 39952
Apex_4_filename<-'37810_200120d4.csv' # data from Apex 37810
Apex_5_filename<-'41239_200120d4.csv' # data from Apex 41239

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

# Filters out unnecessary variables from the data frame, only keeping temperature and pH data
Apex_39106 <- Apex_39106 %>% filter(Type %in% c("Temp", "pH"))

# Optional: separate date and time
#Apex_39106 <- separate(Apex_39106,"Date", into=c("Date","Time"), sep=" ", remove=TRUE)

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

# Filters out unnecessary variables from the data frame, only keeping temperature and pH data
Apex_40216 <- Apex_40216 %>% filter(Type %in% c("Temp", "pH"))

# Optional: separate date and time
#Apex_40216 <- separate(Apex_40216,"Date", into=c("Date","Time"), sep=" ", remove=TRUE)

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

# Filters out unnecessary variables from the data frame, only keeping temperature and pH data
Apex_39952 <- Apex_39952 %>% filter(Type %in% c("Temp", "pH"))

# Optional: separate date and time
#Apex_39952 <- separate(Apex_39952,"Date", into=c("Date","Time"), sep=" ", remove=TRUE)

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

# Filters out unnecessary variables from the data frame, only keeping temperature and pH data
Apex_37810 <- Apex_37810 %>% filter(Type %in% c("Temp", "pH"))

# Optional: separate date and time
#Apex_37810 <- separate(Apex_37810,"Date", into=c("Date","Time"), sep=" ", remove=TRUE)

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

# Filters out unnecessary variables from the data frame, only keeping temperature and pH data
Apex_41239 <- Apex_41239 %>% filter(Type %in% c("Temp", "pH"))

# Optional: separate date and time
#Apex_41239 <- separate(Apex_41239,"Date", into=c("Date","Time"), sep=" ", remove=TRUE)

write_csv(Apex_41239,paste0('Data/Apex_DataLogs/',foldername,'/','41239_datalog.csv'))


########################
# Join all files together
########################

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
#Apex_Full <- Apex_Full %>% arrange(Date)

# or can arrange data by the probe name
Apex_Full <- Apex_Full %>% arrange(Probe)

# separate date and time
Apex_Full <- separate(Apex_Full,"Date", into=c("Date","Time"), sep=" ", remove=TRUE)


write_csv(Apex_Full,paste0('Data/Apex_DataLogs/',foldername,'/','FullApex_datalog.csv'))
View(Apex_Full)
