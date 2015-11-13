Chana


Search for topics




Groups


POST REPLY	
13 of 21 (1)  




My groups
Home
Starred


Favorites
Click on a group’s star icon to add it to your favorites


Recently viewed


Recently posted to
Privacy - Terms of Service
Denver Metro Johns Hopkins Data Science MOOC Study Group ›
My Code for Assignment 2 with testing examples
1 post by 1 author 



me (C change) 	

Sep 23


Hi All,

I am including my code below. There are a lot of comments in the code. Jason, Levi, and I discussed that since our code is peer reviewed it is best to put lots of comments to help the reviewer understand what is going on. Hopefully, this will help elevate deducted points when the code is actually working. Let me know if you see anything I may have missed!
     Also, I included some testing examples below the functions so the reviewer can test the code. 

## The purpose of these two functions are to store the matrix and the
## inverse of a matrix for repeated use without having to 
## recalculate the matrix inversion multiple times.

## The 'makeCacheMatrix' function creates a special "matrix" 
## containing four nested functions: 'set', 'get', 'setInverse' & 'getInverse'. 
##   - 'set' is used to assign a matrix to the variable 
##   - 'get' is used to recall the existing matrix 
##   - 'setInverse' is used to assign an inverted matrix to the variable
##   - 'getInverse' is used to recall the stored inverted matrix.

## This function returns a list of values from the nested funcitons 
## that will be used by 'cacheSolve' to get or set the inverted matrix in cache.

makeCacheMatrix <- function(storeMatrix = matrix()) {
     
     ## initialize the variable to NULL. This variable will store the cached value.
     invMatrix <- NULL
     
     ## initialize the 'set' function, so a matrix can be stored
     set <- function(inputMatrix) {
          
          ## assign the input matrix storage
          storeMatrix <<- inputMatrix
          
          ## remove any record of previous inverted matrix
          invMatrix <<- NULL
     }
     
     ## initialize the 'get' function, so the stored matrix can be recalled
     get <- function() storeMatrix  
     
     ## initialize the 'setInverse' function, so the matrix inversion can be stored
     setInverse <- function(inverse) invMatrix <<- inverse  
     
     ## initialize the 'getinv' function, so the matrix inversion can be recalled
     getInverse <- function() invMatrix
     
     ## specify the stored commands
     list(set = set, 
          get = get,
          setInverse= setInverse,
          getInverse = getInverse)
}

## This function examines a cached matrix and runs the 'solve' command on it. 
## This function requires the matrix to be stored in the 'makeCacheMatrix' function prior to use.

## This function 1st checks to see if the cached matrix is square. If the matrix is not square, 
## an Error message, "Cannot invert matrix, matrix must be square to invert." is displayed.
## If the matrix is square the function will check to see if the inverse of the matrix is
## stored in 'inputMatrix$getInvers' (inverted matrix stored in cache).
## If the inverted matrix does not exist then the 'cacheSolve' function
## retrieves the inverse from 'inputMatrix$get' (matrix stored in cache before inversion).
## If the function cannot retrieve a cached value then the funciton will use the results from 
## the 'makeCacheMatrix' and compute the inverse using the 'solve()' function.
## The function will return the inverse of the matrix.

cacheSolve <- function(inputMatrix, ...) {
     
     ## check to make sure that the cached matrix is square (only square matrices can be inverted)     
     if(nrow(inputMatrix$get()) == ncol(inputMatrix$get())) {
          
          ## check if there is a cached inverted matrix
          currInverse <- inputMatrix$getInverse()
          
          # if the inverted matrix is stored in cache, send a message "getting cached data"
          if(!is.null(currInverse)) {
               message("getting cached data")
               return(currInverse)
               
          } else {
               ## get the cached matrix (the cached Inverted matrix was not found)
               data <- inputMatrix$get()
               
               ## invert the cached matrix using the solve() function
               currentInverse <- solve(data, ...)
               
               ## set inverted matrix in the cached matrix
               inputMatrix$setInverse(currentInverse)
               
               ## display the inverted matrix
               currInverse
          }
     }else { ## If the cached matrix is not square, return an error
          message("ERROR: Cannot invert matrix, matrix must be square to invert.")
     }
}

## ** Testing Code: **  

## > source(cachematrix.R)
## > my_matrix <- makeCacheMatrix((matrix(1:4, 2, 2)))
## > my_matrix$get()
##      [,1] [,2]
## [1,]    1    3
## [2,]    2    4

## > cacheSolve(my_matrix)
##   NULL

## > cacheSolve(my_matrix)
## getting cached data
## [,1] [,2]
## [1,]   -2  1.5
## [2,]    1 -0.5

## > my_matrix$getInverse()
## [,1] [,2]
## [1,]   -2  1.5
## [2,]    1 -0.5

## > my_matrix$set(matrix(c(2, 2, 1, 4), 2, 2))
## > my_matrix$get()
## [,1] [,2]
## [1,]    2    1
## [2,]    2    4

## > my_matrix$getInverse()
## NULL

## > cacheSolve(my_matrix)
## NULL

## > cacheSolve(my_matrix)
## getting cached data
## [,1]       [,2]
## [1,]  0.6666667 -0.1666667
## [2,] -0.3333333  0.3333333

## > my_matrix$getInverse()
## [,1]       [,2]
## [1,]  0.6666667 -0.1666667
## [2,] -0.3333333  0.3333333

Click here to Reply
