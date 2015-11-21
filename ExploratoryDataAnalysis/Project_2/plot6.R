## Project 2 - Plot 6
## Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources 
##   in Los Angeles County, California (fips == 06037). 
## Which city has seen greater changes over time in motor vehicle emissions?
##---------------------------------------------------------------------------------------------------------##

# Load libraries, and set default options
library(data.table)
library(ggplot2)
library(stats)
options(scipen = 999) # Remove scientific notation default option, use '1000000' instead of '1.0e+5'

# If file not present, download & unpack file
DownURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
if(!file.exists("summarySCC_PM25.rds") & !file.exists("Source_Classification_Code.rds")) {
     download.file(DownURL, "Datafile.zip", method = "curl")
     unzip("Datafile.zip")
     unlink("Datafile.zip")
}

# Read in files using the readRDS() function
NEIdata <- data.table(readRDS("summarySCC_PM25.rds"))
SCCdata <- data.table(readRDS("Source_Classification_Code.rds"))

# Create data
mobileSCC <- grepl("Mobile - On-Road", SCCdata$EI.Sector) # create True/False table w/ motor vehicle
subSCC <- SCCdata[mobileSCC] # subset SCCdata
mergedSCC <- NEIdata[!is.na(match(NEIdata$SCC, subSCC$SCC)) & (NEIdata$fips == "24510" | NEIdata$fips == "06037")] # match SCC in tables for Baltimore City &/ LA
SumData <- aggregate(Emissions ~ year + fips, mergedSCC, sum) # Sum Emissions by year using mergedSCC data
names(SumData) <- c("Year", "Area", "Emissions") # Edit Labels

# Make Year & Area factors - a 'category' to be used in the plot
SumData$Year <- factor(SumData$Year) 
SumData$Area <- factor(SumData$Area, levels = c("24510", "06037"), labels = c("Baltimore City", "Los Angeles County"))

# Remove large datasets
rm(NEIdata)
rm(SCCdata) 

library(ColorPalette)

# Create Plot
ggplot(data = SumData, aes(x = Year, y = Emissions)) + 
     geom_bar(stat = "identity", fill=rgb(56,146,208, maxColorValue = 255)) +
     guides(fill = FALSE) +
     ylab(expression('Total PM'[2.5]*" Emissions")) + 
     ggtitle("Motor Vehicle Emissions, by Year and geography") + 
     facet_grid(Area ~ ., scales = "free")

# Save to file - plot will not be created until dev.off() is called
dev.copy(png, file="plot6.png", height=480, width=480)
dev.off()
