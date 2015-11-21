# Project 2 - Plot 1
# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008?
#-------------------------------------------------------------------------------------#

# Load libraries, and set default options
library(data.table)
library(ggplot2)
library(stats)
options(scipen = 999) # remove scientific notation default to use '1000000' instead of '1.0e+5'

## If file not present, download & unpack file
DownURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
if(!file.exists("summarySCC_PM25.rds") & !file.exists("Source_Classification_Code.rds")) {
     download.file(DownURL, "Datafile.zip", method = "curl")
     unzip("Datafile.zip")
     unlink("Datafile.zip")
}

# Read in file using the readRDS() function
NEI <- data.table(readRDS("summarySCC_PM25.rds"))

# Sum Emissions totals by year, edit labels, and remove large dataset
SumData <- aggregate(Emissions ~ year, NEI, sum)
names(SumData) <- c("Year", "Emissions")
rm(NEI)

# Create plot - dividing by 1,000,000 for readability
barplot(SumData$Emissions / 1000000, 
        names.arg = SumData$Year, xlab="Year", 
        ylab=expression('total PM'[2.5]*' Emission (in millions of tonnes)'),
        main=expression('Total PM'[2.5]*' Emission Levels through USA, by Year'))

# Save to file - plot will not be created until dev.off() is called
dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()

