

setwd("~/R/Hopkins_Data_Science_Specialization/Exploratory_Data_Analysis")

data <- read.delim("household_power_consumption.txt", sep = ";")

# dim(data) #2075259 9
#names(data)
#[1] "Date"                  "Time"                  "Global_active_power"   "Global_reactive_power"
#[5] "Voltage"               "Global_intensity"      "Sub_metering_1"        "Sub_metering_2"       
#[9] "Sub_metering_3"  


# parse "Date"
library(lubridate)
data[,"Date"] <- dmy(data[,"Date"])

#get the data for the days we want
a <- data[data[,"Date"]==dmy("01-02-2007"),]
b <- data[data[,"Date"]==dmy("02-02-2007"),]

# and save them seperately. 
write.table(a, "01-02-2007.txt", sep = ",",row.names = FALSE, quote = FALSE)
write.table(b, "02-02-2007.txt", sep = ",",row.names = FALSE, quote = FALSE)

# dim(a) 1440 9
# dim(b) 1440 9


