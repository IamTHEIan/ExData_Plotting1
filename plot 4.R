library(lubridate)
library(purrr)
library(dplyr)
# Read in data
EPC <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, stringsAsFactors = FALSE)
# Cleaning Data: 
# Convert Data and Time into Date objects 
EPC$Date <- as.Date(EPC$Date, "%d/%m/%Y") 
EPC$Time <- ymd_hms(paste(EPC$Date, EPC$Time))
# Convert other variables into numeric
EPC[3:9] <- map(3:9, function(k){
  vector <- EPC[[k]]
  EPC[[k]] <- as.numeric(vector)
})
# Select the first two days in Feburary, 2007
EPC <- EPC %>%
  filter(Date == "2007-02-01" | Date == "2007-02-02")

# Plot 4
png("plot4.png", width = 480, height = 480)
par(mfrow=c(2,2))
# 1st plot
plot(x= EPC$Time, y = EPC$Global_active_power, type = "l",ylab = "Global Active Power", xlab = "", xaxt = "n")
axis(side = 1, at = ymd_hms(c("2007-02-01 00:00:00", "2007-02-02 00:00:00", "2007-02-03 00:00:00")), labels=c("Thu", "Fri", "Sat"))
# 2nd plot
plot(x = EPC$Time, y = EPC$Voltage, xlab = "datetime", ylab = "Voltage", type = "l", xaxt = "n")
axis(side = 1, at = ymd_hms(c("2007-02-01 00:00:00", "2007-02-02 00:00:00", "2007-02-03 00:00:00")), labels=c("Thu", "Fri", "Sat"))
# 3rd plot
plot(x = EPC$Time, y = EPC$Sub_metering_1, type = "n", xaxt = "n", ylab = "Energy sub metering", xlab = "")
axis(side = 1, at = ymd_hms(c("2007-02-01 00:00:00", "2007-02-02 00:00:00", "2007-02-03 00:00:00")), labels=c("Thu", "Fri", "Sat"))
lines(x = EPC$Time, y = EPC$Sub_metering_1, col = "black")
lines(x = EPC$Time, y = EPC$Sub_metering_2, col = "red")
lines(x = EPC$Time, y = EPC$Sub_metering_3, col = "blue")
legend(x = "topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = 1)
# 4th plot
plot(x= EPC$Time, y = EPC$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power", xaxt = "n")
axis(side = 1, at = ymd_hms(c("2007-02-01 00:00:00", "2007-02-02 00:00:00", "2007-02-03 00:00:00")), labels=c("Thu", "Fri", "Sat"))

dev.off()