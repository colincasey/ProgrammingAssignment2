## Matrix inversion is usually a costly computation and their may be some benefit to caching the inverse of a matrix rather than compute it repeatedly

## This function creates a special "matrix" object that can cache its inverse
makeCacheMatrix <- function(x = matrix()) {
  inverse <- NULL
  
  get <- function() {
    x
  }
  
  set <- function(y) {
    x <<- y
    inverse <<- NULL
  }
  
  getInverse <- function() {
    inverse
  }
  
  setInverse <- function(i) {
    inverse <<- i
  }
  
  list(
    get = get,
    set = set,
    getInverse = getInverse,
    setInverse = setInverse
  )
}

## This function computes the inverse of the special "matrix" returned by makeCacheMatrix above. 
## If the inverse has already been calculated (and the matrix has not changed), then the cacheSolve 
## should retrieve the inverse from the cache
cacheSolve <- function(x, ...) {
  inverse <- x$getInverse()
  
  if (!is.null(inverse)) {
    message("getting cached inverse")
    return(inverse)
  }
  
  matrix <- x$get()
  inverse <- solve(matrix, ...)
  x$setInverse(inverse)
  
  inverse
}
