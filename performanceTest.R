## This script executes a simple performance comparison between computing
## several times in a row the inverse of a (relatively) large matrix using
## the default R function 'solve' versus the same computation using the
## cached matrix inverse functions 'makeCacheMatrix' and 'cacheSolve'

## We start by sourcing the cachematrix.R script
if (file.exists("cachematrix.R")) {
    source("cachematrix.R")
}

## Compute the inverse using solve
inverse_compute <- function(m, it) {
    for (i in 1:it) im <- solve(m)
    im
}

## Compute the inverse using solveCache
cache_inverse_compute <- function(m, it) {
    for (i in 1:it) im <- cacheSolve(m)
    im
}

## The perfTest() function reports the difference betwee the running time 
## of a large matrix inversion a number of times using the solve() function and 
## the running time of the same matrix inversion using the cacheSolve() function
## developed for the programming assignment. The function has 2 arguments:
##      - m_size = number of rows and columns of the matrix to be inverted
##      - iterations = number of times the matrix will be inverted
deltaTime <- function(m_size = 500, iterations = 10) {
    ## Check if the functions required by cached inverse are available
    if (!exists("cacheSolve") | !exists("makeCacheMatrix")) {
        message(paste("Can not find cache matrix inversion functions.",
                      "Please source the 'cachematrix.R' file and try again."))
        return(NA)
    }
    
    ## Generate the matrix to be inverted
    mat <- matrix(runif(m_size ^ 2, -3, 3), nrow = m_size, ncol = m_size)
    
    ## Create the cache matrix object using makeCacheMatrix
    cache_mat <- makeCacheMatrix()
    cache_mat$set(mat)
    
    ## Measure the time it takes to do the inversion using solve()
    time1 <- as.vector(system.time(
        inverse_mat <- inverse_compute(mat, iterations)))
    
    ## Measure the time it takes to do the inversion using cacheSolve()
    time2 <- as.vector(system.time(
        cache_inverse_mat <- cache_inverse_compute(cache_mat, iterations)))
    
    ## Report on the computing time and speedup
    speedup <- time1[1] / time2[1]
    
    ## Report the results
    message(paste(" Number of iterations:",iterations,"\n",
                  "Matrix size:",m_size,"x",m_size,"\n",
                  "Running time for 'solve()':",time1[1],"sec.\n",
                  "Running time for 'cacheSolve()':",time2[1],"sec.\n",
                  "Speed-up:",speedup,"times"))
    
    ## Cleanup the environment
    rm(inverse_mat)
    rm(cache_inverse_mat)
    rm(time1)
    rm(time2)
    rm(speedup)
}
