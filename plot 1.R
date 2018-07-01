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


# Plot 1
png("plot1.png", width = 480, height = 480)
hist(EPC$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()
