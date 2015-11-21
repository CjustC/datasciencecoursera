## Project 2 - Plot 2
## Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510")
## from 1999 to 2008?
##---------------------------------------------------------------------------------------------##

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

# Read in file using the readRDS() function
NEI <- data.table(readRDS("summarySCC_PM25.rds"))

# Subset data for Baltimore City 
subsetNEI <- NEI[NEI$fips == "24510"]

# Sum Emissions totals by year, Edit labels, and Remove large dataset
SumData <- aggregate(Emissions ~ year, NEI, sum)
names(SumData) <- c("Year", "Emissions")
rm(NEI)

# Increase y axis margin (side 2) to fit subscript -- default is c(5,4,4,2) + 0.1
par(mar = c(5,5,4,2) + 0.1)

# Create plot - dividing by 1,000,000 for readability
barplot(SumData$Emissions / 1000000, names.arg=SumData$Year, 
        main=expression('Total PM'[2.5]*' Emissions Baltimore City, by Year'), 
        xlab="Year", 
        ylab=expression('Total PM'[2.5]*' Emissions'), col = "red")

# Save to file - plot will not be created until dev.off() is called
dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()
