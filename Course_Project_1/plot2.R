


setwd("~/R/Hopkins_Data_Science_Specialization/Exploratory_Data_Analysis")

#read in data for our dates
a <- read.csv("01-02-2007.txt")
b <- read.csv("02-02-2007.txt")

#combine the two days
data <- rbind(a,b)

# put the date and time together in another column
library(lubridate)
q <- (data[,c("Date","Time")])
q <- paste(q[,1],q[,2])
q <- strptime(q, format = "%Y-%m-%d %H:%M:%S")
data <- cbind(data,"DateTime"=q)

# Open dev
png("plot2.png")
with(data, plot(DateTime, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)"))
dev.off()