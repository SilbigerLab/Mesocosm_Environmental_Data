# Reorganizing the Raw Hobo Tidbit and Hobo Pendant data files to compare to Apex data files and plot.
# Use this script only if you have a full set of 20 hobo files (1 hobo per tank), otherwise, use the "tank-specific_HOBO_Data_Tidy.R" script

# written by Danielle Barnas
# created 8/19/2020
# last updated 8/19/2020

rm(list=ls())
library(tidyverse)

# change the dated folders to match the location of your files
foldername<-'Data/HOBO_loggers/20200823/' # the location of all your hobo files
folder_date<-'20200823'
Hobo_All_Logs<-'Amanda_Hobo_Logs.csv'

# ONLY CHANGE THE DATE AND TIME, MAINTAINING FORMAT
# start date and time of data logging
startLog<-parse_datetime("2020-08-17 00:00:00",format = "%F %T", na=character(),locale = locale(tz = ""), trim_ws = TRUE)
# end date and time of data logging
endLog<-parse_datetime("2020-08-23 10:47:00",format = "%F %T", na=character(),locale = locale(tz = ""), trim_ws = TRUE)

########################################################
# DO NOT CHANGE ANYTHING BELOW HERE ---------------
########################################################

# import all csv files in the 'foldername' directory
file.names<-basename(list.files(path = foldername, pattern = c("TNK","csv$"), recursive = F)) #list all csv file names in the folder and subfolders
# read in all the files, appending the path before the filename
data <- file.names %>%
  map(~ read_csv(file.path(foldername, .),skip=2,
                 col_names=TRUE,col_types=list("Intensity, ( lux)"=col_skip(),"Button Down"=col_skip(),"Button Up"=col_skip(),
                                               "Host Connect"=col_skip(),"Stopped"=col_skip(),"EOF"=col_skip())))

# Tank 1
Tnk1 <- data[[1]]
Tnk1 <- drop_na(Tnk1)
Tnk1 <- Tnk1 %>%
  rename('Hobo-Tmp-1'=`Temp, (*C)`,Date=contains("Date"))
# Tank 2
Tnk2 <- data[[12]]
Tnk2 <- drop_na(Tnk2)
Tnk2 <- Tnk2 %>%
  rename('Hobo-Tmp-2'=`Temp, (*C)`,Date=contains("Date"))
# Tank 3
Tnk3 <- data[[14]]
Tnk3 <- drop_na(Tnk3)
Tnk3 <- Tnk3 %>%
  rename('Hobo-Tmp-3'=`Temp, (*C)`,Date=contains("Date"))
# Tank 4
Tnk4 <- data[[15]]
Tnk4 <- drop_na(Tnk4)
Tnk4 <- Tnk4 %>%
  rename('Hobo-Tmp-4'=`Temp, (*C)`,Date=contains("Date"))
# Tank 5
Tnk5 <- data[[16]]
Tnk5 <- drop_na(Tnk5)
Tnk5 <- Tnk5 %>%
  rename('Hobo-Tmp-5'=`Temp, (*C)`,Date=contains("Date"))
# Tank 6
Tnk6 <- data[[17]]
Tnk6 <- drop_na(Tnk6)
Tnk6 <- Tnk6 %>%
  rename('Hobo-Tmp-6'=`Temp, (*C)`,Date=contains("Date"))
# Tank 7
Tnk7 <- data[[18]]
Tnk7 <- drop_na(Tnk7)
Tnk7 <- Tnk7 %>%
  rename('Hobo-Tmp-7'=`Temp, (*C)`,Date=contains("Date"))
# Tank 8
Tnk8 <- data[[19]]
Tnk8 <- drop_na(Tnk8)
Tnk8 <- Tnk8 %>%
  rename('Hobo-Tmp-8'=`Temp, (*C)`,Date=contains("Date"))
# Tank 9
Tnk9 <- data[[20]]
Tnk9 <- drop_na(Tnk9)
Tnk9 <- Tnk9 %>%
  rename('Hobo-Tmp-9'=`Temp, (*C)`,Date=contains("Date"))
# Tank 10
Tnk10 <- data[[2]]
Tnk10 <- drop_na(Tnk10)
Tnk10 <- Tnk10 %>%
  rename('Hobo-Tmp-10'=`Temp, (*C)`,Date=contains("Date"))
# Tank 11
Tnk11 <- data[[3]]
Tnk11 <- drop_na(Tnk11)
Tnk11 <- Tnk11 %>%
  rename('Hobo-Tmp-11'=`Temp, (*C)`,Date=contains("Date"))
# Tank 12
Tnk12 <- data[[4]]
Tnk12 <- drop_na(Tnk12)
Tnk12 <- Tnk12 %>%
  rename('Hobo-Tmp-12'=`Temp, (*C)`,Date=contains("Date"))
# Tank 13
Tnk13 <- data[[5]]
Tnk13 <- drop_na(Tnk13)
Tnk13 <- Tnk13 %>%
  rename('Hobo-Tmp-13'=`Temp, (*C)`,Date=contains("Date"))
# Tank 14
Tnk14 <- data[[6]]
Tnk14 <- drop_na(Tnk14)
Tnk14 <- Tnk14 %>%
  rename('Hobo-Tmp-14'=`Temp, (*C)`,Date=contains("Date"))
# Tank 15
Tnk15 <- data[[7]]
Tnk15 <- drop_na(Tnk15)
Tnk15 <- Tnk15 %>%
  rename('Hobo-Tmp-15'=`Temp, (*C)`,Date=contains("Date"))
