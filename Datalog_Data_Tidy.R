rm(list=ls())
library(tidyverse)

#Apex_37810 <- read_csv("Apex_DataLogs/20191109/37810_191103d6.csv",
#                       col_names = FALSE,
#                       skip=6) #skips first 6 rows containing system information
Apex_39952 <- read_csv("Apex_DataLogs/20191109/39952_191103d6.csv",
                       col_names = FALSE,
                       skip=6)
#Apex_41235 <- read_csv("Apex_DataLogs/20191109/41235_191103d6.csv",
#                       col_names = FALSE,
#                       skip=6)
#Apex_40216 <- read_csv("Apex_DataLogs/20191109/40216_191103d6.csv",
#                       col_names = FALSE,
#                       skip=6)

View(Apex_39952)
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

View(Apex_39952)

# Removes all blank columns (values == NA)
Apex_39952 <- drop_na(Apex_39952)

# Optional: separate date and time
# Apex_39952 <- separate(Apex_39952,"Date", into=c("Date","Time"), sep=" ", remove=TRUE)
write_csv(Apex_39952,"Apex_DataLogs/20191109/Tidy/39952_datalog.csv")
