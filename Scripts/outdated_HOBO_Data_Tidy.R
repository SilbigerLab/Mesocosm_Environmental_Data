rm(list=ls())
library(tidyverse)

# filenames for each tank
# comment out any tanks for which you have no data
Tank1 <- 'TNK-1-SN20569922 2020-08-04 12_51_33 -0700.csv'
Tank2 <- 'TNK-2-SN20565250 2020-08-04 12_51_59 -0700.csv'
Tank3 <- 'TNK-3-SN20565253 2020-08-04 12_52_27 -0700.csv'
Tank4 <- 'TNK-4-SN20565252 2020-08-04 12_52_52 -0700.csv'
Tank5 <- 'TNK-5-SN20555838 2020-08-04 12_56_16 -0700.csv'
Tank6 <- 'TNK-6-20565254 2020-08-04 12_57_32 -0700.csv'
Tank7 <- 'TNK-7-SN20565255 2020-08-04 12_59_02 -0700.csv'
Tank8 <- 'TNK-8-SN20714139 2020-08-04 12_59_35 -0700.csv'
Tank9 <- 'TNK-9-SN20565257 2020-08-04 13_02_51 -0700.csv'
Tank10 <- 'TNK-10-SN20565258 2020-08-04 13_03_17 -0700.csv'
Tank11 <- 'TNK-11-SN20565259 2020-08-04 13_03_55 -0700.csv'
Tank12 <- 'TNK-12-SN20714140 2020-08-04 13_04_25 -0700.csv'
Tank13 <- 'TNK-13-SN20565261 2020-08-04 13_07_03 -0700.csv'
Tank14 <- 'TNK-14-SN20565262 2020-08-04 13_07_28 -0700.csv'
Tank15 <- 'TNK-15-SN20565263 2020-08-04 13_07_56 -0700.csv'
Tank16 <- 'TNK-16-SN20714141 2020-08-04 13_08_21 -0700.csv'
Tank17 <- 'TNK-17-SN20565265 2020-08-04 13_10_36 -0700.csv'
Tank18 <- 'TNK-18-SN20569983 2020-08-04 13_11_04 -0700.csv'
Tank19 <- 'TNK-19-SN20714142 2020-08-04 13_11_45 -0700.csv'
Tank20 <- 'TNK-20-SN20714143 2020-08-04 13_12_19 -0700.csv' 
# If not reading in data for Tank 20, Run script up to Merge section, then follow instructions

########################################################
# DO NOT CHANGE ANYTHING BELOW HERE ---------------
########################################################

