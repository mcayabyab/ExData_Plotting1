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

#open png file
png("plot1.png", width = 350, height = 350)

#create plot
hist(powerconsumption$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")

#saves file in downloads folder as plot1.png
dev.off()
