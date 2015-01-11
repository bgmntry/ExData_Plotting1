library(data.table)
library(lubridate)

if(!file.exists("household_power_consumption.txt")){
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = "power_consumption.zip");
  unzip("power_consumption.zip")
}

powerConsumption <- fread("household_power_consumption.txt")

powerConsumption <- rbind(powerConsumption[powerConsumption$Date == "1/2/2007"], powerConsumption[powerConsumption$Date == "2/2/2007"])


powerConsumption$Date <-  dmy_hms(paste(powerConsumption$Date, powerConsumption$Time))
powerConsumption$Sub_metering_1 <- as.numeric(powerConsumption$Sub_metering_1)
powerConsumption$Sub_metering_2 <- as.numeric(powerConsumption$Sub_metering_2)
powerConsumption$Sub_metering_3 <- as.numeric(powerConsumption$Sub_metering_3)

png(filename = "plot3.png")
with(powerConsumption, plot(Date, Sub_metering_1, pch = 27, xlab = "", ylab = "Energy sub metering"))
with(powerConsumption, points(Date, Sub_metering_2, col = "red", pch = 27))
with(powerConsumption, points(Date, Sub_metering_3, col = "blue", pch = 27))
with(powerConsumption, lines(Date, Sub_metering_1))
with(powerConsumption, lines(Date, Sub_metering_2, col = "red"))
with(powerConsumption, lines(Date, Sub_metering_3, col = "blue"))
legend("topright", lwd = 2, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()