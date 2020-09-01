# Organizing HOBO data for plotting over time

# written by Danielle Barnas
# created 1/30/2020
# last updated 9/01/2020

# clean environment
rm(list=ls())

# Load libraries
library(tidyverse)
library(lubridate)
library(plotrix)

#####################
# Load data
#####################
folder.date<- "20200830"
datalog<-read_csv(paste0("Data/HOBO_loggers/Amanda_Hobo_Logs.csv"),na=(c("NA", "")))

#datalog<-datalog%>%
#  select(-c('Intensity, ( lux)'))

# start date and time of data logging
startLog<-parse_datetime("2020-08-14 00:00:00",format = "%Y-%m-%d %H:%M:%S", na=character(),
                         locale = locale(tz = ""), trim_ws = TRUE)
# end date and time of data logging
endLog<-parse_datetime("2020-08-30 00:00:00",format = "%Y-%m-%d %H:%M:%S", na=character(),
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
  filter((Tank=="Hobo-Tmp-1"|Tank=="Hobo-Tmp-5"|Tank=="Hobo-Tmp-9"|Tank=="Hobo-Tmp-13"|Tank=="Hobo-Tmp-17"))%>%
  mutate(Treatment="Ambient.Stable")
El.stable<-datalog%>% # elevated stable temperature
  filter((Tank=="Hobo-Tmp-2"|Tank=="Hobo-Tmp-6"|Tank=="Hobo-Tmp-10"|Tank=="Hobo-Tmp-14"|Tank=="Hobo-Tmp-18"))%>%
  mutate(Treatment="Elevated.Stable")
Am.oc<-datalog%>% # ambient temperature oscillations
  filter((Tank=="Hobo-Tmp-3"|Tank=="Hobo-Tmp-7"|Tank=="Hobo-Tmp-11"|Tank=="Hobo-Tmp-15"|Tank=="Hobo-Tmp-19"))%>%
  mutate(Treatment="Ambient.Oscillating")
El.oc<-datalog%>% # elevated temperature oscillations
  filter((Tank=="Hobo-Tmp-4"|Tank=="Hobo-Tmp-8"|Tank=="Hobo-Tmp-12"|Tank=="Hobo-Tmp-16"|Tank=="Hobo-Tmp-20"))%>%
  mutate(Treatment="Elevated.Oscillating")

# bind all rows to combine treatment data and summarise data by Date and Treatment
datalog<-Am.stable%>%
  rbind(El.stable,Am.oc,El.oc)%>%
  arrange(Date)
meanlog<-datalog%>%
  group_by(Date,Treatment)%>%
  summarise(mean=mean(Value),SE=std.error(Value))

oscilate<-Am.oc%>%
  rbind(El.oc)%>%
  arrange(Date)
stable<-Am.stable%>%
  rbind(El.stable)%>%
  arrange(Date)

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


#####################
# Plotting Oscillating or Stable
#####################
# Oscilating treatments
plot8<-ggplot(data=oscilate, aes(x=Date, y=Value, colour=Tank))+
  geom_line()+
  theme_bw()+
  facet_wrap(ncol=1,~Treatment, scales="fixed")+
  labs(x="Date",y="TempC",title="Raw Hobo Oscillating Treatment Temperatures")+
  ggsave(paste0("Output/",folder.date,"/Hobo_rawValues_Oscilating_plot.png"),width=11,height=7)
# Stable treatments
plot9<-ggplot(data=stable, aes(x=Date, y=Value, colour=Tank))+
  geom_line()+
  theme_bw()+
  facet_wrap(ncol=1,~Treatment, scales="fixed")+
  labs(x="Date",y="TempC",title="Raw Hobo Stable Treatment Temperatures")+
  ggsave(paste0("Output/",folder.date,"/Hobo_rawValues_Stable_plot.png"),width=11,height=7)


