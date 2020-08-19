# Organizing the Raw Apex outlog files for readability

# written by Danielle Barnas
# created 1/03/2019
# last updated 1/03/2019

rm(list=ls())
library(tidyverse)

Apex_39106 <- read_csv("Apex_OutLogs/20191029/39106_outlog_100519.csv",
                       col_names = FALSE,
                       skip=5) #skips first 5 rows containing system information
View(Apex_39106)
#Splits data into separate columns
Apex_39106 <- separate(Apex_39106,"X1", into=c("Record",NA), sep="</outlog>", remove=TRUE) # Removes last row </outlog>
Apex_39106 <- separate(Apex_39106,"Record", into=c("Record","Date"), sep="<record><date>", remove=TRUE) # Splits other data from date and time
Apex_39106 <- separate(Apex_39106,"Record",into=c("Status","Name"), sep="<name>",remove=TRUE) # Splits unit status and unit name 
Apex_39106 <- separate(Apex_39106,"Name",into=c("Name",NA), sep="</name>",remove=TRUE) # Removes </name>
Apex_39106 <- separate(Apex_39106,"Status",into=c("Status",NA), sep="</value>",remove=TRUE) # Removes </value></record>
Apex_39106 <- separate(Apex_39106,"Status",into=c(NA,"Status"), sep=">",remove=TRUE) # Removes <value> and last row </outlog>

# Removes NA values from Name column
Status_col <- Apex_39106["Status"]
Status_col <- drop_na_(Status_col,"Status")

Name_col <- Apex_39106["Name"]
Name_col <- drop_na_(Name_col,"Name")

Date_col <- Apex_39106["Date"]
Date_col <- drop_na_(Date_col,"Date")

# Binds all columns together to match up data
Apex_39106 <- cbind(Date_col,Name_col,Status_col)
Apex_39106 <- separate(Apex_39106,"Date",into=c("Date","Time"), sep=" ",remove=TRUE) # Splits date and time
Apex_39106 <- separate(Apex_39106,"Time",into=c("Time",NA), sep="</date>",remove=TRUE) # Removes </date>

View(Apex_39106)
write_csv(Apex_39106,"Apex_DataLogs/20191029/Tidy/39106_outlog.csv")
