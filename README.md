### R Programming - Solution description

This repository contains the solution to the second programming 
assignment of the R Programming course: Caching the Inverse of a Matrix.
The repository has been created by clonning @rdpeng/ProgrammingAssignment2.
The original README.md file has been renamed to original.repo.README.md
Following is a brief description of each file:

* README.md - this file
* original.repo.README.md - the assignment specification (original README.md)
* cachematrix.R - R script containing the assignment solution
* performanceTest.R - R script for performance testing/comparison

### Functions documentation

The two functions implemented in the `cachematrix.R` script (`makeCacheMatrix`
and `cacheSolve`) have been briefly described via the comments in R script (as 
recommended in the assignment specification).
To check the `cachematrix.R` script, simply open it in the web browser or 
download it in a folder on your computer and open it in R Studio.
After downloading the R scripts in the R working directory, the 
following code sequence can be used to test the two functions implemented
in `cachematrix.R`. The statements will perform the following tasks:

1.  create list object `cache_m` with `makeCacheMatrix()` function
2.  create a square (100x100) matrix `m` with random data
2.  set the data of `cache_m` by calling `cache_m$set(m)`
3.  compute the inverse of `m` using `direct_inverse <- solve(m)` 
4.  compute the inverse of `m` using `cached_inverse <- cacheSolve(cache_m)`
5.  check the `direct_inverse` and `cached_inverse` are equal

<!-- -->
    
    source("cachematrix.R")
    cache_m <- makeCacheMatrix()
    m <- matrix(runif(10000, -3, 3), nrow = 100, ncol = 100)
    cache_m$set(m)
    direct_inverse <- solve(m)
    cached_inverse <- cacheSolve(cache_m)
    isTRUE(all.equal(direct_inverse, cached_inverse))
    

### Performance testing

The second R script in the repository - `performanceTest.R` - can be used to
determine the impact on performance of using the cached inverse of a matrix
instead of computing it repeatedly with `solve()`.
To test the difference in performance between `cacheSolve()` and `solve()` 
first download all R scripts in the current working directory of R/R Studio
on your machine and then source the `performanceTest.R` script.
Next, use the main function `deltaTime()` to measure the difference in 
performance between the two approaches of computing the inverse of a square 
matrix. The default values of the arguments used by the `deltaTime()` 
function are `m_size = 100` - the size of the matrix to be used for 
computing the inverse (100x100) and `iterations = 10`, the number of times
the inverse is computed using both approaches - direct and cached.
Following is an example of the output of deltaTime() called without arguments
(use the default values for the arguments):

      > source("performanceTest.R")
      > deltaTime()
       Number of iterations: 10 
       Matrix size: 100 x 100 
       Running time for 'solve()': 0.0190000000000001 sec.
       Running time for 'cacheSolve()': 0.00300000000000011 sec.
       Speed-up: 6.33333333333314 times

You can experiment with different matrix sizes by specifying the `m_size` 
argument and different number of iterations by specifying the  
`iterations` argument.
