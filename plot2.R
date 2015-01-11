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

png(filename = "plot2.png")
with(powerConsumption, plot(Date, Global_active_power, pch = 27, xlab = "", ylab = "Global Active Power (kilowatts)"))
with(powerConsumption, lines(Date, Global_active_power))
dev.off()