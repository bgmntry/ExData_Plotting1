library(data.table)
library(lubridate)

if(!file.exists("household_power_consumption.txt")){
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = "power_consumption.zip");
  unzip("power_consumption.zip")
}

powerConsumption <- fread("household_power_consumption.txt")

powerConsumption <- rbind(powerConsumption[powerConsumption$Date == "1/2/2007"], powerConsumption[powerConsumption$Date == "2/2/2007"])


powerConsumption$Date <-  dmy_hms(paste(powerConsumption$Date, powerConsumption$Time))
powerConsumption$Global_active_power <- as.numeric(powerConsumption$Global_active_power)
powerConsumption$Global_reactive_power <- as.numeric(powerConsumption$Global_reactive_power)
powerConsumption$Voltage <- as.numeric(powerConsumption$Voltage)
powerConsumption$Global_intensity <- as.numeric(powerConsumption$Global_intensity)
powerConsumption$Sub_metering_1 <- as.numeric(powerConsumption$Sub_metering_1)
powerConsumption$Sub_metering_2 <- as.numeric(powerConsumption$Sub_metering_2)
powerConsumption$Sub_metering_3 <- as.numeric(powerConsumption$Sub_metering_3)

png(filename = "plot4.png")
par(mfrow = c(2,2))
with(powerConsumption, {
  plot(Date, Global_active_power, pch = 27, xlab = "", ylab = "Global Active Power")
  lines(Date, Global_active_power)
  
  plot(Date, Voltage, pch = 27, xlab = "datetime", ylab = "Voltage")
  lines(Date, Voltage)
  
  plot(Date, Sub_metering_1, pch = 27, xlab = "", ylab = "Energy sub metering")
  points(Date, Sub_metering_2, col = "red", pch = 27)
  points(Date, Sub_metering_3, col = "blue", pch = 27)
  lines(Date, Sub_metering_1)
  lines(Date, Sub_metering_2, col = "red")
  lines(Date, Sub_metering_3, col = "blue")
  legend("topright", lwd = 2, bty = "n", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

  plot(Date, Global_reactive_power, pch = 27, xlab = "datetime", ylab = "Global_reactive_power")
  lines(Date, Global_reactive_power)  
})
dev.off()