# Tank 16
Tnk16 <- data[[8]]
Tnk16 <- drop_na(Tnk16)
Tnk16 <- Tnk16 %>%
  rename('Hobo-Tmp-16'=`Temp, (*C)`,Date=contains("Date"))
# Tank 17
Tnk17 <- data[[9]]
Tnk17 <- drop_na(Tnk17)
Tnk17 <- Tnk17 %>%
  rename('Hobo-Tmp-17'=`Temp, (*C)`,Date=contains("Date"))
# Tank 18
Tnk18 <- data[[10]]
Tnk18 <- drop_na(Tnk18)
Tnk18 <- Tnk18 %>%
  rename('Hobo-Tmp-18'=`Temp, (*C)`,Date=contains("Date"))
# Tank 19
Tnk19 <- data[[11]]
Tnk19 <- drop_na(Tnk19)
Tnk19 <- Tnk19 %>%
  rename('Hobo-Tmp-19'=`Temp, (*C)`,Date=contains("Date"))
# Tank 20
Tnk20 <- data[[13]]
Tnk20 <- drop_na(Tnk20)
Tnk20 <- Tnk20 %>%
  rename('Hobo-Tmp-20'=`Temp, (*C)`,Date=contains("Date"))

##################
# Merge Data
##################

# If not using tank 20, update line 129 to assign the last tank with recorded data to Hobo_All,
# then skip to the next merge line for the tank number AFTER the tank recorded in line 243. Run the rest of the script.

If(exists(Tnk20)){
  Hobo_All <- Tnk20
  }
If(exists(Tnk19)){
  Hobo_All <- merge(x = Tnk19, y = Hobo_All, by = 'Date', all = TRUE)
  }
If(exists(Tnk18)){
  Hobo_All <- merge(x = Tnk18, y = Hobo_All, by = 'Date', all = TRUE)
  }
If(exists(Tnk17)){
  Hobo_All <- merge(x = Tnk17, y = Hobo_All, by = 'Date', all = TRUE)
  }
If(exists(Tnk16)){
  Hobo_All <- merge(x = Tnk16, y = Hobo_All, by = 'Date', all = TRUE)
}
If(exists(Tnk15)){
  Hobo_All <- merge(x = Tnk15, y = Hobo_All, by = 'Date', all = TRUE)
  }
If(exists(Tnk14)){
  Hobo_All <- merge(x = Tnk14, y = Hobo_All, by = 'Date', all = TRUE)
}
If(exists(Tnk13)){
  Hobo_All <- merge(x = Tnk13, y = Hobo_All, by = 'Date', all = TRUE)
  }
If(exists(Tnk12)){
  Hobo_All <- merge(x = Tnk12, y = Hobo_All, by = 'Date', all = TRUE)
  }
If(exists(Tnk11)){
  Hobo_All <- merge(x = Tnk11, y = Hobo_All, by = 'Date', all = TRUE)
  }
If(exists(Tnk10)){
  Hobo_All <- merge(x = Tnk10, y = Hobo_All, by = 'Date', all = TRUE)
  }
If(exists(Tnk9)){
  Hobo_All <- merge(x = Tnk9, y = Hobo_All, by = 'Date', all = TRUE)
  }
If(exists(Tnk8)){
  Hobo_All <- merge(x = Tnk8, y = Hobo_All, by = 'Date', all = TRUE)
  }
If(exists(Tnk7)){
  Hobo_All <- merge(x = Tnk7, y = Hobo_All, by = 'Date', all = TRUE)
  }
If(exists(Tnk6)){
  Hobo_All <- merge(x = Tnk6, y = Hobo_All, by = 'Date', all = TRUE)
  }
If(exists(Tnk5)){
  Hobo_All <- merge(x = Tnk5, y = Hobo_All, by = 'Date', all = TRUE)
  }
If(exists(Tnk4)){
  Hobo_All <- merge(x = Tnk4, y = Hobo_All, by = 'Date', all = TRUE)
  }
If(exists(Tnk3)){
  Hobo_All <- merge(x = Tnk3, y = Hobo_All, by = 'Date', all = TRUE)
  }
If(exists(Tnk2)){
  Hobo_All <- merge(x = Tnk2, y = Hobo_All, by = 'Date', all = TRUE)
  }
If(exists(Tnk1)){
  Hobo_All <- merge(x = Tnk1, y = Hobo_All, by = 'Date', all = TRUE)
  }

# Split Date and Time into separate columns
#Hobo_All <- separate(Hobo_All,"Date Time, GMT -0700", into=c("Date","Time"), sep = " ", remove = TRUE)

# filter out "test time" data
Hobo_All<-Hobo_All%>%
  filter((Date>=startLog) & (Date<=endLog))
View(Hobo_All)


##################
# Save Data File
##################

write_csv(Hobo_All,paste0(foldername,"HOBOLog_",folder_date,".csv"))

##################
# Read and overwrite compilation dataset of hobo timeseries
##################

# Read in Hobo_TS
Hobo_TS <- read_csv(paste0('Data/HOBO_loggers/',Hobo_All_Logs),
                     col_names = TRUE)

# Add the current Hobo dataframe to the larger dataframe containing all Hobo logs
Hobo_TS <- 
  union(Hobo_TS,Hobo_All,by=Date) %>%
  distinct()

Hobo_TS <- Hobo_TS %>% arrange(Date)

write_csv(Hobo_TS,paste0('Data/HOBO_loggers/',Hobo_All_Logs))
