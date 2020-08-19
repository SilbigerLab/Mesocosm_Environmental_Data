# Plot Apex data against Hobo Data

# written by Danielle Barnas
# created 7/25/2020
# last updated 8/17/20

# clean environment
rm(list=ls())

# Load libraries
library(tidyverse)
library(ggplot2)
library(lubridate)
library(plotrix)

######################

folder.date<-"20200817" # Output folder name

######################
# Load Hobo Data
######################

hobolog<-read_csv(paste0("Data/HOBO_loggers/",folder.date,"/HOBOLog_",folder.date,".csv"),na=(c("NA", "")))
hobolog<-hobolog%>%
  select(-c('Intensity, ( lux)'))

# start date and time of data logging
startLog<-parse_datetime("2020-08-14 00:00:00",format = "%F %T", na=character(),
                         locale = locale(tz = ""), trim_ws = TRUE)
# end date and time of data logging
endLog<-parse_datetime("2020-08-17 14:32:00",format = "%F %T", na=character(),
                       locale = locale(tz = ""), trim_ws = TRUE)

###leave below the same###
# parse date_time to POSIXct
hobolog$Date<-hobolog$Date%>%
  as.POSIXct(format = "%F %T", na=character(), tz="", locale = locale(tz = ""), trim_ws = TRUE)
# filter out "test time" data
hobolog<-hobolog%>%
  filter((Date>=startLog) & (Date<=endLog))
# Create long-form dataframe from datalog
hobolog<-hobolog%>%
  pivot_longer(cols = -c(Date), names_to = "Tank",values_to = "Value",values_drop_na = TRUE)%>%
  mutate(Type="Temp")

#####################
# split Hobo data by treatment type
#####################
h.Am.stable<-hobolog%>% # ambient stable temperature
  filter((Tank=="Hobo-Tmp-1"|Tank=="Hobo-Tmp-5"|Tank=="Hobo-Tmp-9"|Tank=="Hobo-Tmp-13"|Tank=="Hobo-Tmp-17"))%>%
  mutate(Treatment="Ambient.Stable")
h.El.stable<-hobolog%>% # elevated stable temperature
  filter((Tank=="Hobo-Tmp-2"|Tank=="Hobo-Tmp-6"|Tank=="Hobo-Tmp-10"|Tank=="Hobo-Tmp-14"|Tank=="Hobo-Tmp-18"))%>%
  mutate(Treatment="Elevated.Stable")
h.Am.oc<-hobolog%>% # ambient temperature oscillations
  filter((Tank=="Hobo-Tmp-3"|Tank=="Hobo-Tmp-7"|Tank=="Hobo-Tmp-11"|Tank=="Hobo-Tmp-15"|Tank=="Hobo-Tmp-19"))%>%
  mutate(Treatment="Ambient.Oscillating")
h.El.oc<-hobolog%>% # elevated temperature oscillations
  filter((Tank=="Hobo-Tmp-4"|Tank=="Hobo-Tmp-8"|Tank=="Hobo-Tmp-12"|Tank=="Hobo-Tmp-16"|Tank=="Hobo-Tmp-20"))%>%
  mutate(Treatment="Elevated.Oscillating")
# bind all rows to combine treatment data and summarise data by Date and Treatment
hobolog<-h.Am.stable%>%
  rbind(h.El.stable,h.Am.oc,h.El.oc)%>%
  arrange(Date)%>%
  mutate(Source="HOBO")
hobomean<-hobolog%>%
  group_by(Date,Type,Treatment,Source)%>%
  summarise(mean=mean(Value),SE=std.error(Value))


######################
# Load Apex Data
######################

apexlog<-read_csv("Data/Apex_DataLogs/Apex_temp_pH_Datalog.csv")
# Unite Date and Time into one column
apexlog<-apexlog%>%
  unite("Date",Date:Time, sep=" ",remove=TRUE)
# Parse Date Time column to POSIX
apexlog$Date<-apexlog$Date%>%
  parse_datetime(format = "%Y-%m-%d %H:%M:%S", na=character(),locale = default_locale(), trim_ws = TRUE)
apexlog<-apexlog%>%
  filter((Date>=startLog) & (Date<=endLog))%>%
  rename(Tank="Probe")


#####################
# split Apex data by treatment type
#####################
a.Am.stable<-apexlog%>% # ambient stable temperature
  filter((Tank=="Tmp-1"|Tank=="Tmp-5"|Tank=="Tmp-9"|Tank=="Tmp-13"|Tank=="Tmp-17"))%>%
  mutate(Treatment="Ambient.Stable")
