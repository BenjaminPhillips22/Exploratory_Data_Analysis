
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

# Across the United States, how have emissions from coal combustion-related 
# sources changed from 1999–2008?

# look at SCC and use grip to find which columns have coal and combustion
# head(SCC[grep("coal", SCC$SCC.Level.Four, ignore.case = TRUE),"SCC.Level.Four"])
# head(SCC[grep("combustion", SCC$SCC.Level.One, ignore.case = TRUE),"SCC.Level.Four"])

combustionSources <- SCC[grep("combustion", SCC$SCC.Level.One, ignore.case = TRUE),"SCC"]
coalSources <- SCC[grep("coal", SCC$SCC.Level.Four, ignore.case = TRUE),"SCC"]
# we want the intersection of these...
coalCombSources <- intersect(combustionSources,coalSources)

coalComb_df <- NEI[NEI$SCC %in% coalCombSources,]
a <- aggregate(Emissions~year, coalComb_df, sum)

png("plot4.png")
library(ggplot2)
g <- qplot(x = year,
      y = Emissions,
      data = a,
      geom = c("point","line"),
      main = "Coal Combustion Emissions"
      )
print(g)
dev.off()

# coal combustion related emissions have decreased since 1999

