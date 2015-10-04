## Read outcome data
## Load variable 'validOutcome' with specified outcomes
## Check if 'outcome' is valid, if not then stop the function and send message
## Load variable 'validState' removing doubles by using 'unique' - note: index [,7] will select the State column
## Check if 'state' is in 'validState', if not then stop the function and send message
## Load variable 'fullColName' with specified column names that match the .csv file
## Convert 'outcome' name with column name and put in variable 'colName'
## Match 'state' with 'data$State' and put into 'data.state'
## match 'data.state' to correct 'colName' and Hospital Name then order the results
## If 'best' was specified for ranking return the top hospital on the list
## If 'worst' was specified for ranking return the bottom hospital on the list
## Otherwise return the hospital on the list that matches the inputed ranking
## - 'NA' will be returned if 'num' is larger than the number of hospitals in the state


rankhospital <- function(state, outcome, num = "best") {
     ## Read outcome data
     data <- read.csv("outcome-of-care-measures.csv", colClasses = "character", na.strings="Not Available")
     
     ## Check that state and outcome are valid
     validOutcome = c("heart attack","heart failure","pneumonia")
     if (!outcome %in% validOutcome) { stop("invalid outcome")}
     
     validState = unique(data[,7])
     if (!state %in% validState) { stop("invalid state")}
     
     ## convert outcome name into column name
     fullColName <- c("Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack", "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure", "Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia")
     colName <- fullColName[match(outcome,validOutcome)]
     
     ## Return hospital name in that state with the given rank 30-day death rate
     data.state <- data[data$State==state,]
     
     # order data.state outcome rate, ascending
     sortedData <- data.state[order(as.numeric(data.state[[colName]]),data.state[["Hospital.Name"]],decreasing=FALSE,na.last=NA), ]
     
     if(num == "best") {
          sortedData[1,2]
     } else if(num == "worst") {
          sortedData[nrow(sortedData), 2]
     } else {
          sortedData[num, 2]
     }
}
