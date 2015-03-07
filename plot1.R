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
summary(pwrslice$Global_active_power)
hist(pwrslice$Global_active_power,col = "red",
     main="Global Active Power" ,#breaks=16,
     xlab="Global Active Power (kilowatts)",axes=FALSE,
     xlim=range(0:6),ylim=range(0:1200))
axis(side=1,at=seq(0,6,by=2), labels=seq(0,6 ,by=2))
axis(side=2,at=seq(0,1200,by=200), labels=seq(0,1200 ,by=200))
#Save plot as PNG
dev.copy(png, file = "plot1.png") 
dev.off() 
