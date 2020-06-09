
# Load libraries
library(tidyverse)
library(ggplot2)
library(lubridate)
library(plotrix)

#clean environment
rm(list=ls())

# Bring in data
datalog<-read_csv("Data/Apex_DataLogs/Apex_temp_pH_Datalog.csv")
# Unite Date and Time into one column
datalog<-datalog%>%
  unite("Date",Date:Time, sep=" ",remove=TRUE)%>%
  filter((Probe!="Tmp-5"|Probe!="Tmp-6"|Probe!="pH-5"|Probe!="pH-6"))
# Parse Date Time column to POSIX
datalog$Date<-datalog$Date%>%
  parse_datetime(format = "%Y-%m-%d %H:%M:%S", na=character(),
                 locale = default_locale(), trim_ws = TRUE)

# categorize treatments
log.Oc<-datalog%>%
  filter((Probe=="Tmp-1"|Probe=="Tmp-2"|Probe=="Tmp-17"|Probe=="Tmp-18"|Probe=="Tmp-19"|Probe=="Tmp-20"|
           Probe=="pH-1"|Probe=="pH-2"|Probe=="pH-17"|Probe=="pH-18"|Probe=="pH-19"|Probe=="pH-20"))%>% #oscillating treatment tanks
  mutate(Treatment="Oscillating")
log.Low<-datalog%>%
  filter((Probe=="Tmp-3"|Probe=="Tmp-4"|Probe=="Tmp-7"|Probe=="Tmp-8"|Probe=="Tmp-9"|Probe=="Tmp-10")|
           (Probe=="pH-3"|Probe=="pH-4"|Probe=="pH-7"|Probe=="pH-8"|Probe=="pH-9"|Probe=="pH-10"))%>% #low pH treatment tanks
  mutate(Treatment="Low")
log.Am<-datalog%>%
  filter((Probe=="Tmp-11"|Probe=="Tmp-12"|Probe=="Tmp-13"|Probe=="Tmp-14"|Probe=="Tmp-15"|Probe=="Tmp-16")|
           (Probe=="pH-11"|Probe=="pH-12"|Probe=="pH-13"|Probe=="pH-14"|Probe=="pH-15"|Probe=="pH-16"))%>% #ambient treatment tanks
  mutate(Treatment="Ambient")

# bind all rows to combine treatment data, summarise data by Date, Type, and Treatment, and filter by date
datalog<-log.Oc%>%
  rbind(log.Low,log.Am)%>%
  arrange(Date)%>%
  group_by(Date,Type,Treatment)%>%
  summarise(mean=mean(Value),SE=std.error(Value))%>%
  filter((Date>="2020-02-05 6:00") & (Date<="2020-02-20")) # filter by dates

# separate temp and pH data
tempdata<-datalog%>%
  filter(Type=="Temp")
phdata<-datalog%>%
  filter(Type=="pH")

# All plots
plot<-ggplot(data=datalog, aes(x=Date, y=mean, colour=Treatment))+
  geom_line(aes(colour=Treatment))+
  geom_errorbar(aes(ymin=mean-SE,ymax=mean+SE),width=0.2,
                position=position_dodge(0.05))+
  facet_wrap(ncol=1,~Treatment+Type, scales="free_y")+
  ggsave("Output/20200607/plot_error.png")
# Temp plot
Tempplot<-ggplot(data=tempdata, aes(x=Date, y=mean, colour=Treatment))+
  geom_line(aes(colour=Treatment))+
  geom_errorbar(aes(ymin=mean-SE,ymax=mean+SE),width=0.2,
                position=position_dodge(0.05))+
  facet_wrap(ncol=1,~Treatment+Type, scales="free_y")+
  ggsave("Output/20200607/tempplot_error.png")
# pH plot
pHplot<-ggplot(data=phdata, aes(x=Date, y=mean, colour=Treatment))+
  geom_line(aes(colour=Treatment))+
  geom_errorbar(aes(ymin=mean-SE,ymax=mean+SE),width=0.2,
                position=position_dodge(0.05))+
  facet_wrap(ncol=1,~Treatment+Type, scales="free_y")+
  ggsave("Output/20200607/pHplot_error.png")

#average time series of all tanks by treatment, 3 subplots next to each other
#take avg and std error 
#delete wonky data prior to feb 1 ish

#view outliers
datalog%>%
  filter((Type=="Temp")&(Treatment=="Oscillating")&(Value>17.2))
