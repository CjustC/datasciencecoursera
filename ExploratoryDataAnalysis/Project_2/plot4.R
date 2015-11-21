## Project 2 - Plot 4
## Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?
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

# Create Data
coalSCC <- grepl("Fuel Comb", SCCdata$EI.Sector) & grepl("Coal", SCCdata$EI.Sector) # create True/False table w/ coalresources
subSCC <- SCCdata[coalSCC] # subset SCCdata
mergedSCC <- NEIdata[!is.na(match(NEIdata$SCC, subSCC$SCC))] # find mathing SCC in both NEI and subSCC w/o NAs
SumData <- aggregate(Emissions ~ year, mergedSCC, sum) # Sum Emissions by year using mergedSCC data
names(SumData) <- c("Year", "Emissions") # Edit Labels
SumData$Year <- factor(SumData$Year) # Make factor for Year to make it is now a 'category' to be used in the plot

# Create Plot - dividing by 1000 for readability
ggplot(data = SumData, aes(x = Year, y = Emissions / 1000)) + 
     geom_bar(stat = "identity", fill = "blue") + 
     ylab(expression('Total PM'[2.5]*" Emissions in tonnes")) + 
     ggtitle("Coal Emissions Through the USA by Year")

# Save to file (plot will not be created until dev.off() is called)
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()

