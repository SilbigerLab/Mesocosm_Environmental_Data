# Organizing HOBO data for plotting over time -- old code but still usable 

# clean environment
rm(list=ls())

install.packages("tidyverse")

# Load libraries
library(tidyverse)
library(ggplot2)
library(lubridate)
library(plotrix)

#####################
# Load data
#####################
folder.date<- "20200830"
HOBOLog <- read_csv("Data/Hobo_loggers/20200830/HOBOLog.csv")

HOBOLog<-HOBOLog%>%
select(-c('Intensity, ( lux)'))

# start date and time of data logging
startLog<-parse_datetime("2020-08-26 18:10:00",format = "%Y-%m-%d %H:%M:%S", na=character(),
                         locale = locale(tz = ""), trim_ws = TRUE)
# end date and time of data logging
endLog<-parse_datetime("2020-08-30 08:42:00",format = "%Y-%m-%d %H:%M:%S", na=character(),
                       locale = locale(tz = ""), trim_ws = TRUE)

# parse date_time to POSIXct
Hobo_Date<-HOBOLog$Date%>%
  as.POSIXct(format = "%F %T", na=character(), tz="", locale = locale(tz = ""), trimws = TRUE)

# filter out "test time" data that we established earlier 
HOBOLog<-HOBOLog%>%
  filter((Date>=startLog) & (Date<=endLog))

# hobos are logging time at GMT-7 while Apex's reading GMT-8
#ask danielle about this one
HOBOLog$Date<-HOBOLog$Date + hours(1)

# Create long-form dataframe from datalog
HOBOLog<-HOBOLog%>%
  pivot_longer(cols = -c(Date), names_to = "Tank",values_to = "Value",values_drop_na = TRUE)

#####################
# split data by treatment type
#####################
Ambient.stable<-HOBOLog%>% # ambient stable temperature
  filter((Tank=="Hobo-Tmp-1"|Tank=="Hobo-Tmp-5"|Tank=="Hobo-Tmp-9"|Tank=="Hobo-Tmp-13"|Tank=="Hobo-Tmp-17"))%>%
  mutate(Treatment="Ambient.Stable")%>%
  filter((Date>=startLog) & (Date<=endLog))
Elevated.stable<-HOBOLog%>% # elevated stable temperature
  filter((Tank=="Hobo-Tmp-2"|Tank=="Hobo-Tmp-6"|Tank=="Hobo-Tmp-10"|Tank=="Hobo-Tmp-14"|Tank=="Hobo-Tmp-18"))%>%
  mutate(Treatment="Elevated.Stable")%>%
  filter((Date>=startLog) & (Date<=endLog))
Ambient.occil<-HOBOLog%>% # ambient temperature oscillations
  filter((Tank=="Hobo-Tmp-3"|Tank=="Hobo-Tmp-7"|Tank=="Hobo-Tmp-11"|Tank=="Hobo-Tmp-15"|Tank=="Hobo-Tmp-19"))%>%
  mutate(Treatment="Ambient.Oscillating")%>%
  filter((Date>=startLog) & (Date<=endLog))
Elevated.occil<-HOBOLog%>% # elevated temperature oscillations
  filter((Tank=="Hobo-Tmp-4"|Tank=="Hobo-Tmp-8"|Tank=="Hobo-Tmp-12"|Tank=="Hobo-Tmp-16"|Tank=="Hobo-Tmp-20"))%>%
  mutate(Treatment="Elevated.Oscillating")%>%
  filter((Date>=startLog) & (Date<=endLog))

#now that we have the raw data sets with time and date separated...
#we need to get the min, max and average of each day for each treatment
#sepearate time in each dataset before we can do min, max and average
#make columns with min temp, max temp and average temp
#remove "time" -- this is just repetetive, because we are only showing max, min and average for the whole day 
#make a column for "range"
#remove repeating numbers for each day 

Ambient.occil<-Ambient.occil%>%
  separate(Date,into = c("Date", "Time"), sep = " ", remove = TRUE)%>%
  group_by(Date, Tank)%>%
  mutate(Min.t=min(Value), Max.t=max(Value), Aver.t=mean(Value), SE = std.error(Value))%>%
  select(-c("Time"))%>%
  mutate(Range=Max.t-Min.t)%>%
  select(-c("Value"))%>%
  distinct()%>%
  pivot_longer(cols=c(Max.t, Min.t, Aver.t), names_to = "Statistical_Values", values_to = "Values")

Ambient.occil$Date<-Ambient.occil$Date%>%
  parse_date(format = "%Y-%m-%d", na=character(), locale = default_locale(), trim_ws = TRUE)


#unite(Tank_Statistical_Values,c(Tank,Statistical_Values),sep="_", remove = TRUE)

