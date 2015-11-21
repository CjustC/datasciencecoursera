## Project 2 - Plot 5
## How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?
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

## Create data
mobileSCC <- grepl("Mobile - On-Road", SCCdata$EI.Sector) # create True/False table w/ motor vehicle
subSCC <- SCCdata[mobileSCC] # subset SCCdata
mergedSCC <- NEIdata[!is.na(match(NEIdata$SCC, subSCC$SCC)) & NEIdata$fips == "24510"] # match SCC in tables for Baltimore City
SumData <- aggregate(Emissions ~ year, mergedSCC, sum) # Sum Emissions by year using mergedSCC data
names(SumData) <- c("Year", "Emissions") # Edit Labels
SumData$Year <- factor(SumData$Year) # Make factor for Year to make a 'category' to be used in the plot

# remove large datasets
rm(NEIdata)
rm(SCCdata)

# Create plot
ggplot(data = SumData, aes(x = Year, y = Emissions)) + 
     geom_bar(stat = "identity", fill = "green") + 
     ylab("Emissions (in tonnes)") + 
     ggtitle("Motor Vehicle Emissions in Baltimore City, by Year")

# Save to file (plot will not be created until dev.off() is called)
dev.copy(png, file="plot5.png", height=480, width=480)
dev.off()