a.El.stable<-apexlog%>% # elevated stable temperature
  filter((Tank=="Tmp-2"|Tank=="Tmp-6"|Tank=="Tmp-10"|Tank=="Tmp-14"|Tank=="Tmp-18"))%>%
  mutate(Treatment="Elevated.Stable")
a.Am.oc<-apexlog%>% # ambient temperature oscillations
  filter((Tank=="Tmp-3"|Tank=="Tmp-7"|Tank=="Tmp-11"|Tank=="Tmp-15"|Tank=="Tmp-19"))%>%
  mutate(Treatment="Ambient.Oscillating")
a.El.oc<-apexlog%>% # elevated temperature oscillations
  filter((Tank=="Tmp-4"|Tank=="Tmp-8"|Tank=="Tmp-12"|Tank=="Tmp-16"|Tank=="Tmp-20"))%>%
  mutate(Treatment="Elevated.Oscillating")
# bind all rows to combine treatment data, summarise data by Date, Type, and Treatment, and filter by date
apexlog<-a.Am.stable%>%
  rbind(a.El.stable,a.Am.oc,a.El.oc)%>%
  arrange(Date)%>%
  mutate(Source="Apex")
apexmean<-apexlog%>%
  group_by(Date,Type,Treatment,Source)%>%
  summarise(mean=mean(Value),SE=std.error(Value))


#####################
# combine apex and hobo data
#####################

datalog<-rbind(apexlog,hobolog)%>%
  arrange(Date)
meanlog<-rbind(apexmean,hobomean)%>%
  arrange(Date)
Am.stable<-rbind(h.Am.stable,a.Am.stable)%>%
  arrange(Date)
El.stable<-rbind(h.El.stable,a.El.stable)%>%
  arrange(Date)
Am.oc<-rbind(h.Am.oc,a.Am.oc)%>%
  arrange(Date)
El.oc<-rbind(h.El.oc,a.El.oc)%>%
  arrange(Date)

# Color Categorization for Plotting
#tank 1, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19
#tank 2, 20
#tank 3
#...tank 9


# PDF of Chart of R Colors: https://github.com/EarlGlynn/colorchart/wiki/Color-Chart-in-R
my.colors<-c("#A6E1F4","#BCEE68","#BCEE68","#BCEE68","#FF3030","#FF3030","#FF3030","#FF3030","#FFC125","#FFC125","#FFC125",
             "#A6E1F4","#FFC125",
             "#A6E1F4",
             "#A6E1F4",
             "#BC7A8F",
             "#BC7A8F",
             "#BC7A8F",
             "#BC7A8F",
             "#BCEE68", 
             # apex colors: #A6E1F4 = light blue, #BCEE68 = light green, #FF3030 = red, #FFC125 = yellow, #BC7A8F = light purple 
             
             "#00A9E0","#006400","#006400","#006400","#8B1A1A","#8B1A1A","#8B1A1A","#8B1A1A","#8B6914","#8B6914","#8B6914",
             "#00A9E0","#8B6914",
             "#00A9E0",
             "#00A9E0",
             "#8A2BE2",
             "#8A2BE2",
             "#8A2BE2",
             "#8A2BE2",
             "#006400") 
             # hobo colors: #00A9E0 = dark blue, #006400 = dark green, #8B1A1A = dark red, #8B6914 = dark gold, #8A2BE2 = dark purple
subset.colors<-c("#A6E1F4","#BCEE68","#FF3030","#FFC125","#BC7A8F",
                 "#00A9E0","#006400","#8B1A1A","#8B6914","#8A2BE2")

#####################
# Apex and hobo raw treatment plots
#####################
# All treatments
plot1<-ggplot(data=datalog, aes(x=Date, y=Value, colour=Tank))+
  geom_line()+
  theme_bw()+
  theme(legend.title.align = 0.5)+ #align center
  scale_colour_manual(values=my.colors)+
  facet_wrap(ncol=1,~Treatment, scales="free_y")+
  labs(colour="Tank Probes",x="Date",y="TempC",title="Raw Apex and Hobo Temperatures per Treatment")+
  ggsave(paste0("Output/",folder.date,"/ApexHobo_rawValues_perTreatment_plot.png"),width=11,height=7)
