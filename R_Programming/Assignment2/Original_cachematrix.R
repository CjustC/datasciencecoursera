## The purpose of these two functions are store a matrix and the 
## inverse of that matrix for repeated use without having to 
## recalculate the matrix inversion multiple times.

## The 'makeCacheMatrix' function creates a special "matrix" 
## containg four functions nested: 'set', 'get', 'setInverse' & 'getInverse'. 
## 'set' is used to assign a matrix to the variable, 
## 'get' is used to recall the existing matrix, 
## 'setInverse' is used to assign an inverted matrix to the variable
## and 'getInverse' is used to recall the stored inverted matrix.

## The function returns a list of values from the nested funcitons 
## that will be used by 'cacheSolve' to get or set the inverted matrix in cache.


makeCacheMatrix <- function(x = matrix()) {
     inv <- NULL
     set <- function(y) {
          x <<- y
          inv <<- NULL
     }
     get <- function() x
     setInverse <- function(inverse) inv <<- inverse
     getInverse <- function() inv
     list(set = set, 
          get = get,
          setInverse= setInverse,
          getInverse = getInverse)
     
}

## This function examines a cached matrix and runs the 'solve' command on it. 
## Requires the matrix to be stored in the 'makeCacheMatrix' function prior to use.
## This function 1st checks to see if the inverse of the matrix is 
## stored in cache.
## If the inverted matrix does not exist in cache, 'cacheSolve' 
## retrieves the inverse from cache. Otherwise, the funciton will use the results from 
## above and computes the inverse by using the 'solve()' function 
## and returning the inverse of the special matrix.

cacheSolve <- function(x, ...) {
     inv<- x$getInverse()
     if(!is.null(inv)) {
          message("getting cached data")
          return(inv)
     }
     data <- x$get()
     inv <- solve(data, ...)
     x$setInverse(inv)
     inv
}
