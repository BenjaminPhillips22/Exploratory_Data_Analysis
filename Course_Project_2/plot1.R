
# set working directory
setwd("~/R/Hopkins_Data_Science_Specialization/Exploratory_Data_Analysis/Course_Project_2")

# original file URL
downloadUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"

# file check
if (!file.exists("summarySCC_PM25.rds") | !file.exists("Source_Classification_Code.rds")) {
    download.file(downloadUrl, destfile = "data.zip")
    unzip("data.zip")
    file.remove("data.zip")
}

#read in data or not if it's already loaded
if(!"NEI" %in% ls()){
    NEI <- readRDS("summarySCC_PM25.rds")
    SCC <- readRDS("Source_Classification_Code.rds")
    
}

# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
# Using the base plotting system, make a plot showing the total PM2.5 emission 
# from all sources for each of the years 1999, 2002, 2005, and 2008.

table(NEI$year)
# 1999    2002    2005    2008 
# 1108469 1698677 1713850 1976655 

# we want to compare the total PM2.5 emission for each year, but different
# years have different numbers of observations. Totals aren't comparable. 

# get the sum for each year
a <- with(NEI, tapply(Emissions, year, sum) )
# plot it and save it
png("plot1.png")
plot(x = as.numeric(names(a)), 
     y = a,
     type = "b",
     pch = 19,
     xlab = "year",
     ylab = "PM2.5 (tons)",
     main = "Total PM2.5 from all sources"
     )
dev.off()

# Every year there are more observations. In spite of this, the sum of all
# the observations has decreased every 3 years. 

