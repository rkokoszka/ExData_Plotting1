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
png(file = "plot4.png")

par(mfrow = c(2, 2))
par(mar = c(4, 4, 4, 2))

## Create the top left plot
with(data, plot(Time, Global_active_power, type = "n", 
                xlab = "", ylab = "Global Active Power"))
with(data, lines(Time, Global_active_power, type = "l"))

## Create the top right plot
with(data, plot(Time, Voltage, type = "n", xlab = "datetime", ylab = "Voltage"))
with(data, lines(Time, Voltage, type = "l"))

## Create the bottom left plot
with(data, plot(Time, Sub_metering_1, type = "n", main = "", 
                xlab = "", ylab = "Energy sub metering"))
with(data, lines(Time, Sub_metering_1, type = "l"))
with(data, lines(Time, Sub_metering_2, type = "l", col = "red"))
with(data, lines(Time, Sub_metering_3, type = "l", col = "blue"))
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty = 1, col = c("black", "red", "blue"), bty = "n", cex = 0.8)

## Create the bottom right plot
with(data, plot(Time, Global_reactive_power, type = "n", 
                xlab = "datetime", ylab = "Global_reactive_power"))
with(data, lines(Time, Global_reactive_power, type = "l"))

## Close the Graphics Device
dev.off()
