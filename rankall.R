## Convert the inputted 'outcome' to all lowercase characters
## If the 'num' input is not a numeric value, convert 'num' to all lowercase
## Read outcome data
## Load variable 'states' with only 1 valid state, no doubles
## Create a data frame,  of the possible outcomes and their respective columns in the dataset
## Label the 'OutcomesCheck' table (initialized in the line above) with the correct column names
## Check if the inputted 'outcome' is within specified outcomes, if not stop function send error msg
## - Is inputted ranking 'num', a number, the text "best", or the text "worst", if not stop function send error msg
## Assign the 'ColNum' variable with the matching column number for the outcome inputted
## Initialize the final data frame, so data can be received in the for loop on states
## Loop through states from "OutcomeData' 
## - subset complete 'OutcomeData' with only data on the inputted state, that have available outcome data, 
## - ... and only the relevant columns
## - rename column names of 'StateData' to be what is expected on output
## - order 'StateData' by outcome rate, ascending
## Determine Ranking
## - if 'best' was specified for ranking, return the top hospital on the list
## - if 'worst' was specified for ranking, return the bottom hospital on the list
## - otherwise return the hospital on the list that matches the inputed ranking
## - if no rank for state, assign a null response with that state
## Merge the current state's data into the 'AllList' data frame
## Rename the columns of the 'AllList' data frame
## Order the 'AllList' data frame by state
## Return the 'AllList' data frame (rankings for all hospitals by name and associtated state)

rankall <- function(outcome, num = "best") {
     outcome <- tolower(outcome) 
     if(!(class(num) == "numeric")) {
          num <- tolower(num) 
     }
     OutcomeData <- read.csv("outcome-of-care-measures.csv", stringsAsFactors=FALSE, na.strings="Not Available")
     StateList <- unique(OutcomeData$State)
     
     ## Create data frame and load with correct column names
     OutcomeCheck <- data.frame(matrix(c("heart attack", "heart failure", "pneumonia", 11, 17, 23), 3, 2)) 
     colnames(OutcomeCheck) <- c("Outcome", "ColNum")
     
     ## Check 'outcome' is in specified out come and check if num meets criteria, proceed with ranking
     if(!(outcome %in% OutcomeCheck$Outcome)){ 
          stop("invalid outcome")
     } else if(!(class(num)=="numeric") & !(num=="best") & !(num=="worst")) {
          stop("invalid ranking")
     } else {
          ## Match columns to outcomes, initialize data frame to be used in loop for states
          ColNum <- as.numeric(as.vector(subset(OutcomeCheck, Outcome==outcome)$ColNum))
          AllList <- data.frame(Hospital.Name=character(), "State"=character(), stringsAsFactors = FALSE)
          
          ## Loop over the states in the state listo
          for(i in StateList) {
               ## subset the complete 'OutcomeData'- only data on inputted state, that have available outcome data, and only relevant columns
               StateData <- OutcomeData[OutcomeData[,"State"] == i & !(is.na(OutcomeData[,ColNum])), c("Hospital.Name", "State", colnames(OutcomeData[ColNum]))]
               
               ## rename column names of 'StateData' and order in ascending
               colnames(StateData) <- c("Hospital.Name", "State", "Rate")
               StateData <- StateData[order(StateData$Rate, StateData$Hospital.Name),]
               
               ## Determine ranking
               if(num == "best") { 
                    StateDump <- StateData[1, c("Hospital.Name", "State")]
               } else if(num == "worst") {
                    StateDump <- StateData[nrow(StateData), c("Hospital.Name", "State")]
               } else {
                    StateDump <- StateData[num, c("Hospital.Name", "State")]
               }
               if(is.na(StateDump$State)) { 
                    StateDump$State <- i
               }
               ## Merge the current state's data into the 'AllList' data frame
               AllList <- rbind(AllList, StateDump)
          }
          ## rename the columns of the 'AllList' data frame, and order by state
          colnames(AllList) <- c("hospital", "state") 
          AllList <- AllList[order(AllList$state),]
          
          ## return the 'AllList' data frame
          return(AllList)
     }
}
