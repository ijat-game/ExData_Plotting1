# March 7, 2015
# Set working directory to location of the data.
#setwd("C:/R Class/ExData_Plotting1")
# read power file into system
# flag missing ? values as NA
pwr<-read.csv("household_power_consumption.txt",stringsAsFactors=FALSE,
              header=TRUE,sep = ";",na.strings ="?",nrows=-1)
# subset for the 2 days needed. 
pwrslice<-pwr[pwr$Date=="1/2/2007"|pwr$Date=="2/2/2007",]
# free memory by removing large file.
rm(pwr)
# create datetime field. 
pwrslice$DateTime<-as.POSIXct(paste(pwrslice$Date, 
        pwrslice$Time, sep = " "), format="%d/%m/%Y %H:%M:%S")
#head(pwrslice$DateTime)
#summary(pwrslice)
#str(pwrslice)
# put 4 plots on one page
par(mfrow = c(2, 2))
dayofweek=format(seq(pwrslice$DateTime[1],max(pwrslice$DateTime)+1440,by='days')
                 ,format='%a')
#Create plot
#Global_active_power
  plot(pwrslice$DateTime,pwrslice$Global_active_power,
       ,type='l' ,ylab="Global Active Power"
       ,xlab="")
 # lines(pwrslice$DateTime,pwrslice$Global_active_power,type='l')
  
#Voltage
  plot(pwrslice$DateTime,pwrslice$Voltage,
     ,type='l',xlab="Datetime" ,ylab="Voltage" )

#Energy sub metering

plot(pwrslice$DateTime,pwrslice$Sub_metering_1
     ,type='n'
     ,ylab="Energy sub metering"
     ,xlab=""
     ,axes=FALSE
     ,ylim=range(0:40)
     )
lines(pwrslice$DateTime,pwrslice$Sub_metering_1,type='l')
lines(pwrslice$DateTime,pwrslice$Sub_metering_2,type='l',col='red')
lines(pwrslice$DateTime,pwrslice$Sub_metering_3,type='l',col='blue')
axis(side=1, at=seq(pwrslice$DateTime[1],max(pwrslice$DateTime)+1440,by='days'), 
     labels=dayofweek)
axis(side=2,at=seq(0,30,by=10), labels=seq(0,30 ,by=10))
legend("topright", lty=1,cex=.5,xjust=1,bty="n"
       , col = c("black","blue", "red"), 
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
box()
# Global_reactive_power
plot(pwrslice$DateTime,pwrslice$Global_reactive_power
     ,type='n',xlab="Datetime" ,ylab="Global_reactive_power"
     ,axes=FALSE
     #,ylim=range(.0:.5)
     )
lines(pwrslice$DateTime,pwrslice$Global_reactive_power,type='l')
axis(side=1, at=seq(pwrslice$DateTime[1],max(pwrslice$DateTime)+1440,by='days'), 
     labels=dayofweek)
axis(side=2,cex.axis=.7,at=seq(0.0,0.5, 0.1), labels=c("0.0","0.1","0.2","0.3","0.4","0.5"))
box()
#Save plot as PNG
dev.copy(png, file = "plot4.png") 
dev.off() 
