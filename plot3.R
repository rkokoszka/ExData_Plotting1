library(lubridate)

##Set Working Directory
setwd("~/Desktop/Coursera/Exploratory Data Analysis/Project 1")

## Read data into R
data <- read.table("household_power_consumption.txt", 
                   header = TRUE, sep = ";", colClasses = "character")

## Convert date column to a date
data$Date <- as.Date(dmy(data$Date))
data$Time <- as.Date(hms(data$Time), origin = data$Date)

## Subset the data to only Feb 1, 2007 - Feb 2, 2007
data <- data[data$Date == "2007-02-01" | data$Date == "2007-02-02",]

numColumns <- colnames(data[,3:9])
for (column in numColumns) {
      data[,column] <- as.numeric(data[,column])
      ##print(column)
}

##Open PNG Graphics Device
png(file = "plot3.png")

## Create the plot
with(data, plot(Time, Sub_metering_1, type = "n", main = "", 
                xlab = "", ylab = "Energy sub metering"))
with(data, lines(Time, Sub_metering_1, type = "l"))
with(data, lines(Time, Sub_metering_2, type = "l", col = "red"))
with(data, lines(Time, Sub_metering_3, type = "l", col = "blue"))
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty = 1, col = c("black", "red", "blue"), cex = 0.7)

## Close the Graphics Device
dev.off()
