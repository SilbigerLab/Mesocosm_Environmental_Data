
# Load libraries
library(tidyverse)
library(ggplot2)

# Bring in data
datalog<-read_csv("Data/Apex_DataLogs/Apex_temp_pH_Datalog.csv")
View(datalog)

#Temp data for all experimental tanks
dataTemp<-datalog%>%
  filter(Type=="Temp")%>%
  filter((Value>0)&(Value<19))%>%
  filter((Probe!="Tmp-5")&(Probe!="Tmp-6"))#%>%
#  filter((Probe=="Tmp-1"|Probe=="Tmp-2"|Probe=="Tmp-17"|Probe=="Tmp-18"|Probe=="Tmp-19"|Probe=="Tmp-20"|Probe=="TMP-S")) #oscillating pH tanks
#  filter((Probe=="Tmp-11"|Probe=="Tmp-12"|Probe=="Tmp-13"|Probe=="Tmp-14"|Probe=="Tmp-15"|Probe=="Tmp-16"|Probe=="TMP-S")) # control pH tanks
#  filter((Probe=="Tmp-3"|Probe=="Tmp-4"|Probe=="Tmp-7"|Probe=="Tmp-8"|Probe=="Tmp-9"|Probe=="Tmp-10"|Probe=="TMP-S")) # low pH tanks

# Plot trends for Temperature over time
plotTemp<-ggplot(data=dataTemp, aes(x=Date, y=Value, colours=Probe))+
  geom_line(aes(colour=Probe))
plotTemp

#pH data for all experimental tanks
datapH<-datalog%>%
  filter(Type=="pH")%>%
  filter(Value>6.5)%>%
  filter((Probe!="pH-5")&(Probe!="pH-6"))#%>%
#  filter((Probe=="pH-1"|Probe=="pH-2"|Probe=="pH-17"|Probe=="pH-18"|Probe=="pH-19"|Probe=="pH-20"|Probe=="PH-Smp")) #oscillating tanks
#  filter((Probe=="pH-11"|Probe=="pH-12"|Probe=="pH-13"|Probe=="pH-14"|Probe=="pH-15"|Probe=="pH-16"|Probe=="PH-Smp")) # control tanks
#  filter((Probe=="pH-3"|Probe=="pH-4"|Probe=="pH-7"|Probe=="pH-8"|Probe=="pH-9"|Probe=="pH-10"|Probe=="PH-Smp")) # low pH tanks

# Plot trends for pH over time
plotpH<-ggplot(data=datapH, aes(x=Date, y=Value, colours=Probe))+
  geom_line(aes(colour=Probe))
plotpH
