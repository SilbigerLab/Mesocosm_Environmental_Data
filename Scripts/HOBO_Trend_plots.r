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
folder.date<- "20200803"
datalog<-read_csv(paste0("Data/HOBO_loggers/",folder.date,"/HOBOLog_20200803.csv"),na=(c("NA", "")))

datalog<-datalog%>%
  select(-c('Intensity, ( lux)',Tmp-6,Tmp-11))

# start date and time of data logging
startLog<-parse_datetime("2020-07-30 01:00:00",format = "%Y-%m-%d %H:%M:%S", na=character(),
                         locale = locale(tz = ""), trim_ws = TRUE)
# end date and time of data logging
endLog<-parse_datetime("2020-08-04 14:43:00",format = "%Y-%m-%d %H:%M:%S", na=character(),
                       locale = locale(tz = ""), trim_ws = TRUE)

# parse date_time to POSIXct
datalog$Date<-datalog$Date%>%
  as.POSIXct(format = "%F %T", na=character(), tz="",
                 locale = locale(tz = ""), trim_ws = TRUE)
# filter out "test time" data
datalog<-datalog%>%
  filter((Date>=startLog) & (Date<=endLog))
# hobos are logging time at GMT-7 while Apex's reading GMT-8
datalog$Date<-datalog$Date + hours(1)

# Create long-form dataframe from datalog
datalog<-datalog%>%
  pivot_longer(cols = -c(Date), names_to = "Tank",values_to = "Value",values_drop_na = TRUE)


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
  rbind(El.stable,Am.oc,El.oc)%>%
  arrange(Date)
meanlog<-datalog%>%
  group_by(Date,Treatment)%>%
  summarise(mean=mean(Value),SE=std.error(Value))


#####################
# Plotting Raw Treatment Plots
#####################
# All treatments
plot1<-ggplot(data=datalog, aes(x=Date, y=Value, colour=Tank))+
  geom_line()+
  theme_bw()+
  facet_wrap(ncol=1,~Treatment, scales="free_y")+
  labs(x="Date",y="TempC",title="Raw Hobo Temperatures per Treatment")+
  ggsave(paste0("Output/",folder.date,"/Hobo_rawValues_perTreatment_plot.png"),width=11,height=7)
# By treatment
plot2<-ggplot(data=Am.stable, aes(x=Date, y=Value, colour=Tank))+
  geom_line()+
  theme_bw()+
  labs(x="Date",y="TempC",title="Raw Hobo Temperatures",subtitle="Ambient Stable Treatment")+
  ggsave(paste0("Output/",folder.date,"/Hobo_Ambient_Stable_plot.png"),width=11,height=6)
plot3<-ggplot(data=El.stable, aes(x=Date, y=Value, colour=Tank))+
  geom_line()+
  theme_bw()+
  labs(x="Date",y="TempC",title="Raw Hobo Temperatures",subtitle="Elevated Stable Treatment")+
  ggsave(paste0("Output/",folder.date,"/Hobo_Elevated_Stable_plot.png"),width=11,height=6)
plot4<-ggplot(data=Am.oc, aes(x=Date, y=Value, colour=Tank))+
  geom_line()+
  theme_bw()+
  labs(x="Date",y="TempC",title="Raw Hobo Temperatures",subtitle="Ambient Oscillating Treatment")+
  ggsave(paste0("Output/",folder.date,"/Hobo_Ambient_Oscillating_plot.png"),width=11,height=6)
plot5<-ggplot(data=El.oc, aes(x=Date, y=Value, colour=Tank))+
  geom_line()+
  theme_bw()+
  labs(x="Date",y="TempC",title="Raw Hobo Temperatures",subtitle="Elevated Oscillating Treatment")+
  ggsave(paste0("Output/",folder.date,"/Hobo_Elevated_Oscillating_plot.png"),width=11,height=6)


#####################
# Plotting Mean Treatment Plots
#####################
# Without Error Bars
plot6<-ggplot(data=meanlog, aes(x=Date, y=mean, colour=Treatment))+
  geom_line()+
  theme_bw()+
  facet_wrap(ncol=1,~Treatment, scales="free_y")+
  labs(x="Date",y="Mean TempC",
       title="Mean Hobo Temperatures per Treatment",subtitle="Without Standard Error")+
  ggsave(paste0("Output/",folder.date,"/Hobo_meanValues_perTreatment_noSE_plot.png"),width=11,height=7)
# With Error Bars
plot7<-ggplot(data=meanlog, aes(x=Date, y=mean, colour=Treatment))+
  geom_line()+
  theme_bw()+
  geom_errorbar(aes(ymin=mean-SE,ymax=mean+SE),width=0.2,position="identity")+
  facet_wrap(ncol=1,~Treatment, scales="free_y")+
  labs(x="Date",y="Mean TempC",title="Mean Hobo Temperatures per Treatment",subtitle="With Standard Error")+
  ggsave(paste0("Output/",folder.date,"/Hobo_meanValues_perTreatment_SE_plot.png"),width=11,height=7)