Ambient.stable<-Ambient.stable%>%
  separate(Date,into = c("Date", "Time"), sep = " ", remove = TRUE)%>%
  group_by(Date, Tank)%>%
  mutate(Min.t=min(Value), Max.t=max(Value), Aver.t=mean(Value), SE = std.error(Value))%>%
  select(-c("Time"))%>%
  mutate(Range=Max.t-Min.t)%>%
  select(-c("Value"))%>%
  distinct()%>%
  pivot_longer(cols=c(Max.t, Min.t, Aver.t), names_to = "Statistical_Values", values_to = "Values")

Ambient.stable$Date<-Ambient.stable$Date%>%
  parse_date(format = "%Y-%m-%d", na=character(), locale = default_locale(), trim_ws = TRUE)

Elevated.occil<-Elevated.occil%>%
  separate(Date,into = c("Date", "Time"), sep = " ", remove = TRUE)%>%
  group_by(Date, Tank)%>%
  mutate(Min.t=min(Value), Max.t=max(Value), Aver.t=mean(Value), SE = std.error(Value))%>%
  select(-c("Time"))%>%
  mutate(Range=Max.t-Min.t)%>%
  select(-c("Value"))%>%
  distinct()%>%
  pivot_longer(cols=c(Max.t, Min.t, Aver.t), names_to = "Statistical_Values", values_to = "Values")

Elevated.occil$Date<-Elevated.occil$Date%>%
  parse_date(format = "%Y-%m-%d", na=character(), locale = default_locale(), trim_ws = TRUE)

Elevated.stable<-Elevated.stable%>%
  separate(Date,into = c("Date", "Time"), sep = " ", remove = TRUE)%>%
  group_by(Date, Tank)%>%
  mutate(Min.t=min(Value), Max.t=max(Value), Aver.t=mean(Value), SE=std.error(Value))%>%
  select(-c("Time"))%>%
  mutate(Range=Max.t-Min.t)%>%
  select(-c("Value"))%>%
  distinct()%>%
  pivot_longer(cols=c(Max.t, Min.t, Aver.t), names_to = "Statistical_Values", values_to = "Values")

Elevated.stable$Date<-Elevated.stable$Date%>%
  parse_date(format = "%Y-%m-%d", na=character(), locale = default_locale(), trim_ws = TRUE)

# Lets Plot!
#####################
Ambient.occil.plot<-ggplot(data=Ambient.occil, aes(x=Date, y=Values, colour=Tank))+
  geom_line(position = "identity")+
  theme_bw()+
  ggtitle("Ambient Oscillating Treatment")+
  facet_wrap(ncol=1,~Statistical_Values, scales = "fixed")+
  ggsave(paste0("Output/",folder.date,"/Ambient_oscillation_plot.png"),width=11,height=7)

Ambient.stable.plot<-ggplot(data=Ambient.stable, aes(x=Date, y=Values, colour=Tank))+
  geom_line(position = "identity")+
  theme_bw()+
  ggtitle("Ambient Stable Treatment")+
  facet_wrap(ncol=1,~Statistical_Values, scales = "fixed")+
  ggsave(paste0("Output/",folder.date,"/Ambient_stable_plot.png"),width=11,height=7)

Elevated.occil.plot<-ggplot(data=Elevated.occil, aes(x=Date, y=Values, colour=Tank))+
  geom_line(position = "identity")+
  theme_bw()+
  ggtitle("Elevated Oscillating Treatment")+
  facet_wrap(ncol=1,~Statistical_Values, scales = "fixed")+
  ggsave(paste0("Output/",folder.date,"/Elecated_oscillating_plot.png"),width=11,height=7)

Elevated.stable.plot<-ggplot(data=Elevated.stable, aes(x=Date, y=Values, colour=Tank))+
  geom_line(position = "identity")+
  theme_bw()+
  ggtitle("Elevated Stable Treatment")+
  facet_wrap(ncol=1,~Statistical_Values, scales = "fixed")+
  ggsave(paste0("Output/",folder.date,"/Elevated_stable_plot.png"),width=11,height=7)

Ambient.occil.plot
Elevated.occil.plot
Ambient.stable.plot
Elevated.stable.plot

#######disregard below this#####

#Ambient.occil.plot<-ggplot(data=Ambient.occil, aes(x=Date, y=Values, colour=Statistical_Values))+
#geom_line(position = "identity")+
  #theme_bw()+
  #facet_wrap(ncol=1,~Tank, scales = "fixed")

Ambient.occil.plot<-ggplot(data=Ambient.occil, aes(x=Date, y=Values, colour=Tank))+
  geom_line(position = "identity")+
  theme_bw()+
  facet_wrap(ncol=1,~Statistical_Values, scales = "fixed")

view(Ambient.occil.plot)
view(Ambient.occil)

#on the 17th, we figured out the flow 

#######extra code#####

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





#####other code I don't need right now#####
# bind all rows to combine treatment data and summarise data by Date and Treatment
HOBOLog<-Ambient.stable%>%
  rbind(Elevated.stable,Ambient.occil,Elevated.occil)%>%
  arrange(Date)

#####################
