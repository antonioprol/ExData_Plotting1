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

# Plot 1
png(file="plot1.png")
hist(dataf$Global_active_power, col="red", xlab="Global Active Power (kilowatts)", main = "Global Active Power")
dev.off()
