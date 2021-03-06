# Organizing Raw Apex data for readability and plotting over time

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
# Load Data
#####################
datalog<-read_csv("Data/Apex_DataLogs/Apex_temp_pH_Datalog.csv")
folder.date<- "20200803"

# start date and time of data logging
startLog<-parse_datetime("2020-07-30 01:00:00",format = "%Y-%m-%d %H:%M:%S", na=character(),
                         locale = locale(tz = ""), trim_ws = TRUE)
# end date and time of data logging
endLog<-parse_datetime("2020-08-04 14:43:00",format = "%Y-%m-%d %H:%M:%S", na=character(),
                       locale = locale(tz = ""), trim_ws = TRUE)

# Unite Date and Time into one column
datalog<-datalog%>%
  unite("Date",Date:Time, sep=" ",remove=TRUE)
# Parse Date Time column to POSIX
datalog$Date<-datalog$Date%>%
  parse_datetime(format = "%Y-%m-%d %H:%M:%S", na=character(),
                 locale = default_locale(), trim_ws = TRUE)

# filter out "test time" data
datalog<-datalog%>%
  filter((Date>=startLog) & (Date<=endLog))

#####################
# Categorize Treatments, Separated by Probes
#####################
Am.stable<-datalog%>% # ambient stable temperature
  filter((Probe=="Tmp-1"|Probe=="Tmp-5"|Probe=="Tmp-9"|Probe=="Tmp-13"|Probe=="Tmp-17"#|
  ))%>%#      Probe=="pH-1"|Probe=="pH-5"|Probe=="pH-9"|Probe=="pH-13"|Probe=="pH-17")) %>%
  mutate(Treatment="Ambient.Stable")
El.stable<-datalog%>% # elevated stable temperature
  filter((Probe=="Tmp-2"|Probe=="Tmp-6"|Probe=="Tmp-10"|Probe=="Tmp-14"|Probe=="Tmp-18"#|
  ))%>%#      Probe=="pH-2"|Probe=="pH-6"|Probe=="pH-10"|Probe=="pH-14"|Probe=="pH-18")) %>%
  mutate(Treatment="Elevated.Stable")
Am.oc<-datalog%>% # ambient temperature oscillations
  filter((Probe=="Tmp-3"|Probe=="Tmp-7"|Probe=="Tmp-11"|Probe=="Tmp-15"|Probe=="Tmp-19"#|
  ))%>%#      Probe=="pH-1"|Probe=="pH-5"|Probe=="pH-9"|Probe=="pH-13"|Probe=="pH-17")) %>%
  mutate(Treatment="Ambient.Oscillating")
El.oc<-datalog%>% # elevated temperature oscillations
  filter((Probe=="Tmp-4"|Probe=="Tmp-8"|Probe=="Tmp-12"|Probe=="Tmp-16"|Probe=="Tmp-20"#|
  ))%>%#      Probe=="pH-1"|Probe=="pH-5"|Probe=="pH-9"|Probe=="pH-13"|Probe=="pH-17")) %>%
  mutate(Treatment="Elevated.Oscillating")

# bind all rows to combine treatment data, summarise data by Date, Type, and Treatment, and filter by date
datalog<-Am.stable%>%
  rbind(El.stable,Am.oc,El.oc)%>%
  arrange(Date)
meanlog<-datalog%>%
  group_by(Date,Type,Treatment)%>%
  summarise(mean=mean(Value),SE=std.error(Value))

oscilate<-Am.oc%>%
  rbind(El.oc)%>%
  arrange(Date)
stable<-Am.stable%>%
  rbind(El.stable)%>%
  arrange(Date)

#####################
# Removing Outliers
#####################
## Add column for difference in value from previous recorded value
# datalog<-datalog%>%
#   group_by(Type,Probe)%>%
#   arrange(Date)%>%
#   mutate(Delta=Value-lag(Value,default=first(Value))) #substracts a value from the previous value for change over a single time point

## isolate and remove outliers (off-values during calibrations or other non-representative data)
# outlier<-datalog%>%
#   filter(Type=="pH")%>%
#   filter((Delta>=0.15)|(Delta<=(-0.15))) # filter extreme values
# outlier # view head of dataframe
# datalog<-datalog%>%
#   anti_join(outlier, by=c("Date","Probe"))%>% #remove outliers
#   group_by(Date,Type,Treatment)%>%
#   summarise(mean=mean(Value),SE=std.error(Value)) #create columns for mean and standard error of remaining data

