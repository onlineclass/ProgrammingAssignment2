## Put comments here that give an overall description of what your
## functions do

## Write a short comment describing this function

makeCacheMatrix <- function(x = matrix()) {
    inverse <- NULL
    set <- function(y) {
        if (class(y) != "matrix") {
            message("The argument of 'set' must be a valid R 'matrix' object")
            return(NULL)
        }
        if (nrow(y) != ncol(y)) {
            message("The argument of 'set' must be a square R 'matrix' object")
            return(NULL)
        }
        x <<- y
        inverse <<- NULL
    }
    get <- function() x
    setinverse <- function(matrix_inverse) inverse <<- matrix_inverse
    getinverse <- function() inverse
    list(set = set, get = get, setinverse = setinverse, getinverse = getinverse)
}


## The 'cacheSolve' function returns the inverse of a matrix stored in an object 
## created with the 'makeCacheMatrix' function. The function return 'NULL' if 
## the argument 'x' has not been created with 'makeCacheMatrix. There are two 
## possible use cases:
##      1. The inverse of the matrix stored in 'x' has been computed once 
##         with 'cacheSolve' function. In this case the inverse is stored in the 
##         object 'x' and will be returned without any computations;
##      2. The inverse of the matrix stored in 'x' has not been computed (the 
##         inverse stored in the 'x' object is NULL). In this case, the 
##         'cacheSolve' function witll perform the following tasks:
##              - retrieve the the matrix stored in 'x'
##              - compte the inverse using the 'solve' function
##              - store back into 'x' the inverse
##              - return the inverse
cacheSolve <- function(x, ...) {
    ## Check if 'x' is an object created with the 'makeCacheMatrix' function
    if (!identical(c("set", "get", "setinverse", "getinverse"), names(x))) {
        message("The argument of cacheSolve must be an object created with 
                the 'makeCacheMatrix' function")
        return(NULL)
    }
    
    ## Retrieve the matrix inverse currently stored into 'x'
    matrix_inverse <- x$getinverse()
    
    ## If 'x'-stored inverse is NULL, will compute the inverse and store it back 
    ## into the object 'x'
    if (is.null(matrix_inverse)) {
        ## Get the data as a square matrix object
        data <- x$get()
        
        ## Compute the inverse
        matrix_inverse <- solve(data, ...)
        
        ## Store back into 'x' the inverse
        x$setinverse(matrix_inverse)
    }
    
    ## Return the inverse
    matrix_inverse
}
