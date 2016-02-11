
# set working directory
setwd("~/R/Hopkins_Data_Science_Specialization/Exploratory_Data_Analysis/Course_Project_2")

#read in data
# NEI <- readRDS("./exdata-data-NEI_data/summarySCC_PM25.rds")
# SCC <- readRDS("./exdata-data-NEI_data/Source_Classification_Code.rds")


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
     type = "l",
     xlab = "year",
     ylab = "PM2.5 (tons)",
     main = "Total PM2.5 from all sources"
     )
dev.off()

# Every year there are more observations. In spite of this, the sum of all
# the observations has decreased every 3 years. 

