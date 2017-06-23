# Check working directory, if necessary
#setwd("ExData_Plotting1")
# Check locale, if necessary
#Sys.setlocale("LC_TIME","English_United States.1252")
library(lubridate)
library(dplyr)
# Read complete table
data <- tbl_df(read.table("household_power_consumption.txt", header=TRUE, sep=";", stringsAsFactors = FALSE))
# Convenient class type for variables
data <- mutate(data, Date=dmy(Date))
cols = c(3:9)
data[,cols] = apply(data[,cols], 2, function(x) as.numeric(as.character(x)))
# Filter by desired dates
dataf <- filter(data, Date >= "2007-02-01" & Date <= "2007-02-02")
# Remove records with missing values, if any
good <- complete.cases(dataf)
dataf <- filter(dataf, good)
# Add column with appropriate datetime variable
dataf$datetime <- strptime(paste(as.character(dataf$Date), dataf$Time), format = "%Y-%m-%d %H:%M:%S")

# Plot 4
png(file="plot4.png")
par(mfrow=c(2,2))
with(dataf,plot(datetime, Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)"))
with(dataf,plot(datetime, Voltage, type="l"))
with(dataf,plot(datetime, Sub_metering_1, type="l", col="black", xlab="", ylab="Energy sub metering"))
with(dataf, lines(datetime, Sub_metering_2, col="red"))
with(dataf, lines(datetime, Sub_metering_3, col="blue"))
legend("topright", lty=1, col=c("black","red","blue"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
with(dataf,plot(datetime, Global_reactive_power, type="l"))
dev.off()