#####################
# Plotting Raw Treatment Plots
#####################
# All treatments
plot1<-ggplot(data=datalog, aes(x=Date, y=Value, colour=Probe))+
  geom_line()+
  theme_bw()+
  facet_wrap(ncol=1,~Treatment, scales="free_y")+
  labs(x="Date",y="TempC",title="Raw Apex Temperatures per Treatment")+
  ggsave(paste0("Output/",folder.date,"/Apex_rawValues_perTreatment_plot.png"),width=11,height=7)
# By treatment
plot2<-ggplot(data=Am.stable, aes(x=Date, y=Value, colour=Probe))+
  geom_line()+
  theme_bw()+
  labs(x="Date",y="TempC",title="Raw Apex Temperatures",subtitle="Ambient Stable Treatment")+
  ggsave(paste0("Output/",folder.date,"/Apex_Ambient_Stable_plot.png"),width=11,height=6)
plot3<-ggplot(data=El.stable, aes(x=Date, y=Value, colour=Probe))+
  geom_line()+
  theme_bw()+
  labs(x="Date",y="TempC",title="Raw Apex Temperatures",subtitle="Elevated Stable Treatment")+
  ggsave(paste0("Output/",folder.date,"/Apex_Elevated_Stable_plot.png"),width=11,height=6)
plot4<-ggplot(data=Am.oc, aes(x=Date, y=Value, colour=Probe))+
  geom_line()+
  theme_bw()+
  labs(x="Date",y="TempC",title="Raw Apex Temperatures",subtitle="Ambient Oscillating Treatment")+
  ggsave(paste0("Output/",folder.date,"/Apex_Ambient_Oscillating_plot.png"),width=11,height=6)
plot5<-ggplot(data=El.oc, aes(x=Date, y=Value, colour=Probe))+
  geom_line()+
  theme_bw()+
  labs(x="Date",y="TempC",title="Raw Apex Temperatures",subtitle="Elevated Oscillating Treatment")+
  ggsave(paste0("Output/",folder.date,"/Apex_Elevated_Oscillating_plot.png"),width=11,height=6)


#####################
# Plotting Mean Treatment Plots
#####################
# Without Error Bars
plot6<-ggplot(data=meanlog, aes(x=Date, y=mean, colour=Treatment))+
  geom_line()+
  theme_bw()+
  facet_wrap(ncol=1,~Treatment+Type, scales="free_y")+
  labs(x="Date",y="Mean TempC",title="Mean Apex Temperatures per Treatment",subtitle="Without Standard Error")+
  ggsave(paste0("Output/",folder.date,"/Apex_meanValues_perTreatment_noSE_plot.png"),width=11,height=7)
# With Error Bars
plot7<-ggplot(data=meanlog, aes(x=Date, y=mean, colour=Treatment))+
  geom_line()+
  theme_bw()+
  geom_errorbar(aes(ymin=mean-SE,ymax=mean+SE),width=0.2,position="identity")+
  facet_wrap(ncol=1,~Treatment+Type, scales="free_y")+
  labs(x="Date",y="Mean TempC",title="Mean Apex Temperatures per Treatment",subtitle="With Standard Error")+
  ggsave(paste0("Output/",folder.date,"/Apex_meanValues_perTreatment_SE_plot.png"),width=11,height=7)


#####################
# Plotting Oscillating or Stable
#####################
# Oscilating treatments
plot8<-ggplot(data=oscilate, aes(x=Date, y=Value, colour=Tank))+
  geom_line()+
  theme_bw()+
  facet_wrap(ncol=1,~Treatment, scales="fixed")+
  labs(x="Date",y="TempC",title="Raw Apex Oscillating Treatment Temperatures")+
  ggsave(paste0("Output/",folder.date,"/Apex_rawValues_Oscilating_plot.png"),width=11,height=7)
# Stable treatments
plot9<-ggplot(data=stable, aes(x=Date, y=Value, colour=Tank))+
  geom_line()+
  theme_bw()+
  facet_wrap(ncol=1,~Treatment, scales="fixed")+
  labs(x="Date",y="TempC",title="Raw Apex Stable Treatment Temperatures")+
  ggsave(paste0("Output/",folder.date,"/Apex_rawValues_Stable_plot.png"),width=11,height=7)


