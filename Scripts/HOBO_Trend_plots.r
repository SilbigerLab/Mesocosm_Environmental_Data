# Organizing HOBO data for plotting over time

# clean environment
rm(list=ls())

# Load libraries
library(tidyverse)
library(ggplot2)
library(lubridate)
library(plotrix)

#####################
# Load data
#####################
datalog<-read_csv("Data/HOBO_loggers/20200731/HOBOLog_20200731.csv")
date<- "20200731" # today's date (used for Output folder)

# start date and time of data logging
startLog<-parse_datetime("2020-07-30 01:00:00",format = "%F %T", na=character(),
               locale = locale(tz = ""), trim_ws = TRUE)
# end date and time of data logging
endLog<-parse_datetime("2020-07-31 14:43:00",format = "%F %T", na=character(),
               locale = locale(tz = ""), trim_ws = TRUE)

# rename for simpler column management
datalog<-datalog%>%
  rename(Date_time='Date Time, GMT -0700')
# parse date_time to POSIXct
datalog$Date_time<-datalog$Date_time%>%
  as.POSIXct(format = "%F %T", na=character(), tz="",
                 locale = locale(tz = ""), trim_ws = TRUE)
# filter out "test time" data
datalog<-datalog%>%
  filter((Date_time>=startLog) & (Date_time<=endLog))
# hobos are logging time at GMT-7 while Apex's reading GMT-8
datalog$Date_time<-datalog$Date_time + hours(1)

# Create long-form dataframe from datalog
datalog<-datalog%>%
  pivot_longer(cols = -c(Date_time), names_to = "Tank",values_to = "Temp_C",values_drop_na = TRUE)


#####################
# split data by treatment type
#####################
Am.stable<-datalog%>% # ambient stable temperature
  filter((Tank=="Tnk1_TmpC"|Tank=="Tnk5_TmpC"|Tank=="Tnk9_TmpC"|Tank=="Tnk13_TmpC"|Tank=="Tnk17_TmpC"))%>%
  mutate(Treatment="Ambient.Stable")
El.stable<-datalog%>% # elevated stable temperature
  filter((Tank=="Tnk2_TmpC"|Tank=="Tnk6_TmpC"|Tank=="Tnk10_TmpC"|Tank=="Tnk14_TmpC"|Tank=="Tnk18_TmpC"))%>%
  mutate(Treatment="Elevated.Stable")
Am.oc<-datalog%>% # ambient temperature oscillations
  filter((Tank=="Tnk3_TmpC"|Tank=="Tnk7_TmpC"|Tank=="Tnk11_TmpC"|Tank=="Tnk15_TmpC"|Tank=="Tnk19_TmpC"))%>%
  mutate(Treatment="Ambient.Oscillating")
El.oc<-datalog%>% # elevated temperature oscillations
  filter((Tank=="Tnk4_TmpC"|Tank=="Tnk8_TmpC"|Tank=="Tnk12_TmpC"|Tank=="Tnk16_TmpC"|Tank=="Tnk20_TmpC"))%>%
  mutate(Treatment="Elevated.Oscillating")

# bind all rows to combine treatment data and summarise data by Date and Treatment
datalog<-Am.stable%>%
  rbind(El.stable,Am.oc,El.oc)%>% # combine all treatment data
  arrange(Date_time)%>%
  group_by(Date_time,Treatment)%>%
  summarise(mean=mean(Temp_C),SE=std.error(Temp_C)) #create columns for mean and standard error of remaining data


#####################
# plotting the data
#####################
plot1<-ggplot(data=datalog, aes(x=Date_time, y=mean, colour=Treatment))+
  geom_line(aes(colour=Treatment))+
  facet_wrap(ncol=1,~Treatment, scales="free_y")+
  labs(x="Date",y="Mean TempC")+
  ggsave(paste0("Output/",date,"/HOBO_TreatmentPlots_faceted.png"))
plot1

plot2<-ggplot(data=datalog, aes(x=Date_time, y=mean, colour=Treatment))+
  geom_line(aes(colour=Treatment))+
  geom_errorbar(aes(ymin=mean-SE,ymax=mean+SE),width=0.1,position="identity")+
  facet_wrap(ncol=1,~Treatment, scales="free_y")+
  labs(x="Date",y="Mean TempC")
plot2

plot3<-ggplot(data=datalog, aes(x=Date_time, y=mean, colour=Treatment))+
  geom_line(aes(colour=Treatment))+
  labs(x="Date",y="Mean TempC")+
  ggsave(paste0("Output/",date,"/HOBO_TreatmentPlot.png"))
plot3

plot4<-ggplot(data=datalog, aes(x=Date_time, y=mean, colour=Treatment))+
  geom_line(aes(colour=Treatment))+
  geom_errorbar(aes(ymin=mean-SE,ymax=mean+SE),width=0.1,position="identity")+
  labs(x="Date",y="Mean TempC")
plot4

