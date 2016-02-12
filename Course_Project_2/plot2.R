

# set working directory
setwd("~/R/Hopkins_Data_Science_Specialization/Exploratory_Data_Analysis/Course_Project_2")

#read in data or not if it's already loaded
if(!"NEI" %in% ls()){
    NEI <- readRDS("./exdata-data-NEI_data/summarySCC_PM25.rds")
    SCC <- readRDS("./exdata-data-NEI_data/Source_Classification_Code.rds")
    
}

# Have total emissions from PM2.5 decreased in the Baltimore City,
# Maryland (fips == "24510") from 1999 to 2008? Use the base plotting
# system to make a plot answering this question.
 
Maryland <- NEI[NEI$fips=="24510",]
dim(Maryland)
# [1] 2096    6

# We only want to look at the Emissions from sources (SCC) that existed
# from 1999 to 2008
both <- intersect(Maryland[Maryland$year=="1999","SCC"],Maryland[Maryland$year=="2008","SCC"])
length(both)
# [1] 115
newMaryand <- Maryland[Maryland$SCC %in% both,]

# get the sum for each year
a <- with(newMaryland, tapply(Emissions, year, sum) )
# plot it and save it
png("plot2.png")
plot(x = as.numeric(names(a)), 
     y = a,
     type = "b",
     pch = 19,
     xlab = "year",
     ylab = "PM2.5 (tons)",
     main = "Total PM2.5 from Baltimore City, Maryland"
     )
dev.off()

# total emmisions have dropped in Baltimore City
