## The 'makeCacheMatrix' function returns a list object that contains four 
## functions:
##      1. 'set' - function which sets the square matrix 'x' to a user-provided 
##         square matrix (the input argument of 'set') and assignes NULL to the 
##         'inverse' matrix
##      2. 'get' - function which returns the square matrix 'x'
##      3. 'setinverse' - function which sets the 'inverse' matrix to the 
##         user-provided inverse of matrix 'x'
##      4. 'getinverse' - function which returns the stored 'inverse' object
##
## Note: The list can have both matrices 'x' and 'inverse' or only the 'inverse'
## matrix set to NULL
makeCacheMatrix <- function(x = matrix()) {
    inverse <<- NULL
    if (class(x) != "matrix" | nrow(x) != ncol(x)) {
        message("The argument of 'makeCacheMatrix' must be a square R 'matrix' 
                object. Will set the matrix to matrix()")
        x <- matrix()
    }
    
    ## Set the original matrix 'x'
    set <- function(y) {
        if (class(y) != "matrix" | nrow(y) != ncol(y)) {
            message("The argument of 'set' must be a square R 'matrix' object. 
                    Matrix not changed.")
            return(NULL)
        }
        x <<- y
        inverse <<- NULL
    }
    
    ## Get the original marix 'x'
    get <- function() x
    
    ## Set the inverse of the 'x' matrix
    setinverse <- function(matrix_inverse) {
        ## Before setting the 'inverse' we check if the user-provided 
        ## 'matrix_inverse' is indeed the inverse matrix of 'x'
        ## (we check the equality: matrix_inverse * x == I) 
        if (!all.equal(matrix_inverse %*% x, diag(nrow(matrix_inverse)))) {
            message("The argument is NOT the inverse of the internally stored 
                    matrix. The inverse will not be set.")
        } else {
            inverse <<- matrix_inverse
        }
    }
    
    ## Get the inverse of the 'x' matrix
    getinverse <- function() inverse
    
    ## Create and return the list used to cache a matrix and it's inverse
    list(set = set, get = get, setinverse = setinverse, getinverse = getinverse)
}


## The 'cacheSolve' function returns the inverse of a matrix stored in an object 
## created with the 'makeCacheMatrix' function. The function returns 'NULL' if 
## the argument 'x' has not been created with 'makeCacheMatrix'. There are two 
## possible use cases:
##      1. The inverse of the matrix stored in 'x' has been computed once 
##         with 'cacheSolve' function. In this case the inverse is stored in the 
##         object 'x' and will be returned without doing any computations;
##      2. The inverse of the matrix stored in 'x' has not been computed (the 
##         inverse stored in the 'x' object is NULL). In this case, the 
##         'cacheSolve' function will perform the following tasks:
##              - retrieve the matrix stored in 'x'
##              - compute the inverse using the 'solve' function
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
    
    ## If the matrix returned by 'x$getinverse' is NULL, will compute the 
    ## inverse and store it back into the object 'x'
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