If(exists(Tank1)) {
  Tnk1 <- read_csv(paste0(foldername,Tank1),
                   skip=2, #removes first two rows before column headings
                   skip_empty_rows = TRUE,
                   col_names=TRUE,col_types=list("Button Down"=col_skip(),"Button Up"=col_skip(),
                                                 "Host Connect"=col_skip(),"Stopped"=col_skip(),"EOF"=col_skip()))
  Tnk1 <- drop_na(Tnk1)
  Tnk1 <- Tnk1 %>%
    rename('Hobo-Tmp-1'=`Temp, (*C)`,Date="Date Time, GMT -0700")
}
If(exists(Tank2)) {
  Tnk2 <- read_csv(paste0(foldername,Tank2),
                   skip=2,
                   skip_empty_rows = TRUE,
                   col_names=TRUE,col_types=list("Button Down"=col_skip(),"Button Up"=col_skip(),
                                                 "Host Connect"=col_skip(),"Stopped"=col_skip(),"EOF"=col_skip()))
  Tnk2 <- drop_na(Tnk2)
  Tnk2 <- Tnk2 %>%
    rename('Hobo-Tmp-2' = `Temp, (*C)`,Date="Date Time, GMT -0700")
}
If(exists(Tank3)) {
  Tnk3 <- read_csv(paste0(foldername,Tank3),
                   skip=2,
                   skip_empty_rows = TRUE,
                   col_names=TRUE,col_types=list("Button Down"=col_skip(),"Button Up"=col_skip(),
                                                 "Host Connect"=col_skip(),"Stopped"=col_skip(),"EOF"=col_skip()))
  Tnk3 <- drop_na(Tnk3)
  Tnk3 <- Tnk3 %>%
    rename('Hobo-Tmp-3' = `Temp, (*C)`,Date="Date Time, GMT -0700")
}
If(exists(Tank4)) {
  Tnk4 <- read_csv(paste0(foldername,Tank4),
                   skip=2,
                   skip_empty_rows = TRUE,
                   col_names=TRUE,col_types=list("Button Down"=col_skip(),"Button Up"=col_skip(),
                                                 "Host Connect"=col_skip(),"Stopped"=col_skip(),"EOF"=col_skip()))
  Tnk4 <- drop_na(Tnk4)
  Tnk4 <- Tnk4 %>%
    rename('Hobo-Tmp-4' = `Temp, (*C)`,Date="Date Time, GMT -0700")
}
If(exists(Tank5)) {
  Tnk5 <- read_csv(paste0(foldername,Tank5),
                   skip=2,
                   skip_empty_rows = TRUE,
                   col_names=TRUE,col_types=list("Button Down"=col_skip(),"Button Up"=col_skip(),
                                                 "Host Connect"=col_skip(),"Stopped"=col_skip(),"EOF"=col_skip()))
  Tnk5 <- drop_na(Tnk5)
  Tnk5 <- Tnk5 %>%
    rename('Hobo-Tmp-5' = `Temp, (*C)`,Date="Date Time, GMT -0700")
}
If(exists(Tank6)) {
  Tnk6 <- read_csv(paste0(foldername,Tank6),
                   skip=2,
                   skip_empty_rows = TRUE,
                   col_names=TRUE,col_types=list("Button Down"=col_skip(),"Button Up"=col_skip(),
                                                 "Host Connect"=col_skip(),"Stopped"=col_skip(),"EOF"=col_skip()))
  Tnk6 <- drop_na(Tnk6)
  Tnk6 <- Tnk6 %>%
    rename('Hobo-Tmp-6' = `Temp, (*C)`,Date="Date Time, GMT -0700")
}
If(exists(Tank7)) {
  Tnk7 <- read_csv(paste0(foldername,Tank7),
                   skip=2,
                   skip_empty_rows = TRUE,
                   col_names=TRUE,col_types=list("Button Down"=col_skip(),"Button Up"=col_skip(),
                                                 "Host Connect"=col_skip(),"Stopped"=col_skip(),"EOF"=col_skip()))
  Tnk7 <- drop_na(Tnk7)
  Tnk7 <- Tnk7 %>%
    rename('Hobo-Tmp-7' = `Temp, (*C)`,Date="Date Time, GMT -0700")
}
If(exists(Tank8)) {
  Tnk8 <- read_csv(paste0(foldername,Tank8),
                   skip=2,
                   skip_empty_rows = TRUE,
                   col_names=TRUE,col_types=list("Button Down"=col_skip(),"Button Up"=col_skip(),
                                                 "Host Connect"=col_skip(),"Stopped"=col_skip(),"EOF"=col_skip()))
  Tnk8 <- drop_na(Tnk8)
  Tnk8 <- Tnk8 %>%
    rename('Hobo-Tmp-8' = `Temp, (*C)`,Date="Date Time, GMT -0700")
}
If(exists(Tank9)) {
  Tnk9 <- read_csv(paste0(foldername,Tank9),
                   skip=2,
                   skip_empty_rows = TRUE,
                   col_names=TRUE,col_types=list("Button Down"=col_skip(),"Button Up"=col_skip(),
                                                 "Host Connect"=col_skip(),"Stopped"=col_skip(),"EOF"=col_skip()))
  Tnk9 <- drop_na(Tnk9)
  Tnk9 <- Tnk9 %>%
    rename('Hobo-Tmp-9' = `Temp, (*C)`,Date="Date Time, GMT -0700")
}
If(exists(Tank10)) {
  Tnk10 <- read_csv(paste0(foldername,Tank10),
                    skip=2,
                    skip_empty_rows = TRUE,
                    col_names=TRUE,col_types=list("Button Down"=col_skip(),"Button Up"=col_skip(),
                                                  "Host Connect"=col_skip(),"Stopped"=col_skip(),"EOF"=col_skip()))
  Tnk10 <- drop_na(Tnk10)
  Tnk10 <- Tnk10 %>%
    rename('Hobo-Tmp-10' = `Temp, (*C)`,Date="Date Time, GMT -0700")
}
If(exists(Tank11)) {
  Tnk11 <- read_csv(paste0(foldername,Tank11),
                    skip=2,
                    skip_empty_rows = TRUE,
                    col_names=TRUE,col_types=list("Button Down"=col_skip(),"Button Up"=col_skip(),
                                                  "Host Connect"=col_skip(),"Stopped"=col_skip(),"EOF"=col_skip()))
  Tnk11 <- drop_na(Tnk11)
  Tnk11 <- Tnk11 %>%
    rename('Hobo-Tmp-11' = `Temp, (*C)`,Date="Date Time, GMT -0700")
}
If(exists(Tank12)) {
  Tnk12 <- read_csv(paste0(foldername,Tank12),
                    skip=2,
                    skip_empty_rows = TRUE,
                    col_names=TRUE,col_types=list("Button Down"=col_skip(),"Button Up"=col_skip(),
                                                  "Host Connect"=col_skip(),"Stopped"=col_skip(),"EOF"=col_skip()))
  Tnk12 <- drop_na(Tnk12)
  Tnk12 <- Tnk12 %>%
    rename('Hobo-Tmp-12' = `Temp, (*C)`,Date="Date Time, GMT -0700")
}
If(exists(Tank13)) {
  Tnk13 <- read_csv(paste0(foldername,Tank13),
                    skip=2,
                    skip_empty_rows = TRUE,
                    col_names=TRUE,col_types=list("Button Down"=col_skip(),"Button Up"=col_skip(),
                                                  "Host Connect"=col_skip(),"Stopped"=col_skip(),"EOF"=col_skip()))
  Tnk13 <- drop_na(Tnk13)
  Tnk13 <- Tnk13 %>%
    rename('Hobo-Tmp-13' = `Temp, (*C)`,Date="Date Time, GMT -0700")
}
If(exists(Tank14)) {
  Tnk14 <- read_csv(paste0(foldername,Tank14),
                    skip=2,
                    skip_empty_rows = TRUE,
                    col_names=TRUE,col_types=list("Button Down"=col_skip(),"Button Up"=col_skip(),
                                                  "Host Connect"=col_skip(),"Stopped"=col_skip(),"EOF"=col_skip()))
  Tnk14 <- drop_na(Tnk14)
  Tnk14 <- Tnk14 %>%
    rename('Hobo-Tmp-14' = `Temp, (*C)`,Date="Date Time, GMT -0700")
}
If(exists(Tank15)) {
  Tnk15 <- read_csv(paste0(foldername,Tank15),
                    skip=2,
                    skip_empty_rows = TRUE,
                    col_names=TRUE,col_types=list("Button Down"=col_skip(),"Button Up"=col_skip(),
                                                  "Host Connect"=col_skip(),"Stopped"=col_skip(),"EOF"=col_skip()))
  Tnk15 <- drop_na(Tnk15)
  Tnk15 <- Tnk15 %>%
    rename('Hobo-Tmp-15' = `Temp, (*C)`,Date="Date Time, GMT -0700")
}
If(exists(Tank16)) {
  Tnk16 <- read_csv(paste0(foldername,Tank16),
                    skip=2,
                    skip_empty_rows = TRUE,
                    col_names=TRUE,col_types=list("Button Down"=col_skip(),"Button Up"=col_skip(),
                                                  "Host Connect"=col_skip(),"Stopped"=col_skip(),"EOF"=col_skip()))
  Tnk16 <- drop_na(Tnk16)
  Tnk16 <- Tnk16 %>%
    rename('Hobo-Tmp-16' = `Temp, (*C)`,Date="Date Time, GMT -0700")
}
If(exists(Tank17)) {
  Tnk17 <- read_csv(paste0(foldername,Tank17),
                    skip=2,
                    skip_empty_rows = TRUE,
                    col_names=TRUE,col_types=list("Button Down"=col_skip(),"Button Up"=col_skip(),
                                                  "Host Connect"=col_skip(),"Stopped"=col_skip(),"EOF"=col_skip()))
  Tnk17 <- drop_na(Tnk17)
  Tnk17 <- Tnk17 %>%
    rename('Hobo-Tmp-17' = `Temp, (*C)`,Date="Date Time, GMT -0700")
}
If(exists(Tank18)) {
  Tnk18 <- read_csv(paste0(foldername,Tank18),
                    skip=2,
                    skip_empty_rows = TRUE,
                    col_names=TRUE,col_types=list("Button Down"=col_skip(),"Button Up"=col_skip(),
                                                  "Host Connect"=col_skip(),"Stopped"=col_skip(),"EOF"=col_skip()))
  Tnk18 <- drop_na(Tnk18)
  Tnk18 <- Tnk18 %>%
    rename('Hobo-Tmp-18' = `Temp, (*C)`,Date="Date Time, GMT -0700")
}
If(exists(Tank19)) {
  Tnk19 <- read_csv(paste0(foldername,Tank19),
                    skip=2,
                    skip_empty_rows = TRUE,
                    col_names=TRUE,col_types=list("Button Down"=col_skip(),"Button Up"=col_skip(),
                                                  "Host Connect"=col_skip(),"Stopped"=col_skip(),"EOF"=col_skip()))
  Tnk19 <- drop_na(Tnk19)
  Tnk19 <- Tnk19 %>%
    rename('Hobo-Tmp-19' = `Temp, (*C)`,Date="Date Time, GMT -0700")
}
If(exists(Tank20)) {
  Tnk20 <- read_csv(paste0(foldername,Tank20),
                    skip=2,
                    skip_empty_rows = TRUE,
                    col_names=TRUE,col_types=list("Button Down"=col_skip(),"Button Up"=col_skip(),
                                                  "Host Connect"=col_skip(),"Stopped"=col_skip(),"EOF"=col_skip()))
  Tnk20 <- drop_na(Tnk20)
  Tnk20 <- Tnk20 %>%
    rename('Hobo-Tmp-20' = `Temp, (*C)`,Date="Date Time, GMT -0700")
}

##################
# Merge Data
##################

# If not using tank 20, update line 243 to assign the last tank with recorded data to Hobo_All,
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

View(Hobo_All)

############## save data file

write_csv(Hobo_All,paste0(foldername,"HOBOLog_",folder_date,".csv"))
