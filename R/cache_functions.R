StoreInCache <- function(key, value, CacheEnv) {
    ## Store a value in cache.
    ##
    ## Args:
    ##   key (character): The key to later retrieve the value.
    ##   value (object): An arbitrary object to be stored.
    ##   CacheEnv (environment): The environment to store the key into.
    if (is.numeric(key))
        key <- as.character(key)
    assign(key, value, envir = CacheEnv)
}

GetFromCache <-function(key, CacheEnv) {
    ## Retrieve value from cache
    ##
    ## Args:
    ##   key (character): The key to retrieve.
    ##   CacheEnv (environment): The environment to retrieve the key from.
    ##
    ## Returns:
    ##   object: An arbitrary object stored in the environment.
    if (is.numeric(key))
        key <- as.character(key)
    return (get(key, envir = CacheEnv, inherits = FALSE))
}

ExistsInCache <- function(key, CacheEnv) {
    ## Check whether key exists in cache.
    ##
    ## Args:
    ##   key (character): The key to retrieve.
    ##   CacheEnv (environment): The environment to retrieve the key from.
    ##
    ## Returns:
    ##   bool: `TRUE` if `key` exists in `CacheEnv` else `FALSE`.
    if (is.numeric(key))
        key <- as.character(key)
    return (exists(key, envir = CacheEnv, inherits = FALSE))
}
