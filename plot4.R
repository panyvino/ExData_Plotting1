temp <- tempfile()
Url <- "https://d396qusza40orc.cloudfront.net/exdata/data/household_power_consumption.zip"
download.file(Url, temp)
data <- read.table(unz(temp, "household_power_consumption.txt"), sep = ";", na.strings = "?", nrows = 2880, skip = 66637)
unlink(temp)

names(data) <- c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
data[,3:9] <- sapply(data[,3:9], as.numeric)

library(lubridate)
data[,1] <- dmy(data[,1])
datetime <- as.POSIXct(paste(data$Date, as.character(data$Time)))
data <- cbind(data, datetime)



png(file="plot4.png", width = 480, height = 480, unit = "px", bg = "white")

par(mfrow = c(2,2), mar = c(4, 4, 2, 1), oma = c(0, 0, 1,0))
plot(data$datetime, data$Global_active_power, type = "l", xlab ="", ylab = "Global Active Power")
plot(data$datetime, data$Voltage, type = "l", xlab ="datetime", ylab = "Voltage")
plot(data$datetime, data$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering", col = "black")
lines(data$datetime, data$Sub_metering_2, col = "red")
lines(data$datetime, data$Sub_metering_3, col = "blue")
legend("topright", lwd = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
plot(data$datetime, data$Global_reactive_power, type = "l", xlab ="datetime", ylab = "Global_reactive_power")
mtext("Plot 4", side = 10, adj = 0, line = 16, at = 2, outer = TRUE)

dev.off()
