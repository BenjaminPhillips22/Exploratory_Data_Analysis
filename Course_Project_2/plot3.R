

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


# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad)
# variable, which of these four sources have seen decreases in emissions 
# from 1999–2008 for Baltimore City? Which have seen increases in emissions
# from 1999–2008? Use the ggplot2 plotting system to make a plot answer this question.

# 
Maryland <- NEI[NEI$fips=="24510",]
# find the sum for different type and year
a <- aggregate( Emissions ~ type+year, data = Maryland, sum)
# plot it and save it
library(ggplot2)
png("plot3.png")
g <- qplot(x = year,
           y = Emissions,
           data = a,
           geom = c("line","point"),
           facets = .~type,
           main = "Total PM2.5 from Baltimore City, Maryland for different types"
           )
print(g)
dev.off()

# non-point, non-road and on-road have all decreased since 1999
# point has increased since 1999



