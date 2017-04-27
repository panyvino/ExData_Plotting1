temp <- tempfile()
Url <- "https://d396qusza40orc.cloudfront.net/exdata/data/household_power_consumption.zip"
download.file(Url, temp)
data <- read.table(unz(temp, "household_power_consumption.txt"), sep = ";", na.strings = "?", nrows = 2880, skip = 66637)house
unlink(temp)

names(data) <- c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
data[,3:9] <- sapply(data[,3:9], as.numeric)

library(lubridate)
data[,1] <- dmy(data[,1])
datetime <- as.POSIXct(paste(data$Date, as.character(data$Time)))
data <- cbind(data, datetime)

png(file="plot2.png", width = 480, height = 480, unit = "px", bg = "white")

plot(data$datetime, data$Global_active_power, type = "l", xlab ="", ylab = "Global Active Power (kilowatts)")
mtext("Plot 2", side = 10, adj = 0, line = 16, at = 2, outer = TRUE)

dev.off()