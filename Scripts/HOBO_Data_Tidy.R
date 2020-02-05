rm(list=ls())
library(tidyverse)

##############
# CHANGE FILE PATH TO CORRECT FOLDER (DATE) AND COPY-PASTE EACH HOBO CSV FILE NAME

Tnk1 <- read_csv("HOBO/20191107/TNK-1-SN20569922 2019-11-07 15_29_07 -0800.csv",
                 skip=2, #removes first two rows before column headings
                 skip_empty_rows = TRUE,
                 col_names=TRUE,col_types=list("Button Down"=col_skip(),"Button Up"=col_skip(),
                                               "Host Connect"=col_skip(),"Stopped"=col_skip(),"EOF"=col_skip()))
Tnk1 <- drop_na(Tnk1)
Tnk1 <- Tnk1 %>%
  rename(Tnk1_TmpF = `Temp, (*F)`)
Tnk2 <- read_csv("HOBO/20191107/TNK-2-SN20565250 2019-11-07 15_30_31 -0800.csv",
                 skip=2,
                 skip_empty_rows = TRUE,
                 col_names=TRUE,col_types=list("Button Down"=col_skip(),"Button Up"=col_skip(),
                                               "Host Connect"=col_skip(),"Stopped"=col_skip(),"EOF"=col_skip()))
Tnk2 <- drop_na(Tnk2)
Tnk2 <- Tnk2 %>%
  rename(Tnk2_TmpF = `Temp, (*F)`)
Tnk3 <- read_csv("HOBO/20191107/Tnk-3-SN20555847 2019-11-07 15_11_31 -0800.csv",
                  skip=2,
                  skip_empty_rows = TRUE,
                  col_names=TRUE,col_types=list("Button Down"=col_skip(),"Button Up"=col_skip(),
                                                "Host Connect"=col_skip(),"Stopped"=col_skip(),"EOF"=col_skip()))
Tnk3 <- drop_na(Tnk3)
Tnk3 <- Tnk3 %>%
  rename(Tnk3_TmpF = `Temp, (*F)`)
Tnk4 <- read_csv("HOBO/20191107/TNK-4-SN20565252 2019-11-07 15_12_17 -0800.csv",
                 skip=2,
                 skip_empty_rows = TRUE,
                 col_names=TRUE,col_types=list("Button Down"=col_skip(),"Button Up"=col_skip(),
                                               "Host Connect"=col_skip(),"Stopped"=col_skip(),"EOF"=col_skip()))
Tnk4 <- drop_na(Tnk4)
Tnk4 <- Tnk4 %>%
  rename(Tnk4_TmpF = `Temp, (*F)`)
Tnk5 <- read_csv("HOBO/20191107/TNK-5-SN20565253 2019-11-07 15_24_50 -0800.csv",
                 skip=2,
                 skip_empty_rows = TRUE,
                 col_names=TRUE,col_types=list("Button Down"=col_skip(),"Button Up"=col_skip(),
                                               "Host Connect"=col_skip(),"Stopped"=col_skip(),"EOF"=col_skip()))
Tnk5 <- drop_na(Tnk5)
Tnk5 <- Tnk5 %>%
  rename(Tnk5_TmpF = `Temp, (*F)`)
Tnk6 <- read_csv("HOBO/20191107/TNK-6-SN20565254 2019-11-07 15_22_45 -0800.csv",
                 skip=2,
                 skip_empty_rows = TRUE,
                 col_names=TRUE,col_types=list("Button Down"=col_skip(),"Button Up"=col_skip(),
                                               "Host Connect"=col_skip(),"Stopped"=col_skip(),"EOF"=col_skip()))
Tnk6 <- drop_na(Tnk6)
Tnk6 <- Tnk6 %>%
  rename(Tnk6_TmpF = `Temp, (*F)`)
Tnk7 <- read_csv("HOBO/20191107/TNK-7-SN20565255 2019-11-07 15_13_39 -0800.csv",
                 skip=2,
                 skip_empty_rows = TRUE,
                 col_names=TRUE,col_types=list("Button Down"=col_skip(),"Button Up"=col_skip(),
                                               "Host Connect"=col_skip(),"Stopped"=col_skip(),"EOF"=col_skip()))
Tnk7 <- drop_na(Tnk7)
Tnk7 <- Tnk7 %>%
  rename(Tnk7_TmpF = `Temp, (*F)`)
Tnk8 <- read_csv("HOBO/20191107/Tnk-8-SN20555867 2019-11-07 15_14_16 -0800.csv",
                  skip=2,
                  skip_empty_rows = TRUE,
                  col_names=TRUE,col_types=list("Button Down"=col_skip(),"Button Up"=col_skip(),
                                                "Host Connect"=col_skip(),"Stopped"=col_skip(),"EOF"=col_skip()))
Tnk8 <- drop_na(Tnk8)
Tnk8 <- Tnk8 %>%
  rename(Tnk8_TmpF = `Temp, (*F)`)
