#stats on average daily range for Cultured_Ab loggers

foldername<-'Data/HOBO_loggers/Cultured_Ab/'
folder.date<-'Cultured_Ab'

#import the dataset that you want to use, this one has Date+Time, Source & Temp
datalog<-read_csv("Data/HOBO_loggers/Cultured_Ab/Cultured_Abalone_Hobo_Data.csv")

# start date and time of data logging 
startLog<-parse_datetime("2020-07-15 00:00:00", format = "%Y-%m-%d %H:%M:%S", na=character(), locale = locale(tz = ""), trim_ws = TRUE)

# end date and time of data logging
endLog<-parse_datetime("2020-07-31 14:00:00",format = "%Y-%m-%d %H:%M:%S", na=character(), locale = locale(tz = ""), trim_ws = TRUE)

# filter out "test time" data
datalog<-datalog%>%
  filter((Date>=startLog) & (Date<=endLog))

##find max and min temperature per day##
#separate data and time into two separate columns by a space " "
#make two columns, one for min temp and max temp 
datalog<-datalog%>%
  separate(Date,into = c("Date", "Time"), sep = " ", remove = TRUE)%>%
  group_by(Date, Source)%>%
  mutate(Min.t=min(TempC), Max.t=max(TempC))

#remove the column for time, and add a new column for range (max-min) 
datalog<-datalog%>%
  select(-c("Time"))%>%
  mutate(Range=Max.t-Min.t)

#Remove the individual temperature column, and then remove the repeating rows by using the distinct function
datalog<-datalog%>%
  select(-c("TempC"))%>%
  distinct()

#get rid of the AverageTemps, so only have the Hobo Tmp 1 OR Hobo Tmp 2
datalog<-datalog%>%
  filter(Source=="Hobo-Tmp-1"|Source=="Hobo-Tmp-2")

#creae an average range per day column
datalog<-datalog%>%
  group_by(Date)%>%
  mutate(AverageRange=mean(Range))

#stats on average range, average min and average max 
#note that this is
mean(datalog$Range)
#3.550588
mean(datalog$Min.t)
#13.35824
mean(datalog$Max.t)
#19.90882

##plots## 

datalog<-read_csv("Data/HOBO_loggers/Cultured_Ab/Cultured_Abalone_Hobo_Data.csv")

# start date and time of data logging 
startLog<-parse_datetime("2020-07-15 00:00:00", format = "%Y-%m-%d %H:%M:%S", na=character(), locale = locale(tz = ""), trim_ws = TRUE)

# end date and time of data logging
endLog<-parse_datetime("2020-07-31 14:00:00",format = "%Y-%m-%d %H:%M:%S", na=character(), locale = locale(tz = ""), trim_ws = TRUE)

# filter out "test time" data
datalog<-datalog%>%
  filter((Date>=startLog) & (Date<=endLog))

# Plot each logger separately 
plot1<-ggplot(data=datalog, aes(x=Date, y=TempC))+
  geom_line()+
  theme_bw()+
  facet_wrap(ncol=1,~Source, scales="fixed")+ # 'fixed' instead of 'free y'
  labs(x="Date",y="TempC",title="Temperatures from Cultured Abalone Hobo Loggers",subtitle="July 15 through July 31")#+
#ggsave(paste0("Output/",folder.date,"/CulteredAb_Hobo_2week_facet_plot.png"),width=11,height=7)
plot1
plot2<-ggplot(data=datalog, aes(x=Date, y=TempC, colour = Source))+
  geom_line()+
  theme_bw()+
  labs(x="Date",y="TempC",title="Temperatures from Cultured Abalone Hobo Loggers",subtitle="July 15 through July 31")#+
#ggsave(paste0("Output/",folder.date,"/CulteredAb_Hobo_2week_plot.png"),width=11,height=7)
plot2
