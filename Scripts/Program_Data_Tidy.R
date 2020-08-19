# Organizing the Raw Apex program files for readability

# written by Danielle Barnas
# created 1/03/2019
# last updated 1/03/2019

rm(list=ls())
library(tidyverse)


########################
# Apex 39106, Tanks 1-4
########################

Apex_39106 <- read_csv("Apex_Programs/20191204/39106_191204_program.csv",
                       col_names = FALSE,
                       skip=5) #skips first 6 rows containing system information
View(Apex_39106)
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
View(Apex_39106)

# Optional: separate date and time
# Apex_39106 <- separate(Apex_39106,"Date", into=c("Date","Time"), sep=" ", remove=TRUE)

#write_csv(Apex_39106,"Apex_DataLogs/20191109/Tidy/20191109/39106_datalog.csv")


########################
# Apex 40216, Tanks 5-8
########################

Apex_40216 <- read_csv("Apex_Programs/20191204/40216_191204_program.csv",
                       col_names = FALSE,
                       skip=5)  #skips first 6 rows containing system information
View(Apex_40216)
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
View(Apex_40216)

# Optional: separate date and time
# Apex_40216 <- separate(Apex_40216,"Date", into=c("Date","Time"), sep=" ", remove=TRUE)

#write_csv(Apex_40216,"Apex_DataLogs/20191109/Tidy/20191109/40216_datalog.csv")


########################
# Apex 39952, Tanks 9-12
########################

Apex_39952 <- read_csv("Apex_Programs/20191204/39952_191204_program.csv",
                       col_names = FALSE,
                       skip=5)  #skips first 6 rows containing system information
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

# Removes all blank columns (values == NA)
Apex_39952 <- drop_na(Apex_39952)
View(Apex_39952)

# Optional: separate date and time
# Apex_39952 <- separate(Apex_39952,"Date", into=c("Date","Time"), sep=" ", remove=TRUE)

#write_csv(Apex_39952,"Apex_DataLogs/20191109/Tidy/20191109/39952_datalog.csv")


########################
# Apex 37810, Tanks 13-16
########################

Apex_37810 <- read_csv("Apex_Programs/20191204/37810_191204_program.csv",
                       col_names = FALSE,
                       skip=5) #skips first 6 rows containing system information
View(Apex_37810)
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
View(Apex_37810)

# Optional: separate date and time
# Apex_37810 <- separate(Apex_37810,"Date", into=c("Date","Time"), sep=" ", remove=TRUE)

#write_csv(Apex_37810,"Apex_DataLogs/20191109/Tidy/20191109/37810_datalog.csv")


########################
# Apex 41235, Tanks 17-20
########################

Apex_41235 <- read_csv("Apex_Programs/20191204/41239_191204_program.csv",
                       col_names = FALSE,
                       skip=5)  #skips first 6 rows containing system information
View(Apex_41235)
#Splits data into separate columns
Apex_41235 <- separate(Apex_41235,"X1", into=c("Date",NA), sep="</date>", remove=TRUE) # Removes </date>
Apex_41235 <- separate(Apex_41235,"Date", into=c("Date",NA), sep="<probe>", remove=TRUE) # Removes <probe>

Apex_41235 <- separate(Apex_41235,"Date", into=c("Date",NA), sep="</record>", remove=TRUE) # Removes second to last row </record>
Apex_41235 <- separate(Apex_41235,"Date", into=c("Date",NA), sep="</datalog>", remove=TRUE) # Removes last row </datalog>

Apex_41235 <- separate(Apex_41235,"Date", into=c("Date","Probe"), sep="<name>", remove=TRUE) # Date/Time become a new second column separete from other data
Apex_41235 <- separate(Apex_41235,"Probe",into=c("Probe","Type"), sep="</name> <type>",remove=TRUE) # Splits probe name from other probe data
Apex_41235 <- separate(Apex_41235,"Type",into=c("Type","Value"), sep="</type><value>",remove=TRUE) # Splits probe type from probe value
Apex_41235 <- separate(Apex_41235,"Value",into=c("Value",NA), sep="</value></probe>",remove=TRUE) # Removes <probe>

Apex_41235 <- separate(Apex_41235,"Date", into=c(NA,"Date"), sep="<date>", remove=TRUE)
Apex_41235 <- fill(Apex_41235,"Date",.direction = c("down")) # Fills in date/time data for all probes/types/values until reaches the next date/time

# Removes all blank columns (values == NA)
Apex_41235 <- drop_na(Apex_41235)
View(Apex_41235)

# Optional: separate date and time
# Apex_41235 <- separate(Apex_41235,"Date", into=c("Date","Time"), sep=" ", remove=TRUE)

#write_csv(Apex_41235,"Apex_DataLogs/20191109/Tidy/20191109/41235_datalog.csv")