Tnk9 <- read_csv("HOBO/20191107/TNK-9-SN20565257 2019-11-07 15_19_25 -0800.csv",
                 skip=2,
                 skip_empty_rows = TRUE,
                 col_names=TRUE,col_types=list("Button Down"=col_skip(),"Button Up"=col_skip(),
                                               "Host Connect"=col_skip(),"Stopped"=col_skip(),"EOF"=col_skip()))
Tnk9 <- drop_na(Tnk9)
Tnk9 <- Tnk9 %>%
  rename(Tnk9_TmpF = `Temp, (*F)`)
Tnk10 <- read_csv("HOBO/20191107/TNK-10-SN20565258 2019-11-07 15_18_45 -0800.csv",
                  skip=2,
                  skip_empty_rows = TRUE,
                  col_names=TRUE,col_types=list("Button Down"=col_skip(),"Button Up"=col_skip(),
                                                "Host Connect"=col_skip(),"Stopped"=col_skip(),"EOF"=col_skip()))
Tnk10 <- drop_na(Tnk10)
Tnk10 <- Tnk10 %>%
  rename(Tnk10_TmpF = `Temp, (*F)`)
Tnk11 <- read_csv("HOBO/20191107/TNK-11-SN20565259 2019-11-07 15_14_56 -0800.csv",
                  skip=2,
                  skip_empty_rows = TRUE,
                  col_names=TRUE,col_types=list("Button Down"=col_skip(),"Button Up"=col_skip(),
                                                "Host Connect"=col_skip(),"Stopped"=col_skip(),"EOF"=col_skip()))
Tnk11 <- drop_na(Tnk11)
Tnk11 <- Tnk11 %>%
  rename(Tnk11_TmpF = `Temp, (*F)`)
Tnk12 <- read_csv("HOBO/20191107/Tnk-12-SN20555858 2019-11-07 15_15_21 -0800.csv",
                  skip=2,
                  skip_empty_rows = TRUE,
                  col_names=TRUE,col_types=list("Button Down"=col_skip(),"Button Up"=col_skip(),
                                                "Host Connect"=col_skip(),"Stopped"=col_skip(),"EOF"=col_skip()))
Tnk12 <- drop_na(Tnk12)
Tnk12 <- Tnk12 %>%
  rename(Tnk12_TmpF = `Temp, (*F)`)
Tnk13 <- read_csv("HOBO/20191107/TNK-13-SN20565261 2019-11-07 15_20_57 -0800.csv",
                  skip=2,
                  skip_empty_rows = TRUE,
                  col_names=TRUE,col_types=list("Button Down"=col_skip(),"Button Up"=col_skip(),
                                                "Host Connect"=col_skip(),"Stopped"=col_skip(),"EOF"=col_skip()))
Tnk13 <- drop_na(Tnk13)
Tnk13 <- Tnk13 %>%
  rename(Tnk13_TmpF = `Temp, (*F)`)
Tnk14 <- read_csv("HOBO/20191107/TNK-14-SN20565262 2019-11-07 15_21_31 -0800.csv",
                  skip=2,
                  skip_empty_rows = TRUE,
                  col_names=TRUE,col_types=list("Button Down"=col_skip(),"Button Up"=col_skip(),
                                                "Host Connect"=col_skip(),"Stopped"=col_skip(),"EOF"=col_skip()))
Tnk14 <- drop_na(Tnk14)
Tnk14 <- Tnk14 %>%
  rename(Tnk14_TmpF = `Temp, (*F)`)
Tnk15 <- read_csv("HOBO/20191107/TNK-15-SN20565263 2019-11-07 15_15_45 -0800.csv",
                  skip=2,
                  skip_empty_rows = TRUE,
                  col_names=TRUE,col_types=list("Button Down"=col_skip(),"Button Up"=col_skip(),
                                                "Host Connect"=col_skip(),"Stopped"=col_skip(),"EOF"=col_skip()))
Tnk15 <- drop_na(Tnk15)
Tnk15 <- Tnk15 %>%
  rename(Tnk15_TmpF = `Temp, (*F)`)
Tnk16 <- read_csv("HOBO/20191107/TNK-16-SN20565264 2019-11-07 15_16_08 -0800.csv",
                  skip=2,
                  skip_empty_rows = TRUE,
                  col_names=TRUE,col_types=list("Button Down"=col_skip(),"Button Up"=col_skip(),
                                                "Host Connect"=col_skip(),"Stopped"=col_skip(),"EOF"=col_skip()))
Tnk16 <- drop_na(Tnk16)
Tnk16 <- Tnk16 %>%
  rename(Tnk16_TmpF = `Temp, (*F)`)
Tnk17 <- read_csv("HOBO/20191107/TNK-17-SN20565265 2019-11-07 15_26_03 -0800.csv",
                  skip=2,
                  skip_empty_rows = TRUE,
                  col_names=TRUE,col_types=list("Button Down"=col_skip(),"Button Up"=col_skip(),
                                                "Host Connect"=col_skip(),"Stopped"=col_skip(),"EOF"=col_skip()))
Tnk17 <- drop_na(Tnk17)
Tnk17 <- Tnk17 %>%
  rename(Tnk17_TmpF = `Temp, (*F)`)
