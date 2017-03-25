## load a subsection of the dataset into R
##get headers and turn "/" into nulls
data<-read.table("household_power_consumption.txt",sep=";",header=TRUE,na.strings="?",nrow=144000,skipNul = TRUE) 

##Turn date column into time format with just hours and minutes??
data$Time<-strptime(data$Time, "%H:%M:%S")
##data$Time<-strftime(data$Time, "%H:%M")

##Turn date column into date format
data$Date<-as.Date(data$Date,"%d/%m/%Y")

##Subsetting the data table by fisrt selecting all data  after 31st Jan 
##then slecting all data before 3rd feb
usedata<-subset(data,Date>as.Date("2007-01-31"))
usedata<-subset(usedata,Date<as.Date("2007-02-03"))

library(lubridate)
usedata$Time<-update(usedata$Time,years=year(usedata$Date),months=month(usedata$Date),days=day(usedata$Date))

png(filename = "plot3.png", width = 480, height = 480,pointsize = 12, bg = "white",  res = NA)
plot(usedata$Time,usedata$Sub_metering_1,type="l",ylab="Energy sub metering",xlab="")
lines(usedata$Time,usedata$Sub_metering_2,col="red")
lines(usedata$Time,usedata$Sub_metering_3,col="blue")
legend("topright",pch=1,col=c("black","red","blue"),legend=c("Sub_Metering_1","Sub_Metering_2","Sub_Metering_3"))
dev.off()