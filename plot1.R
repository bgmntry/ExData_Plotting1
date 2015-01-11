library(data.table)

if(!file.exists("household_power_consumption.txt")){
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = "power_consumption.zip");
  unzip("power_consumption.zip")
}

powerConsumption <- fread("household_power_consumption.txt")

powerConsumption <- rbind(powerConsumption[powerConsumption$Date == "1/2/2007"], powerConsumption[powerConsumption$Date == "2/2/2007"])

powerConsumption$Global_active_power <- as.numeric(powerConsumption$Global_active_power)

png(filename = "plot1.png")
hist(powerConsumption$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)", ylab = "Frequency")
dev.off()