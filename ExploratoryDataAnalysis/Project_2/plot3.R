## Project 2 - Plot 3
## Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
## which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? 
## Which have seen increases in emissions from 1999–2008?
##-------------------------------------------------------------------------------------------------##

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

# Sum Emissions totals by year and type, edit labels, and remove large dataset
SumData <- aggregate(Emissions ~ year + type, NEI, sum)
names(SumData) <- c("Year", "Type", "Emissions")
rm(NEI)

#  Make Year and Type factors -  now a 'category' to be used in the plot)
SumData$Year <- factor(SumData$Year)
SumData$Type <- factor(SumData$Type)

# Create plot
ggplot(data = SumData, aes(x = Year, y = Emissions)) + 
     geom_bar(stat = "identity", aes(color = Type, fill = Type)) + 
     facet_grid(Type ~ ., scales = "free") + 
     ylab(expression('Total PM'[2.5]*" Emissions in tonnes")) + 
     ggtitle("Emissions in Baltimore City, by Type and Year")

# Save to file (plot will not be created until dev.off() is called)
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()

