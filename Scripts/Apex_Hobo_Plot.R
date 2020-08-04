# Plot Apex against Hobo Data

######################

date<-"20200802" # Output folder name

######################
######################

hobolog<-read_csv("Data/HOBO_loggers/20200731/HOBOLog_20200731.csv")
# start date and time of data logging
startLog<-parse_datetime("2020-07-30 01:00:00",format = "%F %T", na=character(),
                         locale = locale(tz = ""), trim_ws = TRUE)
# end date and time of data logging
endLog<-parse_datetime("2020-07-31 14:43:00",format = "%F %T", na=character(),
                       locale = locale(tz = ""), trim_ws = TRUE)
# rename for simpler column management
hobolog<-hobolog%>%
  rename(Date='Date Time, GMT -0700')
# parse date_time to POSIXct
hobolog$Date<-hobolog$Date%>%
  as.POSIXct(format = "%F %T", na=character(), tz="", locale = locale(tz = ""), trim_ws = TRUE)
# filter out "test time" data
hobolog<-hobolog%>%
  filter((Date>=startLog) & (Date<=endLog))
# Create long-form dataframe from datalog
hobolog<-hobolog%>%
  pivot_longer(cols = -c(Date), names_to = "Tank",values_to = "Temp_C",values_drop_na = TRUE)
# split data by treatment type
Am.stable<-hobolog%>% # ambient stable temperature
  filter((Tank=="Tnk1_TmpC"|Tank=="Tnk5_TmpC"|Tank=="Tnk9_TmpC"|Tank=="Tnk13_TmpC"|Tank=="Tnk17_TmpC"))%>%
  mutate(Treatment="Ambient.Stable")
El.stable<-hobolog%>% # elevated stable temperature
  filter((Tank=="Tnk2_TmpC"|Tank=="Tnk6_TmpC"|Tank=="Tnk10_TmpC"|Tank=="Tnk14_TmpC"|Tank=="Tnk18_TmpC"))%>%
  mutate(Treatment="Elevated.Stable")
Am.oc<-hobolog%>% # ambient temperature oscillations
  filter((Tank=="Tnk3_TmpC"|Tank=="Tnk7_TmpC"|Tank=="Tnk11_TmpC"|Tank=="Tnk15_TmpC"|Tank=="Tnk19_TmpC"))%>%
  mutate(Treatment="Ambient.Oscillating")
El.oc<-hobolog%>% # elevated temperature oscillations
  filter((Tank=="Tnk4_TmpC"|Tank=="Tnk8_TmpC"|Tank=="Tnk12_TmpC"|Tank=="Tnk16_TmpC"|Tank=="Tnk20_TmpC"))%>%
  mutate(Treatment="Elevated.Oscillating")
# bind all rows to combine treatment data and summarise data by Date and Treatment
hobolog<-Am.stable%>%
  rbind(El.stable,Am.oc,El.oc)%>% # combine all treatment data
  arrange(Date)%>%
  group_by(Date,Treatment)%>%
  summarise(mean=mean(Temp_C),SE=std.error(Temp_C))%>% #create columns for mean and standard error of remaining data
  mutate(Source="HOBO")


######################
######################

apexlog<-read_csv("Data/Apex_DataLogs/Apex_temp_pH_Datalog.csv")
# Unite Date and Time into one column
apexlog<-apexlog%>%
  unite("Date",Date:Time, sep=" ",remove=TRUE)
# Parse Date Time column to POSIX
apexlog$Date<-apexlog$Date%>%
  parse_datetime(format = "%Y-%m-%d %H:%M:%S", na=character(),locale = default_locale(), trim_ws = TRUE)
# categorize treatments, separated by Probes
Am.stable<-apexlog%>% # ambient stable temperature
  filter((Probe=="Tmp-1"|Probe=="Tmp-5"|Probe=="Tmp-9"|Probe=="Tmp-13"|Probe=="Tmp-17"))%>%
  mutate(Treatment="Ambient.Stable")
El.stable<-apexlog%>% # elevated stable temperature
  filter((Probe=="Tmp-2"|Probe=="Tmp-6"|Probe=="Tmp-10"|Probe=="Tmp-14"|Probe=="Tmp-18"))%>%
  mutate(Treatment="Elevated.Stable")
Am.oc<-apexlog%>% # ambient temperature oscillations
  filter((Probe=="Tmp-3"|Probe=="Tmp-7"|Probe=="Tmp-11"|Probe=="Tmp-15"|Probe=="Tmp-19"))%>%
  mutate(Treatment="Ambient.Oscillating")
El.oc<-apexlog%>% # elevated temperature oscillations
  filter((Probe=="Tmp-4"|Probe=="Tmp-8"|Probe=="Tmp-12"|Probe=="Tmp-16"|Probe=="Tmp-20"))%>%
  mutate(Treatment="Elevated.Oscillating")
# bind all rows to combine treatment data, summarise data by Date, Type, and Treatment, and filter by date
apexlog<-Am.stable%>%
  rbind(El.stable,Am.oc,El.oc)%>%
  arrange(Date)%>%
  group_by(Date,Type,Treatment)%>%
  summarise(mean=mean(Value),SE=std.error(Value))%>%
  filter((Date>=startLog) & (Date<=endLog))%>%
  mutate(Source="Apex")

######################
######################

datalog<-rbind(apexlog,hobolog)
datalog<-datalog%>%
  arrange(Date)

View(hobolog)
View(apexlog)

plots<-ggplot(data=datalog, aes(x=Date, y=mean, colour=Source))+
  geom_line(aes(colour=Source))+
  facet_wrap(ncol=1,~Treatment, scales="free_y")+
  labs(x="Date",y="Mean TempC")+
  ggsave(paste0("Output/",date,"/Treatment_Facet.png"))
plots

