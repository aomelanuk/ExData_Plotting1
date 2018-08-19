##check file exist or not
## if not exist download and unzip it
if(!file.exists("household_power_consumption.txt"))
{
  data_url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(data_url,"household_power_consumption.zip")
  unzip("household_power_consumption.zip")
}
##load data from file into data frame
dt<-read.csv2("household_power_consumption.txt",stringsAsFactors = F,na.strings = "?", dec=".")

##filter data by dates
dt<-subset(dt,dt$Date=="1/2/2007"|dt$Date=="2/2/2007")
dt$Time<-strptime(paste(dt$Date,dt$Time),"%d/%m/%Y %H:%M:%S")

##Output Plot to 480 x 480 png
png("plot3.png", height = 480, width = 480)
plot(dt$Time,dt$Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "")
lines(dt$Time,dt$Sub_metering_2, type = "l", col="red")
lines(dt$Time,dt$Sub_metering_3, type = "l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1, lwd = 2, col=c("black", "red", "blue"))
dev.off()