# By treatment
plot2<-ggplot(data=Am.stable, aes(x=Date, y=Value, colour=Tank))+
  geom_line()+
  theme_bw()+
  scale_colour_manual(values=subset.colors)+
  labs(colour="Tank Probes",x="Date",y="TempC",title="Raw Apex and Hobo Temperatures",subtitle="Ambient Stable Treatment")+
  ggsave(paste0("Output/",folder.date,"/ApexHobo_Ambient_Stable_plot.png"),width=11,height=6)
plot3<-ggplot(data=El.stable, aes(x=Date, y=Value, colour=Tank))+
  geom_line()+
  theme_bw()+
  scale_colour_manual(values=subset.colors)+
  labs(colour="Tank Probes",x="Date",y="TempC",title="Raw Apex and Hobo Temperatures",subtitle="Elevated Stable Treatment")+
  ggsave(paste0("Output/",folder.date,"/ApexHobo_Elevated_Stable_plot.png"),width=11,height=6)
plot4<-ggplot(data=Am.oc, aes(x=Date, y=Value, colour=Tank))+
  geom_line()+
  theme_bw()+
  scale_colour_manual(values=subset.colors)+
  labs(colour="Tank Probes",x="Date",y="TempC",title="Raw Apex and Hobo Temperatures",subtitle="Ambient Oscillating Treatment")+
  ggsave(paste0("Output/",folder.date,"/ApexHobo_Ambient_Oscillating_plot.png"),width=11,height=6)
plot5<-ggplot(data=El.oc, aes(x=Date, y=Value, colour=Tank))+
  geom_line()+
  theme_bw()+
  scale_colour_manual(values=subset.colors)+
  labs(colour="Tank Probes",x="Date",y="TempC",title="Raw Apex and Hobo Temperatures",subtitle="Elevated Oscillating Treatment")+
  ggsave(paste0("Output/",folder.date,"/ApexHobo_Elevated_Oscillating_plot.png"),width=11,height=6)

#####################
# Plotting Mean Treatment Plots
#####################
# Without Error Bars
plot6<-ggplot(data=meanlog, aes(x=Date, y=mean, colour=Source))+
  geom_line()+
  theme_bw()+
  facet_wrap(ncol=1,~Treatment, scales="free_y")+
  labs(colour="Probe Source",x="Date",y="Mean TempC",
       title="Mean Apex and Hobo Temperatures per Treatment",subtitle="Without Standard Error")+
  ggsave(paste0("Output/",folder.date,"/ApexHobo_meanValues_perTreatment_noSE_plot.png"),width=11,height=7)
plot7<-ggplot(data=meanlog, aes(x=Date, y=mean, colour=Treatment))+
  geom_line()+
  theme_bw()+
  facet_wrap(ncol=1,~Source, scales="free_y")+
  labs(colour="Treatment",x="Date",y="Mean TempC",
       title="Mean Apex and Hobo Temperatures per Source",subtitle="Without Standard Error")+
  ggsave(paste0("Output/",folder.date,"/ApexHobo_meanValues_perSource_noSE_plot.png"),width=11,height=7)
graphlog<-meanlog%>%
  unite("Source_Treatment",Source:Treatment, sep="_",remove=TRUE)
plot8<-ggplot(data=graphlog, aes(x=Date, y=mean, colour=Source_Treatment))+
  geom_line()+
  theme_bw()+
  scale_colour_manual(values=subset.colors)+
  labs(colour="Probe Sources and Treatment",x="Date",y="Mean TempC",
       title="Mean Apex and Hobo Temperatures per Source and Treatment",subtitle="Without Standard Error")#+
  ggsave(paste0("Output/",folder.date,"/ApexHobo_meanValues_perSourceTreatment_noSE_plot.png"),width=11,height=7)
# With Error Bars
plot9<-ggplot(data=meanlog, aes(x=Date, y=mean, colour=Treatment))+
  geom_line()+
  theme_bw()+
  geom_errorbar(aes(ymin=mean-SE,ymax=mean+SE),width=0.2,position="identity")+
  facet_wrap(ncol=1,~Treatment, scales="free_y")+
  labs(colour="Probe Source",x="Date",y="Mean TempC",
       title="Mean Apex and Hobo Temperatures per Treatment",subtitle="With Standard Error")+
  ggsave(paste0("Output/",folder.date,"/ApexHobo_meanValues_perTreatment_SE_plot.png"),width=11,height=7)



