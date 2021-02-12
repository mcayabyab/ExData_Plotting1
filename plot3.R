library(dplyr)
library(lubridate)

#set working directory as downloads folder
setwd("~/Downloads")

#download data
file <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(file, "power_consumption.zip", method = "curl")

#unzip file
unzip("power_consumption.zip")

#read file
#convert "?" to NAs
powerconsumption <- read.table("household_power_consumption.txt", header = TRUE, sep =";", na.strings = c("?"))

#convert date column from character to date class
powerconsumption$Date <- as.Date(powerconsumption$Date, "%d/%m/%Y")

#subset rows where date is 2/1/2007 or 2/2/2007
powerconsumption <- powerconsumption[powerconsumption$Date == "2007-02-01" | powerconsumption$Date == "2007-02-02", ]

#create new column with date + time combined in as.POSIXct class
powerconsumption$DateTime <- as.POSIXct(paste(powerconsumption$Date, powerconsumption$Time), format="%Y-%m-%d %H:%M:%S")

#open png file
png("plot3.png", width = 480, height = 480)

#create plot DateTime vs Global active power
plot(powerconsumption$DateTime, powerconsumption$Sub_metering_1, col = "black", type = "l", xlab = NA, ylab = "Energy sub metering")
lines(powerconsumption$DateTime, powerconsumption$Sub_metering_2, type = "l", col = "red")
lines(powerconsumption$DateTime, powerconsumption$Sub_metering_3,type = "l", col = "blue")

#add legend
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1, col = c("black", "red", "blue"))

#saves file in downloads folder as plot3.png
dev.off()