Tnk18 <- read_csv("HOBO/20191107/TNK-18-SN20569983 2019-11-07 15_28_00 -0800.csv",
                  skip=2,
                  skip_empty_rows = TRUE,
                  col_names=TRUE,col_types=list("Button Down"=col_skip(),"Button Up"=col_skip(),
                                                "Host Connect"=col_skip(),"Stopped"=col_skip(),"EOF"=col_skip()))
Tnk18 <- drop_na(Tnk18)
Tnk18 <- Tnk18 %>%
  rename(Tnk18_TmpF = `Temp, (*F)`)
Tnk19 <- read_csv("HOBO/20191107/TNK-19-SN20555869 2019-11-07 15_13_09 -0800.csv",
                           skip=2,
                           skip_empty_rows = TRUE,
                           col_names=TRUE,col_types=list("Button Down"=col_skip(),"Button Up"=col_skip(),
                                                         "Host Connect"=col_skip(),"Stopped"=col_skip(),"EOF"=col_skip()))
Tnk19 <- drop_na(Tnk19)
Tnk19 <- Tnk19 %>%
  rename(Tnk19_TmpF = `Temp, (*F)`)
Tnk19 <- separate(Tnk19,"Date Time, GMT -0700", into=c("Date","Time"), sep = " ", remove = TRUE)
Tnk20 <- read_csv("HOBO/20191107/TNK-20-SN20569985 2019-11-07 15_12_50 -0800.csv",
                  skip=2,
                  skip_empty_rows = TRUE,
                  col_names=TRUE,col_types=list("Button Down"=col_skip(),"Button Up"=col_skip(),
                                                "Host Connect"=col_skip(),"Stopped"=col_skip(),"EOF"=col_skip()))
Tnk20 <- drop_na(Tnk20)
Tnk20 <- Tnk20 %>%
  rename(Tnk20_TmpF = `Temp, (*F)`)
Tnk20 <- separate(Tnk20,"Date Time, GMT -0700", into=c("Date","Time"), sep = " ", remove = TRUE)

##############
# DO NOT CHANGE THIS SECTION
# Merge all Temp data into one dataframe
Hobo_All <- merge(x = Tnk19, y = Tnk20, by = "Date", all = TRUE)
Hobo_All <- merge(x = Tnk19, y = Tnk20, by = "Date Time, GMT -0700", all = TRUE)
Hobo_All <- merge(x = Tnk18, y = Hobo_All, by = "Date Time, GMT -0700", all = TRUE)
Hobo_All <- merge(x = Tnk17, y = Hobo_All, by = "Date Time, GMT -0700", all = TRUE)
Hobo_All <- merge(x = Tnk16, y = Hobo_All, by = "Date Time, GMT -0700", all = TRUE)
Hobo_All <- merge(x = Tnk15, y = Hobo_All, by = "Date Time, GMT -0700", all = TRUE)
Hobo_All <- merge(x = Tnk14, y = Hobo_All, by = "Date Time, GMT -0700", all = TRUE)
Hobo_All <- merge(x = Tnk13, y = Hobo_All, by = "Date Time, GMT -0700", all = TRUE)
Hobo_All <- merge(x = Tnk12, y = Hobo_All, by = "Date Time, GMT -0700", all = TRUE)
Hobo_All <- merge(x = Tnk11, y = Hobo_All, by = "Date Time, GMT -0700", all = TRUE)
Hobo_All <- merge(x = Tnk10, y = Hobo_All, by = "Date Time, GMT -0700", all = TRUE)
Hobo_All <- merge(x = Tnk9, y = Hobo_All, by = "Date Time, GMT -0700", all = TRUE)
Hobo_All <- merge(x = Tnk8, y = Hobo_All, by = "Date Time, GMT -0700", all = TRUE)
Hobo_All <- merge(x = Tnk7, y = Hobo_All, by = "Date Time, GMT -0700", all = TRUE)
Hobo_All <- merge(x = Tnk6, y = Hobo_All, by = "Date Time, GMT -0700", all = TRUE)
Hobo_All <- merge(x = Tnk5, y = Hobo_All, by = "Date Time, GMT -0700", all = TRUE)
Hobo_All <- merge(x = Tnk4, y = Hobo_All, by = "Date Time, GMT -0700", all = TRUE)
Hobo_All <- merge(x = Tnk3, y = Hobo_All, by = "Date Time, GMT -0700", all = TRUE)
Hobo_All <- merge(x = Tnk2, y = Hobo_All, by = "Date Time, GMT -0700", all = TRUE)
Hobo_All <- merge(x = Tnk1, y = Hobo_All, by = "Date Time, GMT -0700", all = TRUE)
# Split Date and Time into separate columns
Hobo_All <- separate(Hobo_All,"Date Time, GMT -0700", into=c("Date","Time"), sep = " ", remove = TRUE)
View(Hobo_All)

##############
# CHANGE FILE DATE BEFORE WRITING CSV
#write_csv(Hobo_All,"HOBO/Tidy/HOBOLog_20191024.csv")
