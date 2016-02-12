
# set working directory
setwd("~/R/Hopkins_Data_Science_Specialization/Exploratory_Data_Analysis/Course_Project_2")

#read in data or not if it's already loaded
if(!"NEI" %in% ls()){
    NEI <- readRDS("./exdata-data-NEI_data/summarySCC_PM25.rds")
    SCC <- readRDS("./exdata-data-NEI_data/Source_Classification_Code.rds")
    
}

# Compare emissions from motor vehicle sources in Baltimore City with
# emissions from motor vehicle sources in Los Angeles County, 
# California (fips == "06037"). Which city has seen greater changes
# over time in motor vehicle emissions?

# Baltimore vehicle Emissions sum
motorVehicleSources <- SCC[grep("vehicle", SCC$SCC.Level.Three, ignore.case = TRUE),"SCC"]
B <- NEI[NEI$fips=="24510","SCC"]
B <- intersect(motorVehicleSources,B)
B <- NEI[NEI$SCC %in% B,]
B <- aggregate(Emissions~year, B, sum)
B <- cbind(city = rep("Baltimore",4), B)
B[,"Emissions"] <- B[,"Emissions"]/B[1,"Emissions"] 

# Los Angeles vehicle Emissions sum
#motorVehicleSources <- SCC[grep("vehicle", SCC$SCC.Level.Three, ignore.case = TRUE),"SCC"]
LA <- NEI[NEI$fips=="06037","SCC"]
LA <- intersect(motorVehicleSources,LA)
LA <- NEI[NEI$SCC %in% LA,]
LA <- aggregate(Emissions~year, LA, sum)
LA <- cbind(city = rep("Los Angeles",4), LA)
LA[,"Emissions"] <- LA[,"Emissions"]/LA[1,"Emissions"]

df <- rbind(B,LA)

png("plot6.png")
library(ggplot2)
g <- qplot(x = year,
           y = Emissions,
           data = df,
           geom = c("point","line"),
           main = "              Decrease in Vehicle Emissions in Baltimore and Los Angeles",
           col = city
           )
print(g)
dev.off()

# Baltimore has a greater decrease in Emissions since 1999 compared to Los Angeles







