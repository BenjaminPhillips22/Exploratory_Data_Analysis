
# set working directory
setwd("~/R/Hopkins_Data_Science_Specialization/Exploratory_Data_Analysis/Course_Project_2")

#read in data or not if it's already loaded
if(!"NEI" %in% ls()){
    NEI <- readRDS("./exdata-data-NEI_data/summarySCC_PM25.rds")
    SCC <- readRDS("./exdata-data-NEI_data/Source_Classification_Code.rds")
    
}

# How have emissions from motor vehicle sources changed
# from 1999–2008 in Baltimore City?

# look at data and use grep to find where Motor Vehicle is
motorVehicleSources <- SCC[grep("vehicle", SCC$SCC.Level.Three, ignore.case = TRUE),"SCC"]
BaltimoreSources <- NEI[NEI$fips=="24510","SCC"]
#sources with the word 'vehicle' and are in Baltimore
both <- intersect(motorVehicleSources,BaltimoreSources)
mvBaltimore_df <- NEI[NEI$SCC %in% both,]

a <- aggregate(Emissions~year, mvBaltimore_df, sum)

png("plot5.png")
library(ggplot2)
g <- qplot(x = year,
           y = Emissions,
           data = a,
           geom = c("point","line"),
           main = "Vehicle Emissions in Baltimore city, Maryland"
)
print(g)
dev.off()

# Vehicle Emissions in Baltimore city, Maryland have decreased since 1999

