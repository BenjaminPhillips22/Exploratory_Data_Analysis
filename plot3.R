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
png("plot3.png")
with(data, plot(DateTime, Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering"))
with(data, lines(DateTime, Sub_metering_2, type = "l", col = "red"))
with(data, lines(DateTime, Sub_metering_3, type = "l", col = "blue"))
legend("topright", col = c("black", "red", "blue"), c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lwd = 1)
dev.off()

