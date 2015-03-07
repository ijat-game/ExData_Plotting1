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
#Create plot
#summary(pwrslice$Sub_metering_1)
dayofweek=format(seq(pwrslice$DateTime[1],max(pwrslice$DateTime)+1440,by='days')
                 ,format='%a')
plot(pwrslice$DateTime,pwrslice$Sub_metering_1
     ,type='n',btn=1#col = "red",
     #,labels=FALSE
     #main="Global Active Power" ,#breaks=16,
     ,ylab="Energy sub metering"
     ,xlab=""
     ,axes=FALSE
     ,ylim=range(0:40)
     #,xlim=range(dayofweek)
     )
lines(pwrslice$DateTime,pwrslice$Sub_metering_1,type='l')
lines(pwrslice$DateTime,pwrslice$Sub_metering_2,type='l',col='red')
lines(pwrslice$DateTime,pwrslice$Sub_metering_3,type='l',col='blue')

axis(side=1, at=seq(pwrslice$DateTime[1],max(pwrslice$DateTime)+1440,by='days'), 
     labels=dayofweek)
axis(side=2,at=seq(0,30,by=10), labels=seq(0,30 ,by=10))
legend("topright", lty=1,cex=.5, col = c("black","blue", "red"), 
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
box()
#Save plot as PNG
dev.copy(png, file = "plot3.png") 
dev.off() 
