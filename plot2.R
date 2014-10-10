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
png(file = "plot2.png")

## Create the plot without data points
with(data, plot(Time, Global_active_power, type = "n", 
                xlab = "", ylab = "Global Active Power (kilowatts)"))
## Add data line
with(data, lines(Time, Global_active_power, type = "l"))

## Close the Graphics Device
dev.off()
