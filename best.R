## Read outcome data
## Load variable 'validOutcome' with specified outcomes
## Check if 'outcome' is valid, if not then stop the function and send message
## Load variable 'validState' removing doubles by using 'unique' - note: index [,7] will select the State column
## Check if 'state' is in 'validState', if not then stop the function and send message
## Load variable 'fullColName' with specified column names that match the .csv file
## Convert 'outcome' name with column name and put in variable 'colName'
## Match 'state' with 'data$State' and put into 'data.state'
## Load variable 'lowest' with the name of the hospital with the lowest 30 day death rate
## - match 'data.state' to correct 'colName' and put into variable 'colName'
## - 'as.numeric' to change vector from character to numeric (min doesn't work on character)
## - 'which.min' -- 'which' gives the TRUE indices and using with 'min' to get the lowest rate 
## Return hospital name in that state with lowest 30-day death rate


best <- function(state, outcome) {
     
     ## Read outcome data
     data <- read.csv("outcome-of-care-measures.csv", colClasses = "character", na.strings="Not Available")
     
     ## Check that state and outcome are valid
     validOutcome = c("heart attack","heart failure","pneumonia")
     if (!outcome %in% validOutcome) { stop("invalid outcome")}
     
     validState = unique(data[,7])
     if (!state %in% validState) stop("invalid state")
     
     ## convert outcome name into column name
     fullColName <- c("Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack", "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure", "Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia")
     colName <- fullColName[match(outcome,validOutcome)]
     
     ## Return hospital name in that state with lowest 30-day death rate
     data.state <- data[data$State==state,]
     lowest <- which.min(as.numeric(data.state[,colName]))
     data.state[lowest,"Hospital.Name"]
}
